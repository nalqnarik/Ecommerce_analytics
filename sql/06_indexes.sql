CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_products_category
ON products(category_id);

CREATE INDEX idx_payments_date
ON payments(payment_date);

CREATE INDEX idx_orders_date
ON orders(order_date);

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 100;