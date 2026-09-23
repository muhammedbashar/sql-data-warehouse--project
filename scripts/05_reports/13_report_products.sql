/*
===============================================================================
PRODUCT REPORT VIEW
===============================================================================
Purpose:
    - Consolidate key product performance metrics and behavioral attributes.

Highlights:
    1. Extracts core product catalog attributes (Name, Category, Subcategory, Cost).
    2. Segments products by total sales performance (High-Performer, Mid-Range, Low-Performer).
    3. Aggregates product-level volume metrics:
        - Total Orders, Total Sales, Total Quantity Sold, Unique Customers.
        - Product Sales Lifespan (in months).
    4. Calculates key analytical KPIs:
        - Recency (months elapsed since last sale).
        - Average Selling Price (ASP).
        - Average Order Revenue (AOR).
        - Average Monthly Revenue.
===============================================================================
*/

CREATE VIEW gold.report_products AS

/*------------------------------------------------------------------------------
1) Base Query: Joins product sales transactions to product dimension
------------------------------------------------------------------------------*/
WITH base_query AS (
    SELECT 
        s.order_number,
        s.order_date,
        s.customer_key,
        s.sales_amount,
        s.quantity,
        s.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_products p
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
),

/*------------------------------------------------------------------------------
2) Product Aggregations: Summarizes metrics at the individual product level
------------------------------------------------------------------------------*/
product_aggregation AS (
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,
        MAX(order_date)                                   AS last_sale_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span,
        COUNT(DISTINCT order_number)                      AS total_orders,
        COUNT(DISTINCT customer_key)                      AS total_customers,
        SUM(sales_amount)                                 AS total_sales,
        SUM(quantity)                                     AS total_quantity_sold,
        ROUND(
            AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 
            2
        )                                                 AS avg_selling_price
    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost
)

/*------------------------------------------------------------------------------
3) Final Output: Enriches product metrics with segmentation & calculated KPIs
------------------------------------------------------------------------------*/
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    
    -- Recency: Months elapsed since last recorded sale
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
    
    -- Product Tier Segmentation by Revenue Contribution
    CASE 
        WHEN total_sales > 50000                 THEN 'High-Performer'
        WHEN total_sales >= 10000 AND total_sales <= 50000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,
    
    life_span,
    total_orders,
    total_sales,
    total_quantity_sold,
    total_customers,
    avg_selling_price,
    
    -- Derived KPI: Average Order Revenue (AOR)
    CASE 
        WHEN total_orders = 0 OR total_orders IS NULL THEN 0
        ELSE total_sales / CAST(total_orders AS FLOAT) 
    END AS avg_order_revenue,

    -- Derived KPI: Average Monthly Revenue
    CASE 
        WHEN life_span = 0 OR life_span IS NULL THEN total_sales
        ELSE total_sales / CAST(life_span AS FLOAT)
    END AS avg_monthly_revenue

FROM product_aggregation;
