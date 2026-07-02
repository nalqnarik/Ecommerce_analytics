CREATE OR REPLACE FUNCTION get_customer_lifetime_value(p_customer_id INT)
RETURNS NUMERIC AS
$$
DECLARE
    total_spent NUMERIC;
BEGIN
    SELECT COALESCE(SUM(p.amount), 0)
    INTO total_spent
    FROM payments p
    JOIN orders o
        ON p.order_id = o.order_id
    WHERE o.customer_id = p_customer_id;

    RETURN ROUND(total_spent, 2);
END;
$$
LANGUAGE plpgsql;

SELECT get_customer_lifetime_value(25);

CREATE OR REPLACE FUNCTION get_monthly_revenue(
    p_year INT,
    p_month INT
)
RETURNS NUMERIC AS
$$
DECLARE
    revenue NUMERIC;
BEGIN

    SELECT COALESCE(SUM(amount),0)
    INTO revenue
    FROM payments
    WHERE EXTRACT(YEAR FROM payment_date)=p_year
      AND EXTRACT(MONTH FROM payment_date)=p_month;

    RETURN ROUND(revenue,2);

END;
$$
LANGUAGE plpgsql;

SELECT get_monthly_revenue(2025, 7);

CREATE OR REPLACE FUNCTION get_top_products(p_limit INT)
RETURNS TABLE
(
    product_name VARCHAR,
    revenue NUMERIC
)
AS
$$
BEGIN

RETURN QUERY

SELECT
    pr.product_name,
    ROUND(SUM(oi.quantity*oi.unit_price),2)

FROM products pr
JOIN order_items oi
ON pr.product_id=oi.product_id

GROUP BY pr.product_name

ORDER BY 2 DESC

LIMIT p_limit;

END;
$$
LANGUAGE plpgsql;

SELECT *
FROM get_top_products(10);