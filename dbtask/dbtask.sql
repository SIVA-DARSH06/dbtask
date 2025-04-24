create table product(
	product_id INT PRIMARY KEY ,
	productname VARCHAR(20),
	category VARCHAR(20),
	brand VARCHAR(20)
);

create table customers(
	customer_id INT PRIMARY KEY,
	fname VARCHAR(20),
	lname VARCHAR(20),
	phone INT,
	email VARCHAR(25)
);



create table orders(
	order_id INT PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	orderdate DATE
	
);


create table orderitems(
	orderitem_id INT REFERENCES orders(order_id),
	order_product INT REFERENCES product(product_id),
	MRP FLOAT,
	quantity INT
	
);


INSERT INTO product VALUES
    (1, 'iPhone 13', 'Mobile', 'Apple'),
    (2, 'Galaxy S22', 'Mobile', 'Samsung'),
    (3, 'XPS 13', 'Laptop', 'Dell'),
    (4, 'ThinkPad', 'Laptop', 'Lenovo');


INSERT INTO orders (order_id, customer_id, orderdate)
VALUES
    (101, 1, '2025-04-20'),
    (102, 2, '2025-04-21'),
    (103, 3, '2025-04-22');

INSERT INTO orderitems (orderitem_id, order_product, MRP, quantity)
VALUES
    (101, 1, 799.99, 1),
    (101, 2, 699.99, 2),
    (102, 3, 999.99, 1),
    (103, 4, 1099.99, 1),
    (103, 1, 799.99, 1);



SELECT order_product, SUM(quantity) AS total_quantity
FROM orderitems
GROUP BY order_product
ORDER BY total_quantity DESC;


SELECT productname
FROM product
WHERE product_id = (
    SELECT order_product
    FROM orderitems
    GROUP BY order_product
    ORDER BY SUM(quantity) DESC
    LIMIT 1
);


SELECT c.fname, c.lname, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


SELECT SUM(quantity) AS total_quantity
FROM orderitems;

SELECT AVG(MRP) AS average_price
FROM orderitems;

CREATE VIEW order_total_price AS
SELECT o.order_id, SUM(oi.MRP * oi.quantity) AS total_price
FROM orderitems oi
JOIN orders o ON oi.orderitem_id = o.order_id
GROUP BY o.order_id;

SELECT * FROM order_total_price;

CREATE INDEX idx_customer_id ON orders(customer_id);

SELECT * FROM orders WHERE customer_id = 1;





