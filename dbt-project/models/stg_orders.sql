SELECT
    order_id,
    customer_id,
    CAST(order_date AS DATE) AS order_date,
    LOWER(status) AS status,
    ROUND(amount / 100.0, 2) AS amount
FROM {{ ref('raw_orders') }}
