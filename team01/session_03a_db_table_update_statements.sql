-- ========================================
-- SQL Script: Update Users and Display Data
-- Description: Demonstrates table selection,
--              conditional updates using CASE,
--              and best practices with comments
-- ========================================

-- Step 1: Use the target database
USE a01a;

-- Step 2: Show all tables in the selected database
SHOW TABLES;

-- Step 3: View all users
SELECT * FROM users;

-- Step 4: View all orders
SELECT * FROM orders;

-- Step 5: View all products
SELECT * FROM products;

-- ------------------------------------------------
-- Step 6: Update a single user's username
-- Updates the username for user with user_id = 1
-- ------------------------------------------------
UPDATE users 
SET username = "ravi kumar" 
WHERE user_id = 1;

-- ----------------------------------------------------------
-- Step 7: Update username and password for user_id = 1
-- Shows how to update multiple columns at once
-- ----------------------------------------------------------
UPDATE users 
SET username = "ravi kumar", 
    password = "Welcome" 
WHERE user_id = 1;

-- ---------------------------------------------------------------------------------
-- Step 8: Update multiple users using CASE statements
-- Only user_id = 1 and 2 will be updated due to WHERE clause
-- Demonstrates conditional logic per row
-- ---------------------------------------------------------------------------------
UPDATE users 
SET 
    username = CASE user_id
        WHEN 1 THEN "Vinoth" 
        WHEN 2 THEN "vinitha" 
        WHEN 3 THEN "Mahesh" -- Note: won't be applied since user_id 3 not in WHERE
    END,
    
    password = CASE user_id
        WHEN 1 THEN "Password@123"
        WHEN 2 THEN "Welcome@123"
        WHEN 3 THEN "test@123"
    END

WHERE user_id IN (1, 2);

-- -------------------------------------------------------------------------------------
-- Step 9: Update usernames and statuses conditionally
-- Applies update to all users with user_id < 10
-- Uses ELSE to preserve data or set defaults for others
-- -------------------------------------------------------------------------------------
UPDATE users 
SET 
    username = CASE user_id
        WHEN 1 THEN "Vinoth1" 
        WHEN 2 THEN "vinitha1" 
        ELSE username -- Preserve existing username
    END,

    status = CASE user_id
        WHEN 1 THEN "test@123"
        WHEN 2 THEN "test01@123"
        ELSE "inactive" -- Set others to inactive
    END

WHERE user_id < 10;

-- Step 10: View the final users table after updates
SELECT * FROM users;

-- Step 11: View the orders table again if needed
SELECT * FROM orders;

-- ========================================
-- Optional Best Practice (Uncomment if needed)
-- Backup users table before updates
-- ========================================
-- CREATE TABLE users_backup AS SELECT * FROM users;

-- Done!
