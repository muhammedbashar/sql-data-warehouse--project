/*
===============================================================================
CUSTOMER REPORT VIEW
===============================================================================
Purpose:
    - Consolidate key customer metrics, demographics, and purchasing behaviors.

Highlights:
    1. Extracts core customer demographic and transactional attributes.
    2. Segments customers into value tiers (VIP, Regular, New) and age groups.
    3. Aggregates customer-level KPIs:
        - Total Orders, Total Sales, Quantity Purchased, Unique Products Purchased.
        - Customer Lifespan (in months).
    4. Computes derived analytical metrics:
        - Recency (months since last order).
        - Average Order Value (AOV).
        - Average Monthly Spend.
===============================================================================
*/

CREATE VIEW gold.report_customers AS

/*------------------------------------------------------------------------------
1) Base Query: Joins transactions to customer demographics
------------------------------------------------------------------------------*/
WITH base_query AS (
    SELECT 
        s.order_number,
        s.order_date,
        s.product_key,
        s.sales_amount,
        s.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birthdate, GETDATE())   AS age
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_customers c
        ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
),

/*------------------------------------------------------------------------------
2) Customer Aggregations: Summarizes metrics at the individual customer level
------------------------------------------------------------------------------*/
customer_aggregation AS (
    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number)                      AS total_orders,
        SUM(sales_amount)                                 AS total_sales,
        SUM(quantity)                                     AS total_quantity_purchased,
        COUNT(DISTINCT product_key)                       AS total_products,
        MAX(order_date)                                   AS last_order_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span
    FROM base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age
)

/*------------------------------------------------------------------------------
3) Final Output: Enriches aggregated metrics with segmentation & calculated KPIs
------------------------------------------------------------------------------*/
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    
    -- Demographics: Age Group Segmentation
    CASE 
        WHEN age < 20                   THEN 'Under 20'
        WHEN age >= 20 AND age <= 29    THEN '20-29'
        WHEN age >= 30 AND age <= 39    THEN '30-39'
        WHEN age >= 40 AND age <= 49    THEN '40-49'
        ELSE '50 and above'
    END AS age_group,
    
    -- Behavioral: Value Tier Segmentation
    CASE 
        WHEN life_span >= 12 AND total_sales > 5000  THEN 'VIP'
        WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    
    last_order_date,
    
    -- Recency: Months elapsed since last purchase
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
    
    -- Purchase Volume Metrics
    total_orders,
    total_sales,
    total_quantity_purchased,
    total_products,
    life_span,
    
    -- Derived KPI: Average Order Value (AOV)
    CASE 
        WHEN total_orders = 0 OR total_orders IS NULL THEN 0
        ELSE total_sales / CAST(total_orders AS FLOAT) 
    END AS avg_order_value,
    
    -- Derived KPI: Average Monthly Spend
    CASE 
        WHEN life_span = 0 OR life_span IS NULL THEN total_sales
        ELSE total_sales / CAST(life_span AS FLOAT)
    END AS avg_monthly_spend

FROM customer_aggregation;
