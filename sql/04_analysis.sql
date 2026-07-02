SELECT 
    ROUND(SUM(amount), 2) AS total_revenue
FROM payments;

SELECT 
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status;

SELECT 
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

SELECT 
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

SELECT 
    cu.first_name,
    cu.last_name,
    SUM(p.amount) AS total_spent
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers cu ON o.customer_id = cu.customer_id
GROUP BY cu.first_name, cu.last_name
ORDER BY total_spent DESC
LIMIT 10;

SELECT
    DATE_TRUNC('month', payment_date) AS month,
    ROUND(SUM(amount), 2) AS revenue
FROM payments
GROUP BY month
ORDER BY month;

SELECT
    DATE_TRUNC('month', payment_date) AS month,
    ROUND(SUM(amount), 2) AS revenue
FROM payments
GROUP BY month
ORDER BY month;

SELECT
    ROUND(AVG(amount), 2) AS average_order_value
FROM payments;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(p.amount), 2) AS lifetime_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY lifetime_value DESC
LIMIT 10;

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

SELECT
    c.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
    ROUND(
        100.0 * SUM(oi.quantity * oi.unit_price)
        / SUM(SUM(oi.quantity * oi.unit_price)) OVER (),
        2
    ) AS revenue_percentage
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY revenue DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    ROW_NUMBER() OVER (
        ORDER BY SUM(p.amount) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;
		
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(p.amount) DESC
    ) AS rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;

SELECT
    payment_date,
    amount,
    SUM(amount) OVER (
        ORDER BY payment_date
    ) AS cumulative_revenue
FROM payments
ORDER BY payment_date;

SELECT
    month,
    revenue,
    SUM(revenue) OVER (
        ORDER BY month
    ) AS cumulative_revenue
FROM (
    SELECT
        DATE_TRUNC('month', payment_date) AS month,
        SUM(amount) AS revenue
    FROM payments
    GROUP BY month
) t
ORDER BY month;

SELECT
    DATE_TRUNC('month', payment_date) AS month,
    ROUND(AVG(amount),2) AS average_payment
FROM payments
GROUP BY month
ORDER BY month;

SELECT *
FROM (
    SELECT
        c.category_name,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue,
        ROW_NUMBER() OVER (
            PARTITION BY c.category_name
            ORDER BY SUM(oi.quantity * oi.unit_price) DESC
        ) AS rn
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_name,
        p.product_name
) ranked_products
WHERE rn = 1;

SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number
FROM orders;