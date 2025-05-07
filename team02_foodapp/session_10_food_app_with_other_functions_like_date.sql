use foodapp1;

-- Get the current date
SELECT CURDATE();

-- Get the current date and time
SELECT NOW();

-- Format a date
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s');

-- Add 7 days to the current date
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY);

-- Calculate the difference between two dates
SELECT DATEDIFF('2024-12-31', '2024-01-01');

-- Concatenate strings
SELECT CONCAT('Hello, ', 'world!');

-- Get a substring from a string
SELECT SUBSTRING('Hello, world!', 1, 5);

-- Round a number to 2 decimal places
SELECT ROUND(123.456, 2);

-- Get the length of a string
SELECT LENGTH('Hello, world!');

-- Convert a string to uppercase
SELECT UPPER('Hello, world!');

-- Select customers who have placed orders
SELECT name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- Select the highest order total for each customer
SELECT customer_id, (SELECT MAX(total_amount) FROM orders WHERE orders.customer_id = customers.customer_id) AS max_order_total
FROM customers;
