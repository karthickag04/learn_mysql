-- ========================================
-- SQL Script: MySQL Functions & Queries Demo
-- Database: foodapp1
-- Purpose: Demonstrate usage of built-in functions and subqueries
-- ========================================

-- Step 1: Select the database to work with
USE foodapp1;

-- ============================
-- Date and Time Functions
-- ============================

-- Get the current date
SELECT CURDATE() AS today;

-- Get the current date and time
SELECT NOW() AS current_datetime;

-- Format current date and time in 'YYYY-MM-DD HH:MM:SS' format
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') AS formatted_now;

-- Add 7 days to the current date
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY) AS date_plus_7;

-- Subtract 30 days from the current date
SELECT DATE_SUB(CURDATE(), INTERVAL 30 DAY) AS date_minus_30;

-- Calculate the number of days between two dates
SELECT DATEDIFF('2024-12-31', '2024-01-01') AS days_between;

-- Calculate number of days between two arbitrary dates (e.g., age calculation)
SELECT DATEDIFF('2025-04-25', '2005-01-01') AS total_days_lived;

-- Extract components from a date
SELECT YEAR(NOW()) AS current_year, MONTH(NOW()) AS current_month, DAY(NOW()) AS current_day;

-- Get the day name (e.g., Monday, Tuesday)
SELECT DAYNAME(NOW()) AS today_dayname;

-- Get the day of the week (1 = Sunday, 7 = Saturday)
SELECT DAYOFWEEK(NOW()) AS weekday_number;

-- ============================
-- String Functions
-- ============================

-- Concatenate strings
SELECT CONCAT('Hello, ', 'world!') AS greeting;

-- Concatenate with separator
SELECT CONCAT_WS('-', '2025', '04', '25') AS formatted_date;

-- Get a substring (first 5 characters)
SELECT SUBSTRING('Hello, world!', 1, 5) AS sub_string;

-- Get string length in bytes
SELECT LENGTH('Hello, world!') AS length_bytes;

-- Get string length in characters (important for UTF-8)
SELECT CHAR_LENGTH('Hello, world!') AS length_characters;

-- Convert string to uppercase
SELECT UPPER('Hello, world!') AS upper_text;

-- Convert string to lowercase
SELECT LOWER('Hello, WORLD!') AS lower_text;

-- Replace part of a string
SELECT REPLACE('Hello, John!', 'John', 'Jane') AS replaced_string;

-- Trim spaces from a string
SELECT TRIM('   Hello World   ') AS trimmed;

-- Reverse a string
SELECT REVERSE('Hello') AS reversed_string;

-- ============================
-- Numeric Functions
-- ============================

-- Round a number to 2 decimal places
SELECT ROUND(123.456, 2) AS rounded;

-- Find the largest number
SELECT GREATEST(10, 29, 40) AS max_value;

-- Find the smallest number
SELECT LEAST(10, 29, 40) AS min_value;

-- Get absolute value
SELECT ABS(-123.45) AS absolute_value;

-- Generate random number between 0 and 1
SELECT RAND() AS random_number;

-- Power of a number (2 raised to 3)
SELECT POW(2, 3) AS power_example;

-- Square root of a number
SELECT SQRT(64) AS square_root;

-- Modulo (remainder)
SELECT MOD(10, 3) AS modulo_result;

-- ============================
-- Conditional & Control Functions
-- ============================

-- Use IF to return conditional values
SELECT IF(10 > 5, 'Yes', 'No') AS is_greater;

-- Use CASE to return conditions like switch/case
SELECT 
  CASE 
    WHEN HOUR(NOW()) < 12 THEN 'Good Morning'
    WHEN HOUR(NOW()) < 18 THEN 'Good Afternoon'
    ELSE 'Good Evening'
  END AS greeting_time;

-- ============================
-- Subqueries and Joins
-- ============================

-- Get customers who have placed orders (subquery with IN)
SELECT name
FROM customers
WHERE customer_id IN (
  SELECT customer_id FROM orders
);

-- Get the highest order total per customer using a correlated subquery
SELECT 
  customer_id, 
  (SELECT MAX(total_amount) 
   FROM orders 
   WHERE orders.customer_id = customers.customer_id
  ) AS max_order_total
FROM customers;

-- Get total number of orders for each customer using a correlated subquery
SELECT 
  customer_id,
  (SELECT COUNT(*) FROM orders WHERE orders.customer_id = customers.customer_id) AS order_count
FROM customers;

-- Get customers with total order amount over 500 using a subquery in HAVING
SELECT 
  o.customer_id,
  c.name,
  SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id
HAVING total_spent > 500;

-- ============================
-- End of Script
-- ============================

-- You can now explore and test these functions on your own tables!
