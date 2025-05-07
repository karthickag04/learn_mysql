CREATE DATABASE 2B;

USE 2B;

CREATE TABLE irctc_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(35) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    occupation VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    email_id VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_security (
    sec_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    security_question TEXT NOT NULL,
    answer VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES irctc_users(user_id) ON DELETE CASCADE
);


INSERT INTO irctc_users (
    username, password, gender, date_of_birth, occupation, country, mobile_number, email_id
) VALUES
('rahul_verma2', '$2y$10$examplehashedpwd1', 'Male', '1990-08-15', 'Engineer', 'India', '9876543211', 'rahul.verma21@example.com'),
('anjali_sharma', '$2y$10$examplehashedpwd2', 'Female', '1995-02-10', 'Teacher', 'India', '9123456789', 'anjali.sharma@example.com'),
('arjun_patil', '$2y$10$examplehashedpwd3', 'Male', '1988-11-05', 'Doctor', 'India', '9012345678', 'arjun.patil@example.com'),
('kavita_rani', '$2y$10$examplehashedpwd4', 'Female', '1992-06-25', 'Designer', 'India', '9345678901', 'kavita.rani@example.com'),
('manoj_nair', '$2y$10$examplehashedpwd5', 'Male', '1985-03-30', 'Banker', 'India', '9988776655', 'manoj.nair@example.com');

select * from irctc_users;

INSERT INTO user_security (user_id, security_question, answer) VALUES
-- For user_id = 1 (Rahul Verma)
(1, 'What was your childhood nickname?', 'Rahu'),
(1, 'What is the name of your first school?', 'St. Xavier'),

-- For user_id = 2 (Anjali Sharma)
(2, 'What is your mother’s maiden name?', 'Kapoor'),
(2, 'What is your favorite food?', 'Pani Puri'),

-- For user_id = 3 (Arjun Patil)
(3, 'What was the name of your first pet?', 'Tiger'),
(3, 'Which city were you born in?', 'Nagpur'),

-- For user_id = 4 (Kavita Rani)
(4, 'What is your favorite movie?', 'Dilwale Dulhania Le Jayenge'),
(4, 'What was the name of your childhood best friend?', 'Neha'),

-- For user_id = 5 (Manoj Nair)
(5, 'What is your dream job?', 'Pilot'),
(5, 'What is the name of your favorite teacher?', 'Mr. Iyer');


select * from user_security;


select * from irctc_users u, user_security us where u.user_id = us.user_id;





DELIMITER $$

CREATE PROCEDURE register_user_with_security1 (
    IN p_username VARCHAR(35),
    IN p_password VARCHAR(255),
    IN p_gender ENUM('Male', 'Female', 'Other'),
    IN p_date_of_birth DATE,
    IN p_occupation VARCHAR(100),
    IN p_country VARCHAR(100),
    IN p_mobile_number VARCHAR(15),
    IN p_email_id VARCHAR(100),
    IN p_sec_question1 TEXT,
    IN p_answer1 VARCHAR(100),
    IN p_sec_question2 TEXT,
    IN p_answer2 VARCHAR(100)
)
BEGIN
    DECLARE new_user_id INT;

    -- Step 1: Insert into irctc_users
    INSERT INTO irctc_users (
        username, password, gender, date_of_birth, occupation, country, mobile_number, email_id
    ) VALUES (
        p_username, p_password, p_gender, p_date_of_birth, p_occupation, p_country, p_mobile_number, p_email_id
    );

    -- Step 2: Get the last inserted user_id
    SET new_user_id = LAST_INSERT_ID();

    -- Step 3: Insert two security questions
    INSERT INTO user_security (user_id, security_question, answer)
    VALUES 
        (new_user_id, p_sec_question1, p_answer1),
        (new_user_id, p_sec_question2, p_answer2);
END$$

DELIMITER ;


create table student(
sno int  primary key,
name varchar(230) not null
);


call createtable_with_timestamp("students","sno","int", "primary key", "name","varchar(230)","not null");


DELIMITER //

CREATE PROCEDURE createtable_with_timestamp(
    IN tblename_prefix VARCHAR(30),
    IN c1 VARCHAR(20),
    IN c1_dtype1 VARCHAR(40),
    IN c1_const2 VARCHAR(40),
    IN c2 VARCHAR(20),
    IN c2_dtype1 VARCHAR(40),
    IN c2_const1 VARCHAR(40)
)
BEGIN
    -- Declare a session variable to hold the formatted dynamic table name
    SET @formatted_table_name = CONCAT(tblename_prefix, DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));

    -- Declare a session variable to hold the dynamic SQL query
    SET @sql_query = CONCAT('CREATE TABLE ', @formatted_table_name, ' (', 
                            c1, ' ', c1_dtype1, ' ', c1_const2, ', ', 
                            c2, ' ', c2_dtype1, ' ', c2_const1, ')');

    -- Debug: check if the query is correctly formed
    SELECT @sql_query;  -- This will help to check the actual query being generated

    -- Prepare the query from the session variable
    PREPARE stmt FROM @sql_query;

    -- Execute the query
    EXECUTE stmt;

    -- Deallocate the prepared statement
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;




