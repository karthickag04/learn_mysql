use foodapp1;
show tables;

-- creating Stored Procedure
-- it can be created once and called again and again when it needed

DELIMITER //
-- creating select query for getting orders
CREATE PROCEDURE getorders()
BEGIN
SELECT * FROM orders;
END //
DELIMITER ;

-- to call the created stored procedure
call getorders();

-- using drop you can drop the stored procedure
-- altering procedure is not possible thats why using drop
drop procedure getorders;


-- drop and create stored procedure
drop procedure if exists getordersbyid;
DELIMITER //
create PROCEDURE getordersbyid(in id varchar(255))
BEGIN
SELECT order_id, status FROM orders where order_id=id;
END //
DELIMITER ;

-- to call the created stored procedure
call getordersbyid('1');


-- Create a stored procedure to add a new customer
drop procedure if exists AddCustomer;
DELIMITER //
CREATE PROCEDURE AddCustomer(IN name VARCHAR(100), IN email VARCHAR(20),IN phone varchar(15), IN address text, password_hash varchar(255), loyalty_points int)
BEGIN
    INSERT INTO customers (name, email,phone,address,password_hash,loyalty_points)
    VALUES (name, email,phone,address,password_hash,loyalty_points);
END;
//
DELIMITER ;


-- Call the stored procedure
CALL AddCustomer('John Doe122','j212@gmail.com', '123-456-7880','2e avenue, de','hashed_password11',80);

-- check the values that has been inserted to table exists
select * from customers;
describe customers;
