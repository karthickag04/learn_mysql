/*
--------------------------------------------------------------------------
 Title: MySQL UPDATE Tutorial
 Description: 
   1) Creates a test database and two tables: employees, departments.
   2) Inserts sample data.
   3) Demonstrates several kinds of UPDATE queries:
      - Simple UPDATE
      - Updating multiple columns
      - Using conditions
      - Using JOIN to update based on another table
      - Using transactions (START TRANSACTION, COMMIT, ROLLBACK)
   4) Optionally shows how to drop everything at the end.
--------------------------------------------------------------------------
*/


use team01;
show tables;

select * from users;






-- Updating a user's username based on user_id

UPDATE users SET user_name = 'Ravi' WHERE user_id = 1;
select * from users;

-- Updates the username of the user with user_id = 1 to 'new_username'





-- Updating a user's email and status together based on user_id
UPDATE users SET email = 'ramu_new@example.com', status = 'inactive' WHERE user_id = 2;
select * from users;
-- Changes both email and status of user with user_id = 2


-- will be updated to all the records if you did not provide where condition , so mistakenly all the records will be updated with the given value
UPDATE users SET  status = 'inactive'; -- error

-- Updating the password for all users to enforce a security policy
UPDATE users 
SET password = 'SecurePass@123'; -- error
-- Updates the password field for all users (Use with caution!)

-- Updating multiple users' status based on their age
UPDATE users SET status = 'active' WHERE age > 30;
-- Sets the status to 'active' for all users above the age of 30

select * from orders;
-- Increasing the order amount for a specific order
UPDATE orders SET amount = amount + 50.00 WHERE order_id = 1;
-- Increases the amount of order_id = 1 by 50.00

-- Updating order date to reflect a rescheduled delivery
UPDATE orders 
SET order_date = '2025-01-25 14:00:00' 
WHERE order_id = 2;
-- Updates the order date for order_id = 2 to a new date and time

-- Updating the amount for all orders made by a specific user
UPDATE orders SET amount = amount * 1.10 WHERE user_id = 1;
-- Increases all orders made by user_id = 1 by 10%
SELECT DISTINCT user_id FROM orders;
SELECT * FROM orders;
SELECT * FROM users;
-- Updating the user status to 'inactive' if they have no orders
UPDATE users SET status = 'inactive' WHERE user_id  not IN (SELECT DISTINCT user_id FROM orders);
-- Changes status to 'inactive' for users who have no orders in the orders table

-- Resetting all inactive users to active
UPDATE users  SET status = 'active' WHERE status = 'inactive';
-- Re-activates all users who were marked as 'inactive'

-- Assigning a default order amount for orders with null or zero amount
UPDATE orders  SET amount = 100.00 WHERE amount IS NULL OR amount = 0;
-- Sets the order amount to 100.00 where it's either NULL or 0

-- Updating a user's phone number (assuming the column exists)
UPDATE users SET phone_number = '9876543210' WHERE user_id = 3;
-- Updates the phone number for the user with user_id = 3 (column must exist)

-- Updating an order's amount based on a discount condition
UPDATE orders SET amount = amount * 0.90 WHERE amount > 500;
-- Applies a 10% discount to all orders where the amount is greater than 500

-- Updating an order by changing the associated user (reassigning order)
UPDATE orders SET user_id = 5 WHERE order_id = 3;
-- Changes the owner of order_id = 3 to user_id = 5

SELECT user_id FROM users WHERE age < 25;

-- Updating order amount based on user’s age condition
UPDATE orders SET amount = amount - 20 WHERE user_id IN (SELECT user_id FROM users WHERE age < 25);
-- Reduces the amount by 20 for orders placed by users under 25 years old

-- Updating all records in 'orders' to set a common tax of 5% on the amount
UPDATE orders  SET amount = amount * 1.05;
-- Adds a 5% tax to all order amounts

-- Updating order amount and order date together
UPDATE orders SET amount = 300.50, order_date = '2025-02-01 12:00:00'  WHERE order_id = 4;
-- Changes both the amount and order date for order_id = 4

select * from users;

SELECT 
    user_id, first_name, last_name,     CONCAT(first_name, ' ', last_name) AS full_name 
FROM users;


-- Updating usernames by appending '_old' for all inactive users
UPDATE users SET user_name = CONCAT(user_name, '_old') WHERE status = 'active';
-- Appends '_old' to usernames of inactive users to mark them as outdated

-- Updating all orders of user_id = 2 to have a standard order_date
UPDATE orders 
SET order_date = '2025-01-30 10:00:00' 
WHERE user_id = 2;
-- Changes the order date for all orders belonging to user_id = 2

-- Increasing all order amounts by 15% but only for orders placed in 2025
UPDATE orders 
SET amount = amount * 1.15 
WHERE YEAR(order_date) = 2025;
-- Applies a 15% increase to all orders placed in the year 2025
