use foodapp;
show tables;

CREATE TABLE order_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    change_date DATETIME
);


-- Create the trigger
DELIMITER // -- Change the delimiter to //
-- Create the trigger
CREATE TRIGGER LogOrderChanges
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_log (order_id, old_status, new_status, change_date)
    VALUES (OLD.order_id, OLD.status, NEW.status, NOW());
END;
// -- Change the delimiter back to ;
DELIMITER ;


-- List all triggers in the database
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'your_database_name';
-- Replace 'your_database_name' with the name of your database like TRIGGER_SCHEMA = 'foodapp'



-- List triggers for a specific table
SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_STATEMENT
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'your_database_name'
AND EVENT_OBJECT_TABLE = 'your_table_name';
-- Replace 'your_database_name' and 'your_table_name' with the names of your database and table
-- like WHERE TRIGGER_SCHEMA = 'foodapp' AND EVENT_OBJECT_TABLE = 'orders';


-- Update an order to see the trigger in action
UPDATE orders SET status = 'Shipped' WHERE order_id = 1;

