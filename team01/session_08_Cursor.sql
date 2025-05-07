use 1a;

-- Includes a CHECK constraint on age, default status, and auto-increment primary key
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,    -- Unique ID for each user
    user_name VARCHAR(50) UNIQUE NOT NULL,     -- Unique and non-null
    password VARCHAR(50) NOT NULL,             -- Non-null password
    email VARCHAR(100) UNIQUE NOT NULL,        -- Unique and non-null email
    age INT CHECK (age >= 18),                 -- Must be at least 18
    status VARCHAR(20) DEFAULT 'active',       -- Default status is 'active'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp set automatically
) ;

-- (Optional) Describe the 'orders' table (will fail if 'orders' doesn’t exist yet)
DESCRIBE orders;

-- Create the 'orders' table
-- References 'users(user_id)' for a foreign key
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,     -- Unique ID for each order
    user_id INT,           -- Links to 'users'
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Order creation time
    amount DECIMAL(10, 2) CHECK (amount > 0),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);



-- Create the 'products' table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,   -- Unique ID for each product
    product_name VARCHAR(100) NOT NULL,          -- Non-null product name
    price DECIMAL(10, 2) CHECK (price > 0),      -- Price must be positive
    stock INT CHECK (stock >= 0)                 -- Stock must be non-negative
);

-- Create the 'order_items' table
-- Links orders to products (many-to-many relationship)
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each order item
    order_id INT,                                  -- References 'orders'
    product_id INT,                                -- References 'products'
    quantity INT CHECK (quantity > 0),             -- Must be positive
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ==================================================
-- 3. Insert Dummy Data into Each Table
-- ==================================================

-- 3.1 Insert Records into 'users'
INSERT INTO users (user_name, password, email, age, status) VALUES
('john_doe',       'password123',  'john@example.com',   25, 'active'),
('alice_wonder',   'alice@pass',   'alice@example.com',  30, 'active'),
('mark_smith',     'mark@2024',    'mark@example.com',   28, 'inactive'),
('emily_davis',    'emily_pass',   'emily@example.com',  32, 'active'),
('james_bond',     '007@agent',    'james@example.com',  40, 'banned'),
('sophia_miller',  'sophia@pass',  'sophia@example.com', 27, 'active'),
('david_johnson',  'david@123',    'david@example.com',  35, 'active'),
('lucas_white',    'lucas_pass',   'lucas@example.com',  26, 'inactive'),
('olivia_brown',   'olivia@pass',  'olivia@example.com', 29, 'active'),
('ryan_green',     'ryan@2024',    'ryan@example.com',   31, 'active');

select * from users;

-- 3.2 Insert Records into 'orders'
INSERT INTO orders (user_id, order_date, amount) VALUES
(1,  '2024-01-10 10:30:00', 250.75),
(2,  '2024-01-12 15:45:00', 120.50),
(3,  '2024-01-15 08:20:00', 340.99),
(4,  '2024-01-18 12:00:00', 85.30),
(5,  '2024-01-20 14:10:00', 560.25),
(6,  '2024-01-22 18:30:00', 199.99),
(7,  '2024-01-25 11:45:00', 420.00),
(8,  '2024-01-28 16:50:00', 310.80),
(9,  '2024-01-30 09:15:00', 125.99),
(10, '2024-02-02 13:20:00', 275.60),
(1,  '2024-02-05 17:30:00', 90.50),
(3,  '2024-02-07 11:10:00', 189.20),
(5,  '2024-02-10 14:45:00', 470.99),
(7,  '2024-02-12 08:30:00', 320.75),
(9,  '2024-02-15 19:20:00', 145.99);

-- 3.3 Insert Records into 'products'
INSERT INTO products (product_name, price, stock) VALUES
('Laptop',               850.00, 15),
('Smartphone',           499.99, 30),
('Headphones',           79.99,  50),
('Gaming Console',       399.99, 20),
('Smartwatch',           199.99, 25),
('Tablet',               350.50, 18),
('Wireless Earbuds',     99.99,  40),
('External Hard Drive',  120.00, 12),
('Mechanical Keyboard',  140.75, 22),
('Gaming Mouse',         55.00,  35);