-- method 1
CREATE TABLE students  ( sno  int primary key, name varchar(230)  not null ); 

DELIMITER //

CREATE PROCEDURE createtable4(
    IN tblename VARCHAR(30),
    IN c1 VARCHAR(20),
    IN c1_dtype1 VARCHAR(40),
    IN c1_const2 VARCHAR(40),
    IN c2 VARCHAR(20),
    IN c2_dtype1 VARCHAR(40),
    IN c2_const1 VARCHAR(40)
)
BEGIN
    -- Declare a session variable to hold the dynamic SQL query
    SET @sql_query = CONCAT('CREATE TABLE ', tblename, ' (', 
                            c1, ' ', c1_dtype1, ' ', c1_const2, ', ', 
                            c2, ' ', c2_dtype1, ' ', c2_const1, ')');

    -- Debug: check if the query is correctly formed
    SELECT @sql_query;  -- This will help to check the actual query being generated

    -- Prepare the query from the session variable
    PREPARE stmt FROM @sql_query;

    -- Execute the query
    EXECUTE stmt;

    -- Deallocate the prepared statement
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;









Delimiter //
Create procedure createtable2(in tblename varchar(30),
in c1 varchar(20),
in c1_dtype1 varchar(40),
in c1_const2 varchar(40),
in c2 varchar(20),
in c2_dtype1 varchar(40),
in c2_const1 varchar(40)

)
begin

-- create table tblename (c1  c1_dtype1 c1_const2 ,c2 c2_dtype1 c2_const1);
	DECLARE sql_query VARCHAR(1000);
    -- Directly build the SQL query
	SET sql_query = CONCAT('CREATE TABLE ', tblename, ' (', 
                       c1, ' ', c1_dtype1, ' ', c1_const2, ', ', 
                       c2, ' ', c2_dtype1, ' ', c2_const1, ')');
    -- Prepare the query
	PREPARE stmt FROM sql_query;
    -- Execute the query
    EXECUTE stmt;
    -- Deallocate the prepared statement
    DEALLOCATE PREPARE stmt;
end //
Delimiter ;

-- method 2

DELIMITER //

CREATE PROCEDURE createtable(
    IN tblename VARCHAR(30),
    IN c1 VARCHAR(20),
    IN c1_dtype1 VARCHAR(40),
    IN c1_const2 VARCHAR(40),
    IN c2 VARCHAR(20),
    IN c2_dtype1 VARCHAR(40),
    IN c2_const1 VARCHAR(40)
)
BEGIN
    -- Declare a variable to hold the dynamic SQL query
    DECLARE sql_query VARCHAR(1000);

    -- Construct the SQL query dynamically using CONCAT_WS
    SET sql_query = CONCAT_WS(' ', 'CREATE TABLE', tblename, '(', 
                              CONCAT_WS(' ', c1, c1_dtype1, c1_const2), ',',
                              CONCAT_WS(' ', c2, c2_dtype1, c2_const1), ')');

    -- Prepare the query
    PREPARE stmt FROM sql_query;

    -- Execute the query
    EXECUTE stmt;

    -- Deallocate the prepared statement
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;



-- method 3

DELIMITER //

CREATE PROCEDURE createtable(
    IN tblename VARCHAR(30),
    IN c1 VARCHAR(20),
    IN c1_dtype1 VARCHAR(40),
    IN c1_const2 VARCHAR(40),
    IN c2 VARCHAR(20),
    IN c2_dtype1 VARCHAR(40),
    IN c2_const1 VARCHAR(40)
)
BEGIN
    -- Declare a variable to hold the dynamic SQL query
    DECLARE sql_query VARCHAR(1000);

    -- Construct the SQL query dynamically
    SET sql_query = CONCAT('CREATE TABLE ', tblename, ' (',
                           c1, ' ', c1_dtype1, ' ', c1_const2, ', ',
                           c2, ' ', c2_dtype1, ' ', c2_const1, ')');

    -- Prepare the query
    PREPARE stmt FROM sql_query;

    -- Execute the query
    EXECUTE stmt;

    -- Deallocate the prepared statement
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;









