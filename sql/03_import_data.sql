COPY categories(category_id, category_name)
FROM 'C:\D\Projects\PostgreSQL\ecommerce_analystics\data\categories.csv'
DELIMITER ','
CSV HEADER;

COPY products(product_id, product_name, category_id, price, stock_quantity)
FROM 'C:\D\Projects\PostgreSQL\ecommerce_analystics\data\products.csv'
DELIMITER ','
CSV HEADER;

COPY customers(customer_id, first_name, last_name, email, city, country, registration_date)
FROM 'C:\D\Projects\PostgreSQL\ecommerce_analystics\data\customers.csv'
DELIMITER ','
CSV HEADER;

COPY orders(order_id, customer_id, order_date, status)
FROM 'C:\D\Projects\PostgreSQL\ecommerce_analystics\data\orders.csv'
DELIMITER ','
CSV HEADER;

COPY order_items(order_item_id, order_id, product_id, quantity, unit_price)
FROM 'C:\D\Projects\PostgreSQL\ecommerce_analystics\data\order_items.csv'
DELIMITER ','
CSV HEADER;

COPY payments(payment_id, order_id, payment_method, payment_date, amount)
FROM 'C:\D\Projects\PostgreSQL\ecommerce_analystics\data\payments.csv'
DELIMITER ','
CSV HEADER;