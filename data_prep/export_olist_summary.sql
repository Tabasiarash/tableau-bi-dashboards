-- Flattened Olist order-level export for Tableau Dashboard A
-- One row per order, no joins required inside Tableau.
SELECT
    o.order_id,
    o.order_purchase_timestamp::DATE                         AS order_date,
    c.customer_state,
    c.customer_city,
    COALESCE(p.product_category_name, 'unknown')             AS product_category,
    ROUND(oi.price::NUMERIC, 2)                              AS price,
    ROUND(oi.freight_value::NUMERIC, 2)                      AS freight_value,
    ROUND((oi.price + oi.freight_value)::NUMERIC, 2)         AS total_order_value,
    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
             AND o.order_estimated_delivery_date IS NOT NULL
        THEN (EXTRACT(EPOCH FROM (
            o.order_delivered_customer_date - o.order_estimated_delivery_date
        )) / 86400)::INTEGER
        ELSE NULL
    END                                                      AS delivery_delay_days,
    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
             AND o.order_purchase_timestamp IS NOT NULL
        THEN (EXTRACT(EPOCH FROM (
            o.order_delivered_customer_date - o.order_purchase_timestamp
        )) / 86400)::INTEGER
        ELSE NULL
    END                                                      AS delivery_time_days,
    r.review_score,
    o.order_status
FROM olist_orders o
JOIN olist_customers c          ON o.customer_id = c.customer_id
LEFT JOIN olist_order_items oi  ON o.order_id = oi.order_id
LEFT JOIN olist_products p      ON oi.product_id = p.product_id
LEFT JOIN olist_order_reviews r ON o.order_id = r.order_id
ORDER BY o.order_purchase_timestamp;
