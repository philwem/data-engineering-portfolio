SELECT
    status,
    count(*) as total_orders,
    sum(amount) as total_revenue
FROM {{ ref('stg_orders') }}
GROUP BY status