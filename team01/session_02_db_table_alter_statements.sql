use team01;

describe users;

-- Adding a new column for phone numbers to the 'users' table
ALTER TABLE users ADD phone_number VARCHAR(15);
-- 'ADD': Adds a new column named 'phone_number' with a maximum length of 15 characters.


ALTER TABLE users ADD temp_id VARCHAR(15) first;
-- 'ADD': Adds a new column named 'temp_id' with a maximum length of 15 characters to the first.

ALTER TABLE users ADD Alternate_email VARCHAR(100) after email ;
-- 'ADD': Adds a new column named 'Alternate_email' with a maximum length of 15 characters after the email column.


-- Modifying the 'password' column to increase its length for better security
ALTER TABLE users 
MODIFY password VARCHAR(100) NOT NULL;
-- 'MODIFY': Changes the definition of the existing 'password' column to allow 100 characters and ensures it's NOT NULL.



-- Adding a constraint to restrict 'status' values to 'active', 'inactive', or 'suspended'
ALTER TABLE users 
ADD CONSTRAINT chk_status CHECK (status IN ('active', 'inactive', 'suspended'));
-- 'ADD CONSTRAINT': Adds a new constraint named 'chk_status' that ensures only specific values are allowed in the 'status' column.

SHOW CREATE TABLE users;




describe users;


-- Removing the 'temp_id' column from the table as it is no longer required
ALTER TABLE users 
DROP COLUMN temp_id;
-- 'DROP COLUMN': Deletes the 'temp_id' column and its associated data from the table permanently.

-- Adding a foreign key relationship between 'orders' and 'users' tables
ALTER TABLE orders 
ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(user_id);
-- 'ADD CONSTRAINT': Creates a foreign key named 'fk_user_id' that links the 'user_id' in 'orders' to 'user_id' in 'users'.

-- Adding a new column 'order_status' to track the status of each order
ALTER TABLE orders 
ADD order_status VARCHAR(20) DEFAULT 'pending';
-- 'ADD': Adds a new column 'order_status' with a default value of 'pending' to the 'orders' table.


describe users;

-- Renaming the 'username' column to 'user_name' for better readability
-- method 1
ALTER TABLE users 
CHANGE username user_name VARCHAR(50) UNIQUE NOT NULL;
-- 'CHANGE': Renames the column 'username' to 'user_name' while maintaining its data type, constraints, and properties.

-- method 2
-- Only renames the column, leaving all other attributes (e.g., data type, constraints) unchanged
-- Not available in older versions of MySQL (only on mysql 8.0).
ALTER TABLE users 
RENAME COLUMN username TO user_name;


-- to rename table name method 1
ALTER TABLE old_table_name 
RENAME TO new_table_name;

ALTER TABLE users 
RENAME TO user;

show tables;

ALTER TABLE app_users 
RENAME TO users;

-- to rename table name method 2
RENAME TABLE users TO app_users;









-- complete second example on doing manipulation with alter Statements

use team01;


-- Adding a new column for storing user addresses to the 'users' table
ALTER TABLE users 
ADD address VARCHAR(255);
-- 'ADD': Adds a new column named 'address' to store the user's address, allowing up to 255 characters.

-- Modifying the 'password' column to include a default value for temporary passwords
ALTER TABLE users 
MODIFY password VARCHAR(100) DEFAULT 'Temp@123';
-- 'MODIFY': Updates the 'password' column to allow a longer length and sets a default value of 'Temp@123'.

-- Adding a unique constraint on the 'phone_number' column to ensure no duplicates
ALTER TABLE users 
ADD CONSTRAINT uq_phone_number UNIQUE (phone_number);
-- 'ADD CONSTRAINT': Creates a unique constraint named 'uq_phone_number' on the 'phone_number' column.

-- Renaming the 'email' column to 'user_email' for consistency
ALTER TABLE users 
CHANGE email user_email VARCHAR(100) UNIQUE NOT NULL;
-- 'CHANGE': Renames the 'email' column to 'user_email' while preserving its data type and constraints.

-- Dropping the 'status' column if it's no longer needed
ALTER TABLE users 
DROP COLUMN status;
-- 'DROP COLUMN': Deletes the 'status' column from the table permanently.

-- Removing the foreign key relationship from 'orders' to 'users'
ALTER TABLE orders 
DROP FOREIGN KEY fk_user_id;
-- 'DROP FOREIGN KEY': Removes the foreign key constraint named 'fk_user_id' from the 'orders' table.

-- Adding a column for tracking the payment method in the 'orders' table
ALTER TABLE orders 
ADD payment_method ENUM('card', 'cash', 'online') DEFAULT 'cash';
-- 'ADD': Adds a new column named 'payment_method' to track payment type, with predefined options and a default value.

-- Updating the column name 'amount' in the 'orders' table to 'total_amount'
ALTER TABLE orders 
CHANGE amount total_amount DECIMAL(12, 2) NOT NULL;
-- 'CHANGE': Renames the 'amount' column to 'total_amount' and adjusts the precision for more accuracy.

-- Adding a CHECK constraint to ensure 'total_amount' is greater than zero
ALTER TABLE orders 
ADD CONSTRAINT chk_total_amount CHECK (total_amount > 0);
-- 'ADD CONSTRAINT': Adds a new constraint to validate that the 'total_amount' must always be positive.
