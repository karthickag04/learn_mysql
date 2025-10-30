/********************************************************************************************
  SECTION: SQL VIEWS TUTORIAL
  AUTHOR : Karthick AG
  PURPOSE: Learn how to create, use, and understand SQL Views in MySQL
********************************************************************************************/

-- -----------------------------------------------------------------------------------------
-- A "VIEW" in SQL is like a **virtual table**.
-- It stores a saved SQL SELECT query that you can reuse just like a real table.
-- Views help to:
--   ✅ Simplify complex joins
--   ✅ Improve readability
--   ✅ Control data access (security)
-- -----------------------------------------------------------------------------------------

USE team03;   -- Change 'mydatabase' to your actual database name


/********************************************************************************************
  STEP 1: CREATE SIMPLE VIEW
  Name   : view_active_users
  Purpose: Display all users whose status is 'active'
********************************************************************************************/

-- Drop the view if it already exists (avoids errors on re-run)
DROP VIEW IF EXISTS view_active_users;

-- Create the view
CREATE VIEW view_active_users AS
SELECT 
    user_id,
    user_name,
    email,
    age,
    status,
    created_at
FROM users
WHERE status = 'active';

-- Now, you can query the view like a normal table
SELECT * FROM view_active_users;



/********************************************************************************************
  STEP 2: CREATE VIEW WITH JOIN
  Name   : view_user_orders
  Purpose: Show user information along with their order details
********************************************************************************************/

DROP VIEW IF EXISTS view_user_orders;

CREATE VIEW view_user_orders AS
SELECT 
    u.user_id,
    u.user_name,
    u.email,
    o.order_id,
    o.order_date,
    o.amount
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id;

-- View data from the joined tables
SELECT * FROM view_user_orders;



/********************************************************************************************
  STEP 3: OPTIONAL — CHECK CREATED VIEWS
********************************************************************************************/

-- List all views in the current database
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- See the SQL definition (query) of a specific view
SHOW CREATE VIEW view_user_orders;



/********************************************************************************************
  STEP 4: CLEANUP (IF NEEDED)
********************************************************************************************/

-- Drop (delete) a view if no longer needed
-- DROP VIEW IF EXISTS view_active_users;

-- DROP VIEW IF EXISTS view_user_orders;



/********************************************************************************************
  SUMMARY:
  - view_active_users → Lists only users who are currently 'active'.
  - view_user_orders  → Joins 'users' and 'orders' to show user-wise order data.
********************************************************************************************/
