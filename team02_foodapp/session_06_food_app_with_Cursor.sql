
use foodapp1;


-- Declare a cursor to iterate through customer orders
DELIMITER //
CREATE PROCEDURE ProcessCustomerOrders()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE customer_id INT;
    DECLARE order_id INT;
    DECLARE cursor_orders CURSOR FOR
    SELECT customer_id, order_id FROM orders;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cursor_orders;
    read_loop: LOOP
        FETCH cursor_orders INTO customer_id, order_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Example processing (e.g., printing)
        SELECT customer_id, order_id;
    END LOOP;
    CLOSE cursor_orders;
END;
//
DELIMITER ;

call ProcessCustomerOrders();
select * from orders;
