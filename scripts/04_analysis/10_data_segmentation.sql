/*
===============================================================================
Part-to-Whole Analysis (Proportional Impact)
===============================================================================
Script Purpose:
    - Measure category contributions relative to overall business performance.
    - Identify product categories driving the largest share of Sales Revenue.
    - Identify product categories driving the largest share of Total Orders.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Sales Contribution by Category (Revenue Share)
-------------------------------------------------------------------------------

WITH CategorySales AS (
    SELECT 
        p.category,
        SUM(s.sales_amount) AS total_sales
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_products p
        ON s.product_key = p.product_key
    GROUP BY p.category
)
SELECT 
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    CONCAT(
        ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2), 
        '%'
    ) AS percentage_of_total_sales
FROM CategorySales
ORDER BY total_sales DESC;


-------------------------------------------------------------------------------
-- 2. Order Contribution by Category (Volume Share)
-------------------------------------------------------------------------------

WITH CategoryOrders AS (
    SELECT 
        p.category,
        COUNT(DISTINCT s.order_number) AS total_orders
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_products p
        ON s.product_key = p.product_key
    GROUP BY p.category
)
SELECT 
    category,
    total_orders,
    SUM(total_orders) OVER () AS overall_orders,
    CONCAT(
        ROUND((CAST(total_orders AS FLOAT) / SUM(total_orders) OVER ()) * 100, 2), 
        '%'
    ) AS percentage_of_total_orders
FROM CategoryOrders
ORDER BY total_orders DESC;
