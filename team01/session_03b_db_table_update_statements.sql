/* =========================================================
   DATABASE CREATION
   ========================================================= */

-- Create a new database named team03
create database team03;

-- Select the database for use
use team03;



/* =========================================================
   TABLE CREATION
   ========================================================= */

-- Users table: stores login details
create table users(
    user_id int primary key auto_increment,  -- Unique ID for each user
    username varchar(55) not null unique,    -- Username must be unique
    password varchar(18) not null            -- Password (plain text for demo only)
);

-- Product table: stores product details
create table product(
    product_id int primary key auto_increment,  -- Unique product ID
    product_name varchar(50) not null,          -- Product name
    product_unit_price int not null,            -- Price per unit
    stock_count int not null                    -- Available quantity in stock
);

-- Orders table: links users and products
create table orders(
    order_id int primary key auto_increment, -- Unique order ID
    u_id int,                                -- Reference to users.user_id
    product_id int,                          -- Reference to product.product_id
    product_price double,                    -- Price at time of purchase
    order_date datetime default current_timestamp, -- Auto timestamp
    
    -- Foreign key relationships
    foreign key (u_id) references users(user_id),
    foreign key (product_id) references product(product_id)
);



/* =========================================================
   VERIFY TABLES
   ========================================================= */

-- Show all tables in the database
show tables;



/* =========================================================
   INSERT DATA INTO USERS
   ========================================================= */

-- Insert user with manually specified ID
insert into users(user_id, username, password)
values (1, "Ragu", "Pass@123");

-- Insert user with auto-increment ID
insert into users(username, password)
values ("Ragu01", "Pass@123");

-- View users table
select * from users;


-- Insert multiple users at once
insert into users (username, password) values
('karthick', 'pass123'),
('arun', 'arun@123'),
('divya', 'divya@123'),
('meena', 'mee123'),
('vijay', 'vijay@123'),
('sathish', 'sat123'),
('priya', 'pri123'),
('rahul', 'rah123'),
('anitha', 'ani123'),
('gokul', 'gok123');



/* =========================================================
   INSERT DATA INTO PRODUCT TABLE
   ========================================================= */

insert into product (product_name, product_unit_price, stock_count) values
('Laptop', 55000, 25),
('Mouse', 500, 150),
('Keyboard', 1200, 100),
('Monitor', 9000, 40),
('Printer', 8000, 30),
('USB Drive', 700, 200),
('External HDD', 4500, 60),
('Headphones', 1500, 120),
('Webcam', 2200, 80),
('Microphone', 3200, 70),
('Tablet', 18000, 35),
('Smartphone', 25000, 50),
('Power Bank', 1200, 140),
('Charger', 600, 160),
('Router', 2400, 45),
('Speaker', 3500, 55),
('Graphics Card', 42000, 15),
('RAM 16GB', 5200, 65),
('SSD 1TB', 7500, 75),
('Cooling Pad', 900, 110);



/* =========================================================
   INSERT DATA INTO ORDERS TABLE
   ========================================================= */

-- Multiple orders by user_id = 1 for product_id = 1
insert into orders (u_id, product_id, product_price, order_date) values
(1, 1, 55000, '2026-02-01 10:15:00'),
(1, 1, 55000, '2026-02-02 11:20:00'),
(1, 1, 55000, '2026-02-03 09:45:00'),
(1, 1, 55000, '2026-02-04 14:10:00'),
(1, 1, 55000, '2026-02-05 16:30:00'),
(1, 1, 55000, '2026-02-06 12:00:00'),
(1, 1, 55000, '2026-02-07 13:25:00'),
(1, 1, 55000, '2026-02-08 15:40:00'),
(1, 1, 55000, '2026-02-09 17:05:00'),
(1, 1, 55000, '2026-02-10 18:15:00'),
(1, 1, 55000, '2026-02-11 10:50:00'),
(1, 1, 55000, '2026-02-12 11:35:00'),
(1, 1, 55000, '2026-02-13 09:10:00'),
(1, 1, 55000, '2026-02-14 14:55:00'),
(1, 1, 55000, '2026-02-15 16:20:00');


-- View all tables data
select * from users;
select * from product;
select * from orders;



/* =========================================================
   ADDITIONAL ORDER (Different User & Product)
   ========================================================= */

insert into orders (u_id, product_id, product_price, order_date)
values (3, 20, 55000, '2026-02-01 10:15:00');



/* =========================================================
   UPDATE OPERATIONS
   ========================================================= */

-- Change password of user with ID = 1
update users
set password = "newpass@123"
where user_id = 1;


-- Change username and password of user ID = 3
update users
set username = "ravi01",
    password = "pass@123"
where user_id = 3;


-- Update password for all users except IDs 1, 4, 5, 6
update users
set password = "pass@"
where user_id not in (1, 4, 5, 6);
