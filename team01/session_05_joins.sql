-- ===================================================
-- 1. Select and Show Database/Tables (Optional Steps)
-- ===================================================
USE team01;                  -- Switch to the 'team01' database
SHOW TABLES;                 -- Shows tables in 'team01' (may be empty if no tables exist yet)

-- If you already have a 'users' table, this DESCRIBE will work; otherwise, it will throw an error.
DESCRIBE users;             -- Describes the structure of 'users' (if it exists)

-- Attempting to drop a column that may not exist (phone_number).
-- If you haven't created 'users' with a phone_number column, this will fail.
ALTER TABLE users 
    DROP COLUMN phone_number;  -- Demonstration of altering a table (remove if phone_number never existed).


-- =========================================
-- 2. Create Tables for the Demonstration
-- =========================================

-- Create the 'users' table
-- Includes a CHECK constraint on age, default status, and auto-increment primary key
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,    -- Unique ID for each user
    user_name VARCHAR(50) UNIQUE NOT NULL,     -- Unique and non-null
    password VARCHAR(50) NOT NULL,             -- Non-null password
    email VARCHAR(100) UNIQUE NOT NULL,        -- Unique and non-null email
    age INT CHECK (age >= 18),                 -- Must be at least 18
    status VARCHAR(20) DEFAULT 'active',       -- Default status is 'active'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Timestamp set automatically
);

-- (Optional) Describe the 'orders' table (will fail if 'orders' doesn’t exist yet)
DESCRIBE orders;

-- Create the 'orders' table
-- References 'users(user_id)' for a foreign key
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,     -- Unique ID for each order
    user_id INT,                                 -- Links to 'users'
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Order creation time
    amount DECIMAL(10, 2) CHECK (amount > 0),    -- Order amount must be positive
    FOREIGN KEY (user_id) REFERENCES users(user_id)  -- Enforce user existence
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


-- =========================================
-- 4. Basic Verification Commands and Queries
-- =========================================

-- Show tables in the current database
SHOW TABLES;

-- Example: Select orders with amount < 200
SELECT *
FROM team01.orders
WHERE amount < 200;

-- Example: Cross-table SELECT using old-style comma syntax (Cartesian product if no WHERE)
SELECT *
FROM users u, orders o
WHERE u.user_id = o.user_id;

-- Example: Standard INNER JOIN 
SELECT *
FROM users u 
INNER JOIN orders o ON u.user_id = o.user_id;

-- Example: Filtered join by specific date
SELECT u.user_id, o.amount, o.order_date 
FROM users u 
INNER JOIN orders o ON u.user_id = o.user_id 
WHERE o.order_date = '2024-01-12 15:45:00';

-- Check 'order_items' table data
SELECT * FROM order_items;

-- Join across multiple tables
SELECT *
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;


-- A more readable multi-table SELECT with aliases
SELECT 
    u.user_id          AS "USER ID", 
    o.order_id         AS "ORDER ID", 
    p.product_name     AS "PRODUCT NAME",
    p.price            AS "ACTUAL PRICE", 
    o.amount           AS "PURCHASED PRICE", 
    o.order_date       AS "ORDER DATE"
FROM users u
INNER JOIN orders o        ON u.user_id = o.user_id
INNER JOIN order_items oi  ON o.order_id = oi.order_id
INNER JOIN products p      ON oi.product_id = p.product_id;


-- =====================================================
-- 5. Demonstration of Various SQL JOIN Types
-- =====================================================

-- 5.1 INNER JOIN: Get all orders with user details
-- Only shows records where user_id in 'orders' matches a user in 'users'.
SELECT 
    orders.order_id, 
    users.user_name, 
    orders.order_date, 
    orders.amount
FROM orders
INNER JOIN users ON orders.user_id = users.user_id;

-- 5.2 LEFT JOIN: Get all users and their orders (if any)
-- Includes users even if they have no orders.
SELECT 
    users.user_name, 
    orders.order_id, 
    orders.order_date, 
    orders.amount
FROM users
LEFT JOIN orders ON users.user_id = orders.user_id;

-- 5.3 RIGHT JOIN: Get all orders and their associated users (if any)
-- Ensures all orders are listed, even if the user_id doesn't match.
SELECT 
    orders.order_id, 
    users.user_name, 
    orders.order_date, 
    orders.amount
FROM orders
RIGHT JOIN users ON orders.user_id = users.user_id;

-- 5.4 FULL JOIN (using UNION): Get all users and orders with matches
-- MySQL doesn't support FULL OUTER JOIN, so we combine LEFT and RIGHT with UNION.
SELECT 
    users.user_name, 
    orders.order_id, 
    orders.order_date, 
    orders.amount
FROM users
LEFT JOIN orders ON users.user_id = orders.user_id
UNION
SELECT 
    users.user_name, 
    orders.order_id, 
    orders.order_date, 
    orders.amount
FROM users
RIGHT JOIN orders ON users.user_id = orders.user_id;

-- 5.5 CROSS JOIN: Get all possible combinations (Cartesian product)
SELECT 
    users.user_name, 
    products.product_name
FROM users
CROSS JOIN products;

-- 5.6 SELF JOIN: Get all users who have the same status
-- Example of comparing rows within the same table.
SELECT 
    a.user_name AS user1, 
    b.user_name AS user2, 
    a.status
FROM users a, users b
WHERE a.status = b.status 
  AND a.user_id <> b.user_id;

-- 5.7 JOIN Multiple Tables: Retrieve order details including product names
SELECT 
    users.user_name, 
    orders.order_id, 
    products.product_name, 
    order_items.quantity, 
    orders.amount
FROM users
INNER JOIN orders         ON users.user_id = orders.user_id
INNER JOIN order_items    ON orders.order_id = order_items.order_id
INNER JOIN products       ON order_items.product_id = products.product_id;

-- 5.8 LEFT JOIN with NULL Handling: Find users who haven't placed any orders
SELECT 
    users.user_name, 
    orders.order_id
FROM users
LEFT JOIN orders ON users.user_id = orders.user_id
WHERE orders.order_id IS NULL;
