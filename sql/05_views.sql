CREATE VIEW vw_sales_summary AS
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country,
    p.payment_method,
    p.amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id;
		
CREATE VIEW vw_product_sales AS
SELECT
    pr.product_id,
    pr.product_name,
    cat.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_revenue
FROM products pr
JOIN categories cat
    ON pr.category_id = cat.category_id
JOIN order_items oi
    ON pr.product_id = oi.product_id
GROUP BY
    pr.product_id,
    pr.product_name,
    cat.category_name;

CREATE VIEW vw_customer_summary AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(p.amount),2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country;		

CREATE VIEW vw_monthly_revenue AS
SELECT
    DATE_TRUNC('month', payment_date) AS month,
    ROUND(SUM(amount),2) AS revenue,
    COUNT(*) AS total_payments
FROM payments
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY DATE_TRUNC('month', payment_date);