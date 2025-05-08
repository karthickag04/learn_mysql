-- ========================================
-- STORED PROCEDURES
-- ========================================

-- 1. Get all orders by user ID
DELIMITER //
CREATE PROCEDURE GetOrdersByUser(IN uid INT)
BEGIN
    SELECT * FROM orders WHERE user_id = uid;
END;
//
DELIMITER ;

-- 2. Insert new product
DELIMITER //
CREATE PROCEDURE AddProduct(
    IN pname VARCHAR(100),
    IN pprice DECIMAL(10,2),
    IN pstock INT
)
BEGIN
    INSERT INTO products (product_name, price, stock)
    VALUES (pname, pprice, pstock);
END;
//
DELIMITER ;

-- 3. Update stock after order (manual call)
DELIMITER //
CREATE PROCEDURE UpdateStock(IN pid INT, IN qty INT)
BEGIN
    UPDATE products SET stock = stock - qty WHERE product_id = pid;
END;
//
DELIMITER ;

-- 4. Delete inactive users
DELIMITER //
CREATE PROCEDURE DeleteInactiveUsers()
BEGIN
    DELETE FROM users WHERE status = 'inactive';
END;
//
DELIMITER ;

-- 5. Calculate total sales for a product
DELIMITER //
CREATE PROCEDURE TotalSalesByProduct(IN pid INT)
BEGIN
    SELECT SUM(oi.quantity * p.price) AS total_sales
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE oi.product_id = pid;
END;
//
DELIMITER ;


-- ========================================
-- TRIGGERS
-- ========================================

-- 1. Update stock when new order item is added
DELIMITER //
CREATE TRIGGER trg_update_stock AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END;
//
DELIMITER ;

-- 2. Log user status change
CREATE TABLE IF NOT EXISTS user_status_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_status_change BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO user_status_log (user_id, old_status, new_status)
        VALUES (OLD.user_id, OLD.status, NEW.status);
    END IF;
END;
//
DELIMITER ;

-- 3. Prevent order from banned users
DELIMITER //
CREATE TRIGGER trg_prevent_banned BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE ustatus VARCHAR(20);
    SELECT status INTO ustatus FROM users WHERE user_id = NEW.user_id;
    IF ustatus = 'banned' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Banned users cannot place orders';
    END IF;
END;
//
DELIMITER ;

-- 4. Log deleted users
CREATE TABLE IF NOT EXISTS deleted_users (
    user_id INT,
    user_name VARCHAR(50),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_log_deleted_users BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO deleted_users (user_id, user_name)
    VALUES (OLD.user_id, OLD.user_name);
END;
//
DELIMITER ;

-- 5. Enforce @example.com email domain
DELIMITER //
CREATE TRIGGER trg_check_email BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@example.com' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email must be from @example.com domain';
    END IF;
END;
//
DELIMITER ;


-- ========================================
-- VIEWS
-- ========================================

-- 1. View of active users
CREATE OR REPLACE VIEW active_users AS
SELECT * FROM users WHERE status = 'active';

-- 2. View of order summary with user name
CREATE OR REPLACE VIEW order_summary AS
SELECT o.order_id, u.user_name, o.order_date, o.amount
FROM orders o
JOIN users u ON o.user_id = u.user_id;

-- 3. Low stock products (less than 10)
CREATE OR REPLACE VIEW low_stock_products AS
SELECT * FROM products WHERE stock < 10;

-- 4. Top-selling products
CREATE OR REPLACE VIEW top_selling_products AS
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC;

-- 5. User order count
CREATE OR REPLACE VIEW user_order_count AS
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id;


-- ========================================
-- CURSORS
-- ========================================

-- 1. Apply 10% discount on orders over 500
DELIMITER //
CREATE PROCEDURE ApplyDiscounts()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE oid INT;
    DECLARE amt DECIMAL(10,2);
    DECLARE cur CURSOR FOR SELECT order_id, amount FROM orders WHERE amount > 500;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO oid, amt;
        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE orders SET amount = amt * 0.9 WHERE order_id = oid;
    END LOOP;
    CLOSE cur;
END;
//
DELIMITER ;

-- 2. Print total spent by each user
DELIMITER //
CREATE PROCEDURE PrintUserSpending()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE uname VARCHAR(50);
    DECLARE total DECIMAL(10,2);
    DECLARE cur CURSOR FOR
        SELECT u.user_name, SUM(o.amount)
        FROM users u JOIN orders o ON u.user_id = o.user_id
        GROUP BY u.user_name;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO uname, total;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT(uname, ' spent ₹', total) AS result;
    END LOOP;
    CLOSE cur;
END;
//
DELIMITER ;

-- 3. Update status of users with no orders
DELIMITER //
CREATE PROCEDURE MarkNoOrders()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE uid INT;
    DECLARE cur CURSOR FOR
        SELECT user_id FROM users WHERE user_id NOT IN (SELECT DISTINCT user_id FROM orders);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO uid;
        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE users SET status = 'inactive' WHERE user_id = uid;
    END LOOP;
    CLOSE cur;
END;
//
DELIMITER ;

-- 4. Find users who ordered same product multiple times
DELIMITER //
CREATE PROCEDURE RepeatedOrders()
BEGIN
    SELECT user_id, product_id, COUNT(*) AS times_ordered
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY user_id, product_id
    HAVING times_ordered > 1;
END;
//
DELIMITER ;

-- 5. List users who bought a specific product
DELIMITER //
CREATE PROCEDURE UsersByProduct(IN pid INT)
BEGIN
    SELECT DISTINCT u.user_id, u.user_name
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = pid;
END;
//
DELIMITER ;
