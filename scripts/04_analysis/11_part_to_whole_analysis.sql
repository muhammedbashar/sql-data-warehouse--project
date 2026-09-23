/*
===============================================================================
Data Segmentation Analysis (Behavioural & Cost Tiering)
===============================================================================
Script Purpose:
    - Product Cost Tiering: Categorise products by cost range to understand 
      inventory distribution across price points.
    - Customer Value Segmentation (RFM/Lifespan): Group customers into 
      VIP, Regular, and New segments based on lifespan and lifetime spending.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Product Cost Tiering Analysis
-------------------------------------------------------------------------------

WITH ProductSegments AS (
    SELECT 
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100                   THEN 'Below 100'
            WHEN cost >= 100 AND cost <= 500  THEN '100 - 500'
            WHEN cost > 500  AND cost <= 1000 THEN '501 - 1000'
            WHEN cost > 1000 AND cost <= 1500 THEN '1001 - 1500'
            ELSE 'Above 1500'
        END AS cost_range
    FROM gold.dim_products
)
SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM ProductSegments
GROUP BY cost_range
ORDER BY total_products DESC;


-------------------------------------------------------------------------------
-- 2. Customer Behavioral Segmentation (VIP, Regular, New)
-------------------------------------------------------------------------------

WITH CustomerSpending AS (
    SELECT 
        c.customer_key,
        SUM(s.sales_amount)                                  AS total_spending,
        MIN(s.order_date)                                    AS first_order_date,
        MAX(s.order_date)                                    AS last_order_date,
        DATEDIFF(MONTH, MIN(s.order_date), MAX(s.order_date)) AS lifespan_months
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_customers c
        ON s.customer_key = c.customer_key 
    GROUP BY c.customer_key
),
CustomerSegments AS (
    SELECT
        customer_key,
        total_spending,
        lifespan_months,
        CASE 
            WHEN lifespan_months >= 12 AND total_spending > 5000  THEN 'VIP'
            WHEN lifespan_months >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM CustomerSpending
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers,
    SUM(total_spending) AS aggregate_segment_spending,
    AVG(total_spending) AS avg_spending_per_customer
FROM CustomerSegments 
GROUP BY customer_segment
ORDER BY total_customers DESC;
