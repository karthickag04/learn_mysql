use foodapp;
show tables;
select * from customers;


-- Create a view to display customer orders
CREATE VIEW CustomerOrders AS
SELECT customers.customer_id, customers.name, orders.order_id, orders.order_date, orders.total_amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id;

-- Select data from the view
SELECT * FROM CustomerOrders;