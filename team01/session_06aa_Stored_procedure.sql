use team05;


DELIMITER $$

CREATE PROCEDURE sp_add_user (IN p_user_name VARCHAR(50), IN p_password VARCHAR(50),IN p_email VARCHAR(100), IN p_age INT,IN p_status VARCHAR(20))
BEGIN
    INSERT INTO users (user_name, password, email, age, status)
    VALUES (p_user_name, p_password, p_email, p_age, p_status);
END $$

DELIMITER ;

call sp_add_user("Ragu","Ragu@123","Ragu@gmail.com",23,"active");

call sp_add_user("Ragu1","Ragu@1231","Ragu1@gmail.com",23,"active");



-- 2. Procedure — Insert into orders

DELIMITER $$

CREATE PROCEDURE sp_add_order (
    IN p_user_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO orders (user_id, amount)
    VALUES (p_user_id, p_amount);
END $$

DELIMITER ;


CALL sp_add_order(1, 199.99);


-- 3. Procedure — Insert into products

DELIMITER $$

CREATE PROCEDURE sp_add_product (
    IN p_product_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_stock INT
)
BEGIN
    INSERT INTO products (product_name, price, stock)
    VALUES (p_product_name, p_price, p_stock);
END $$

DELIMITER ;

CALL sp_add_product('Bluetooth Speaker', 59.99, 20);


-- 4. Procedure — Insert into order_items

DELIMITER $$

CREATE PROCEDURE sp_add_order_item (
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    INSERT INTO order_items (order_id, product_id, quantity)
    VALUES (p_order_id, p_product_id, p_quantity);
END $$

DELIMITER ;

CALL sp_add_order_item(1, 2, 3);