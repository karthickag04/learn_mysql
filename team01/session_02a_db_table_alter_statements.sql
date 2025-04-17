-- 1. create the database '3a'
create database 3a;
-- 1. Use the database '3a'
use 3a;  
-- This command sets the current database to '3a'. All following operations will be performed in this database.

CREATE TABLE student (
    sno INT PRIMARY KEY,                -- sno is an integer, and it will be the primary key.
    f_name VARCHAR(50),                 -- f_name is a string (varchar) of up to 50 characters.
    username VARCHAR(50),               -- username is also a string (varchar) of up to 50 characters.
    password VARCHAR(255),              -- password is a string of up to 255 characters (to handle hashed passwords).
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP -- created_at will store date and time, defaulting to the current timestamp.
);


-- 2. Show all tables in the current database
show tables;  
-- This command lists all the tables available in the '3a' database.

-- 3. Describe the structure of the 'student' table
describe student;  
-- This command displays the columns and their data types in the 'student' table.

-- 4. Select all data from the 'student' table
select * from student;  
-- This command retrieves all rows and columns from the 'student' table.

-- 5. Select specific columns from the 'student' table
select sno,f_name,l_name,username,password,created_at from student;  
-- This command retrieves selected columns ('sno', 'f_name', 'l_name', 'username', 'password', 'created_at') from the 'student' table.

-- 6. Insert multiple rows into the 'student' table
insert into student(sno,username,password,created_at,f_name) values 
(312,"Ravi044443",'ravi@123','2025-05-17 16:30:33','ravi'),
(34,"Ravi044344",'ravi@123','2025-05-17 16:30:33','ravi');
-- This command inserts two new records into the 'student' table with the specified values for 'sno', 'username', 'password', 'created_at', and 'f_name'.

-- 7. Insert a single row into the 'student' table
insert into student values (11,"Ravi",'Ravi0423','ravi@123','2025-05-17 16:30:33');
-- This command inserts a single record into the 'student' table. It provides values for all columns in the order they appear in the table.

-- 8. Add a new column 'l_name' to the 'student' table
alter table student add column l_name varchar(50);
-- This command adds a new column named 'l_name' with a data type of VARCHAR(50) to the 'student' table.

-- 9. Add a new column 'l_name' after the 'f_name' column
alter table student add column l_name varchar(50) after f_name;
-- This command adds a new column named 'l_name' after the 'f_name' column. The previous column addition (if done) would be redundant.

-- 10. Add a new column 'id' as the first column in the 'student' table
alter table student add column id int first;
-- This command adds a new column 'id' with a data type of INT at the very beginning (first position) of the 'student' table.

-- 11. Drop the 'l_name' column from the 'student' table
alter table student drop column l_name;
-- This command removes the 'l_name' column from the 'student' table.

-- 12. Modify the 'f_name' column to be of VARCHAR(50)
alter table student modify column f_name varchar(50);
-- This command changes the data type of the 'f_name' column to VARCHAR(50), increasing or adjusting the column size.

-- 13. Rename the 'f_name' column to 'first_name'
alter table student rename column f_name to first_name;
-- This command renames the 'f_name' column to 'first_name' in the 'student' table.

-- method 1
-- 14. Rename the 'l_name' column to 'last_name'
alter table student rename column l_name to last_name;
-- This command renames the 'l_name' column to 'last_name' in the 'student' table.
-- or method 2
-- 15. Change the data type of 'l_name' column in the 'student_new' table
alter table student change l_name last_name varchar(50);
-- This command modifies the 'l_name' column in the 'student_new' table, renaming it to 'last_name' and changing its data type to VARCHAR(50).

-- 16. Add new column 'phone_number' to 'student' table, drop 'id' column, modify 'first_name', rename 'last_name' to 'l_name', and add 'address' column
alter table student 
add column phone_number varchar(20), 
drop column id, 
modify column first_name varchar(255), 
rename column last_name to l_name, 
add column address varchar(255);
-- This command performs multiple operations in one statement:
-- 1. Adds a new 'phone_number' column of type VARCHAR(20).
-- 2. Drops the 'id' column from the table.
-- 3. Modifies the 'first_name' column's data type to VARCHAR(255).
-- 4. Renames 'last_name' to 'l_name'.
-- 5. Adds an 'address' column of type VARCHAR(255).

-- 17. Describe the structure of the 'student' table after changes
describe student;  
-- This command displays the updated structure of the 'student' table after the ALTER operations.

-- 18. Show all tables again in the database
show tables;  
-- This command lists all the tables again, so we can see any changes, such as renaming tables.

-- 19. Rename the 'student' table to 'students'
rename table student to students;  
-- This command renames the table 'student' to 'students'.

-- 20. Describe the structure of the 'student_new' table
describe student_new;  
-- This command shows the structure of the 'student_new' table. It allows us to check the changes made to this table.

-- 21. Rename the 'students' table to 'student_new'
alter table students rename to student_new;  
-- This command renames the 'students' table back to 'student_new'.