-- 3.4 Insert Records into 'order_items'
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,  1,  1),
(1,  3,  2),
(2,  2,  1),
(3,  5,  1),
(4,  7,  3),
(5,  4,  1),
(6,  6,  2),
(7,  9,  1),
(8,  10, 2),
(9,  8,  1),
(10, 5,  1),
(11, 2,  2),
(12, 6,  1),
(13, 3,  1),
(14, 4,  2);

select * from users;
select * from orders;
select * from products;
select * from order_items;

-- Set the delimiter to '//' so we can define a procedure without confusion with semicolons
DELIMITER //

-- Create the procedure to generate user order summaries
CREATE PROCEDURE user_order_summary()
BEGIN
    -- Declare local variables
    DECLARE done INT DEFAULT FALSE;        -- Flag to indicate the end of the cursor loop
    DECLARE uid INT;                       -- Variable to store user_id from the cursor
    DECLARE uname VARCHAR(50);             -- Variable to store user_name from the cursor
    DECLARE order_count INT;               -- Variable to store the count of orders for the user

    -- Declare the cursor to fetch user_id and user_name from the 'users' table
    DECLARE user_cursor CURSOR FOR 
        SELECT user_id, user_name FROM users;

    -- Declare a handler for the 'NOT FOUND' condition which will set 'done' to TRUE when no more rows are found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor to start fetching the data
    OPEN user_cursor;

    -- Start the loop to process each user from the cursor result set
    user_loop: LOOP
        -- Fetch the next user (user_id and user_name) into local variables
        FETCH user_cursor INTO uid, uname;

        -- If no more users are found, exit the loop
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- For the current user, get the total number of orders
        SELECT COUNT(*) INTO order_count 
        FROM orders WHERE user_id = uid;

        -- Output a summary of the user and their order count
        SELECT CONCAT('User: ', uname, ' has ', order_count, ' orders.') AS summary;
    END LOOP;

    -- Close the cursor after processing all users
    CLOSE user_cursor;
END //

-- Reset the delimiter back to the default semicolon
DELIMITER ;

-- Call the procedure to generate and display the order summary for each user
call user_order_summary();


-- This is a simple check for a specific user (user_id = 1)
-- It checks how many orders the user with id = 1 has made
SELECT COUNT(*) as order_count 
FROM orders WHERE user_id = 1;

-- Display all orders for user_id = 1
SELECT * FROM orders WHERE user_id = 1;

-- Create a report table to store user order summaries if it doesn't exist already
CREATE TABLE IF NOT EXISTS user_order_summary_report (
    user_id INT,                            -- Store the user ID
    user_name VARCHAR(50),                  -- Store the user name
    total_orders INT,                       -- Store the total number of orders the user has made
    report_generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp when the report is generated
);

-- Set the delimiter again to define the second procedure
DELIMITER //

-- Create the updated procedure for storing user order summaries into the report table
CREATE PROCEDURE user_order_summary_updated()
BEGIN
    -- Declare local variables
    DECLARE done INT DEFAULT FALSE;        -- Flag for the end of the cursor loop
    DECLARE uid INT;                       -- Variable for user_id from the cursor
    DECLARE uname VARCHAR(50);             -- Variable for user_name from the cursor
    DECLARE order_count INT;               -- Variable for the count of orders per user

    -- Declare the cursor to fetch user_id and user_name from the 'users' table
    DECLARE user_cursor CURSOR FOR 
        SELECT user_id, user_name FROM users;

    -- Declare a handler for the 'NOT FOUND' condition
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Clean old report data from the report table (optional, to keep only the latest data)
    DELETE FROM user_order_summary_report;

    -- Open the cursor to start processing the user data
    OPEN user_cursor;

    -- Start processing each user in the cursor result set
    user_loop: LOOP
        -- Fetch the next user (user_id, user_name) into the local variables
        FETCH user_cursor INTO uid, uname;

        -- If no more rows, exit the loop
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- Get the total order count for the current user
        SELECT COUNT(*) INTO order_count 
        FROM orders WHERE user_id = uid;

        -- Insert the user's order summary into the report table
        INSERT INTO user_order_summary_report (user_id, user_name, total_orders)
        VALUES (uid, uname, order_count);
    END LOOP;

    -- Close the cursor after processing all users
    CLOSE user_cursor;
END //

-- Reset the delimiter to the default semicolon
DELIMITER ;

-- Now, we can call the updated procedure to populate the report table
call user_order_summary_updated();


-- Select all rows from the user_order_summary_report table to view the generated reports
SELECT * FROM user_order_summary_report;

