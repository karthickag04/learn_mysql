-- Create Customer Registration Table
create database customerDB;
use customerDB;
drop database customerdb;

CREATE TABLE customer_registration (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

-- Create Product Table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    product_description TEXT,
    price DECIMAL(10, 2)
);

drop table order_table;
-- Create Order Table, with foreign key reference to Customer Registration Table
CREATE TABLE order_table (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id int,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer_registration(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

drop table login;
-- Create Login Table, with foreign key reference to Customer Registration Table
CREATE TABLE login (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    username VARCHAR(50),
    password VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer_registration(customer_id)
);

-- Create Preferred Product List Table, with foreign key references to Customer Registration and Product Tables
CREATE TABLE preferred_product_list (
    customer_id INT,
    product_id INT,
    PRIMARY KEY (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES customer_registration(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Insert data into Customer Registration Table
INSERT INTO customer_registration (first_name, last_name, email, phone_number, address) VALUES
('John', 'Doe', 'john1.doe@example.com', '123-456-7890', '123 Elm Street'),
('Jane', 'Smith', 'jane1.smith@example.com', '987-654-3210', '456 Oak Avenue');


INSERT INTO customer_registration (first_name, last_name, email, phone_number, address) VALUES
('John', 'Daniel', 'john13.daniel@example.com', '123-456-2345', '123 xx St');

-- Insert data into Product Table
INSERT INTO product (product_name, product_description, price) VALUES
('Laptop', 'A high-performance laptop', 1200.00),
('Smartphone', 'A latest model smartphone', 800.00),
('Headphones', 'Noise-cancelling headphones', 150.00);

select * from customer_registration;

select * from product;


select * from order_table;

-- Insert data into Order Table
INSERT INTO order_table (customer_id,product_id, order_date, total_amount) VALUES
(2,1, '2023-06-01', 1350.00),
(2,2, '2023-06-05', 800.00);


INSERT INTO order_table (customer_id,product_id, order_date, total_amount) VALUES
(1,1, '2023-06-01', 1350.00),
(1,2, '2023-06-05', 800.00);

-- Insert data into Login Table
INSERT INTO login (customer_id, username, password) VALUES
(1, 'johndoe', 'password123'),
(1, 'johndoe', 'password123'),
(2, 'janesmith', 'password456'),
(2, 'janesmith', 'password456');

-- Insert data into Preferred Product List Table
INSERT INTO preferred_product_list (customer_id, product_id) VALUES
(1, 1),
(1, 3),
(2, 2);


select * from customer_registration;
select * from order_table;
select * from login;
-- 1-john-doe,3-1-1-1350
-- Example of Inner Join between Customer Registration, Order, Preferred Product List, and Product Tables
-- to see customer who ordered products
SELECT * FROM customer_registration cr
INNER JOIN  order_table o ON cr.customer_id = o.customer_id;

-- TO See (which) customer likes (which) product
SELECT * FROM customer_registration cr
INNER JOIN preferred_product_list ppl ON cr.customer_id = ppl.customer_id 
INNER JOIN product p ON ppl.product_id = p.product_id
;

-- TO See (which) customer bought (which) product
SELECT * FROM customer_registration cr
INNER JOIN preferred_product_list ppl ON cr.customer_id = ppl.customer_id 
INNER JOIN product p ON ppl.product_id = p.product_id
INNER JOIN order_table o ON o.product_id = p.product_id
;

-- TO See (which) customer bought (which) product with selected column
SELECT cr.customer_id as "customer id", concat(cr.first_name," ", cr.last_name) as "full name", o.product_id as "product id", p.product_name as "product name", p.price as "actual price", o.total_amount as "purchased price", o.order_date as "order date" FROM customer_registration cr
INNER JOIN preferred_product_list ppl ON cr.customer_id = ppl.customer_id 
INNER JOIN product p ON ppl.product_id = p.product_id
INNER JOIN order_table o ON o.product_id = p.product_id
where cr.customer_id = 1;


-- TO See (which) customer likes (which) product -- selecting specific column information
SELECT cr.customer_id, CONCAT(cr.first_name, ' ', cr.last_name) as full_name, cr.email, p.product_name, p.price  
FROM customer_registration cr
INNER JOIN preferred_product_list ppl ON cr.customer_id = ppl.customer_id 
INNER JOIN product p ON ppl.product_id = p.product_id;

-- TO See (which) customer likes (which) product -- selecting specific column information
SELECT cr.customer_id, CONCAT(cr.first_name, ' ', cr.last_name) as full_name, cr.email, p.product_name, p.price  
FROM customer_registration cr
INNER JOIN preferred_product_list ppl ON cr.customer_id = ppl.customer_id 
INNER JOIN product p ON ppl.product_id = p.product_id where cr.first_name="John";


select * from login;
-- Example of Left Join between Customer Registration and Login Table

SELECT * FROM customer_registration cr
right JOIN login l ON cr.customer_id = l.customer_id;



-- Example of Join between Preferred Product List and Product Table
SELECT cr.first_name, cr.last_name, p.product_name
FROM preferred_product_list ppl
INNER JOIN customer_registration cr ON ppl.customer_id = cr.customer_id
INNER JOIN product p ON ppl.product_id = p.product_id;

-- Example of Inner Join between Customer Registration, Order, Preferred Product List, Product, and Login Tables
SELECT 
    cr.first_name, 
    cr.last_name, 
    o.order_id, 
    o.order_date, 
    o.total_amount, 
    p.product_name, 
    p.price,
    l.username
FROM 
    customer_registration cr
INNER JOIN 
    order_table o ON cr.customer_id = o.customer_id
INNER JOIN 
    preferred_product_list ppl ON cr.customer_id = ppl.customer_id
INNER JOIN 
    product p ON ppl.product_id = p.product_id
LEFT JOIN 
    login l ON cr.customer_id = l.customer_id;
