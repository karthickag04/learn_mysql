-- Drop existing tables if needed (CAUTION: this deletes data)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

-- Create the 'users' table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT CHECK (age >= 18),
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'orders' table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) CHECK (amount > 0),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create the 'products' table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0)
);

-- Create the 'order_items' table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample Data
INSERT INTO users (user_name, password, email, age, status) VALUES
('john_doe',       'password123',  'john@example.com',   25, 'active'),
('alice_wonder',   'alice@pass',   'alice@example.com',  30, 'active');

INSERT INTO products (product_name, price, stock) VALUES
('Laptop', 850.00, 15),
('Headphones', 79.99, 50);

INSERT INTO orders (user_id, order_date, amount) VALUES
(1, NOW(), 250.75);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2);

-- ===========================
-- TRIGGERS FOR PRACTICE
-- ===========================

-- 1. BEFORE INSERT on users – force lowercase email
DELIMITER $$
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(NEW.email);
END;
$$
DELIMITER ;

-- 2. AFTER INSERT on orders – log to a simple order_audit table
CREATE TABLE IF NOT EXISTS order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    user_id INT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    message TEXT
);

DELIMITER $$
CREATE TRIGGER after_insert_orders
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (order_id, user_id, message)
    VALUES (NEW.order_id, NEW.user_id, CONCAT('Order placed for amount ', NEW.amount));
END;
$$
DELIMITER ;

-- 3. BEFORE UPDATE on users – prevent changing status from 'banned'
DELIMITER $$
CREATE TRIGGER before_update_users
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF OLD.status = 'banned' AND NEW.status != 'banned' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot change status from banned';
    END IF;
END;
$$
DELIMITER ;

-- 4. AFTER UPDATE on products – log stock change
CREATE TABLE IF NOT EXISTS stock_change_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    old_stock INT,
    new_stock INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_update_products
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.stock != NEW.stock THEN
        INSERT INTO stock_change_log (product_id, old_stock, new_stock)
        VALUES (NEW.product_id, OLD.stock, NEW.stock);
    END IF;
END;
$$
DELIMITER ;

-- 5. BEFORE DELETE on products – prevent delete if stock > 0
DELIMITER $$
CREATE TRIGGER before_delete_products
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    IF OLD.stock > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product with stock remaining';
    END IF;
END;
$$
DELIMITER ;

-- 6. AFTER DELETE on order_items – log deleted order item
CREATE TABLE IF NOT EXISTS order_items_deleted (
    deleted_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_delete_order_items
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    INSERT INTO order_items_deleted (order_id, product_id, quantity)
    VALUES (OLD.order_id, OLD.product_id, OLD.quantity);
END;
$$
DELIMITER ;

-- Done! You can test triggers by inserting, updating, and deleting data.
