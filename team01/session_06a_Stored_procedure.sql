/********************************************************************************************
  SECTION: STORED PROCEDURE TUTORIAL
  AUTHOR: Karthick AG
  PURPOSE: Learn how to create, execute, and understand stored procedures in MySQL
********************************************************************************************/

-- -----------------------------------------------------------------------------------------
-- Before proceeding, ensure that the database containing your tables is selected.
-- Example: USE mydatabase;
-- -----------------------------------------------------------------------------------------
USE team03;   -- Change 'mydatabase' to your actual database name


/********************************************************************************************
  STEP 1: SIMPLE STORED PROCEDURE
  Name   : get_all_users
  Purpose: Fetch all records from the 'users' table.
********************************************************************************************/

-- Drop the procedure if it already exists to avoid errors during creation
DROP PROCEDURE IF EXISTS get_all_users;

-- Create the procedure
DELIMITER $$          
CREATE PROCEDURE get_all_users01()
BEGIN
   
    SELECT user_id, user_name, email, age, status, created_at 
    FROM users;
END $$
DELIMITER ;           

-- Execute the stored procedure
CALL get_all_users();



/********************************************************************************************
  STEP 2: PARAMETERIZED STORED PROCEDURE
  Name   : get_user_by_id
  Purpose: Fetch details of a single user using their user_id
********************************************************************************************/

DROP PROCEDURE IF EXISTS get_user_by_id;

DELIMITER $$
CREATE PROCEDURE get_user_by_id(IN p_user_id INT)
BEGIN
    -- The parameter 'p_user_id' is provided when calling the procedure
    SELECT user_id, user_name, email, age, status, created_at
    FROM users
    WHERE user_id = p_user_id;
END $$
DELIMITER ;

-- Example usage:
CALL get_user_by_id(1);



/********************************************************************************************
  STEP 3: STORED PROCEDURE WITH INSERT OPERATION
  Name   : add_new_user
  Purpose: Insert a new user record into the 'users' table.
********************************************************************************************/

DROP PROCEDURE IF EXISTS add_new_user;

DELIMITER $$
CREATE PROCEDURE add_new_user(
    IN p_user_name VARCHAR(50),
    IN p_password VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_age INT
)
BEGIN
    -- Validate age using IF statement (optional example of logic inside procedures)
    IF p_age < 18 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'User must be at least 18 years old';
    ELSE
        INSERT INTO users (user_name, password, email, age)
        VALUES (p_user_name, p_password, p_email, p_age);
    END IF;
END $$
DELIMITER ;

-- Example usage:
CALL add_new_user('john_doe1', 'securepass123', 'john1@example.com', 25);



/********************************************************************************************
  STEP 4: STORED PROCEDURE WITH JOIN AND LOGIC
  Name   : get_orders_by_user
  Purpose: Fetch all orders and order amounts for a particular user.
********************************************************************************************/

DROP PROCEDURE IF EXISTS get_orders_by_user;

DELIMITER $$
CREATE PROCEDURE get_orders_by_user(IN p_user_id INT)
BEGIN
    SELECT 
        o.order_id,
        o.order_date,
        o.amount,
        u.user_name,
        u.email
    FROM orders o
    INNER JOIN users u ON o.user_id = u.user_id
    WHERE o.user_id = p_user_id;
END $$
DELIMITER ;

-- Example usage:
-- CALL get_orders_by_user(1);



/********************************************************************************************
  STEP 5: CHECK EXISTING PROCEDURES
********************************************************************************************/

-- List all stored procedures in the current database
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

-- View the code of a specific stored procedure
SHOW CREATE PROCEDURE get_all_users;

-- Delete (drop) a stored procedure if not needed
-- DROP PROCEDURE IF EXISTS get_all_users;



/********************************************************************************************
  SUMMARY:
  - get_all_users()        → Fetches all users.
  - get_user_by_id(id)     → Fetches a specific user by ID.
  - add_new_user(...)      → Adds a new user (with age validation).
  - get_orders_by_user(id) → Joins 'orders' and 'users' for order history.
********************************************************************************************/
