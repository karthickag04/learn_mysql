-- Create a new database named 'team01'
CREATE DATABASE team01;

-- Switch to the 'team01' database to start working with it
USE team01;

-- Create the 'users' table with defined constraints
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT, -- Automatically increments the primary key for unique identification
    username VARCHAR(50) UNIQUE NOT NULL, -- Ensures the username is unique and cannot be null
    password VARCHAR(50) NOT NULL, -- Ensures the password is not null
    email VARCHAR(100) UNIQUE NOT NULL, -- Ensures the email is unique and cannot be null
    age INT CHECK (age >= 18), -- Ensures the age is 18 or older using a CHECK constraint
    status VARCHAR(20) DEFAULT 'active', -- Sets a default value of 'active' for the status column
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Automatically sets the current timestamp when a new record is created
);

-- Create the 'orders' table with a foreign key constraint
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT, -- Automatically increments the primary key for unique identification
    user_id INT, -- References the 'user_id' column in the 'users' table
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically sets the current timestamp for order date
    amount DECIMAL(10, 2) CHECK (amount > 0), -- Ensures the order amount is positive
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- Ensures that 'user_id' exists in the 'users' table
);

-- Insert a valid record into the 'users' table
INSERT INTO users (username, password, email, age, status)
VALUES
    ('ramu', 'password123', 'ramu@example.com', 25, 'active');

-- Select and display all records from the 'users' table
SELECT * FROM users;

-- Insert a new record into the 'users' table with all required fields
INSERT INTO users (username, password, email, status)
VALUES
    ('ramu1', 'password123', 'ramu1@example.com', 'active');

-- Insert a new record into the 'users' table without providing an optional field (age)
INSERT INTO users (username, password, email)
VALUES
    ('ramu2', 'password123', 'ramu2@example.com');

-- Attempt to insert a record without providing the mandatory 'username' field
-- This will throw an error because 'username' is defined as NOT NULL
INSERT INTO users (password, email, age, status)
VALUES
    ('password123', 'ramu@example.com', 25, 'active');

-- Attempt to insert a duplicate username
-- This will throw an error because 'username' is defined as UNIQUE
INSERT INTO users (username, password, email, age, status)
VALUES
    ('ramu', 'password123', 'ramu@example.com', 25, 'active');

-- Insert multiple valid records into the 'users' table in a single query
INSERT INTO users (username, password, email, age, status)
VALUES
    ('ramu4', 'password123', 'ramu4@example.com', 25, 'active'),
    ('raju', 'password456', 'raju@example.com', 30, 'active'),
    ('ravi', 'password789', 'ravi@example.com', 22, 'inactive');

-- Insert a valid record into the 'orders' table
-- This order references 'user_id' = 1 (ramu) from the 'users' table
INSERT INTO orders (user_id, order_date, amount)
VALUES
    (1, '2025-01-24 10:00:00', 100.50);

-- Select and display all records from the 'orders' table
SELECT * FROM orders;

-- Select and display all records from the 'users' table
SELECT * FROM users;

-- Attempt to insert an order with a 'user_id' that does not exist in the 'users' table
-- This will throw a foreign key constraint violation error because 'user_id' = 9 does not exist
INSERT INTO orders (user_id, order_date, amount)
VALUES
    (9, '2025-01-24 10:00:00', 100.50);

-- Insert multiple valid records into the 'orders' table in a single query
-- Each order references a valid 'user_id' from the 'users' table
INSERT INTO orders (user_id, order_date, amount)
VALUES
    (1, '2025-01-24 10:00:00', 100.50), -- Order for 'ramu' (user_id = 1)
    (2, '2025-01-24 11:00:00', 150.75), -- Order for 'raju' (user_id = 2)
    (3, '2025-01-24 12:00:00', 200.00); -- Order for 'ravi' (user_id = 3)

-- Use a JOIN to display combined data from 'users' and 'orders' tables
-- Matches records where 'user_id' in 'orders' references 'user_id' in 'users'
SELECT * FROM users JOIN orders ON users.user_id = orders.user_id;

-- Select and display specific columns (user_id and username) from the 'users' table
SELECT user_id, username FROM users;

-- Remove all records from the 'orders' table without resetting the auto-increment value
TRUNCATE TABLE orders;

-- Delete all records from the 'orders' table
-- Unlike TRUNCATE, DELETE allows using a WHERE condition, but here it's applied to the whole table
DELETE FROM orders;

-- Select and display all records from the 'orders' table to confirm deletion
SELECT * FROM orders;

-- Delete records from the 'users' table where 'user_id' is greater than 2 and 'age' equals 25
DELETE FROM users WHERE user_id > 2 AND age = 25;
