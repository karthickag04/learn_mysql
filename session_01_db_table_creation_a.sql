create database team01;
use team01;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT, -- Automatically increments the primary key
    username VARCHAR(50) UNIQUE NOT NULL, -- Ensures the username is unique and not null
    password VARCHAR(50) NOT NULL, -- Ensures the password is not null
    email VARCHAR(100) UNIQUE NOT NULL, -- Ensures the email is unique and not null
    age INT CHECK (age >= 18), -- Ensures the age is 18 or older
    status VARCHAR(20) DEFAULT 'active', -- Sets a default value of 'active' for status if not provided
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Sets the default timestamp when the row is created
);

-- Example of a table with a foreign key constraint
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) CHECK (amount > 0), -- Ensures the amount is positive
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- Ensures a valid user_id that links to the users table
);


INSERT INTO users (username, password, email, age, status)
VALUES
    ('ramu', 'password123', 'ramu@example.com', 25, 'active');

select * from users;

INSERT INTO users (username, password, email, status)
VALUES
    ('ramu1', 'password123', 'ramu1@example.com','active');
    

INSERT INTO users (username, password, email)
VALUES
    ('ramu2', 'password123', 'ramu2@example.com');
  
-- you must give username because its defined as not null 
INSERT INTO users ( password, email, age, status)
VALUES
    ('password123', 'ramu@example.com', 25, 'active');

-- cannot create or entry the same user due to unique contstrains defined for username
INSERT INTO users (username, password, email, age, status)
VALUES
    ('ramu', 'password123', 'ramu@example.com', 25, 'active');
    
    

INSERT INTO users (username, password, email, age, status)
VALUES
    ('ramu4', 'password123', 'ramu4@example.com', 25, 'active'),
    ('raju', 'password456', 'raju@example.com', 30, 'active'),
    ('ravi', 'password789', 'ravi@example.com', 22, 'inactive');



INSERT INTO orders (user_id, order_date, amount)
VALUES
    (1, '2025-01-24 10:00:00', 100.50);
    
    select * from orders;
    
    select * from users;
    

-- we do not have record number under userid = 9 and we have records upto 7 so it will through foreign key constrains failed error
INSERT INTO orders (user_id, order_date, amount)
VALUES
    (9, '2025-01-24 10:00:00', 100.50);
    
    
    
INSERT INTO orders (user_id, order_date, amount)
VALUES
    (1, '2025-01-24 10:00:00', 100.50),  -- Order for ramu (user_id = 1)
    (2, '2025-01-24 11:00:00', 150.75),  -- Order for raju (user_id = 2)
    (3, '2025-01-24 12:00:00', 200.00);  -- Order for ravi (user_id = 3)



-- use of foreign key reference
SELECT * FROM  users JOIN  orders ON users.user_id = orders.user_id;

select user_id,username from users;

truncate table orders;
delete from orders;

select * from orders;


-- delete the record based on condition
delete from users where user_id > 2 && age = 25;
