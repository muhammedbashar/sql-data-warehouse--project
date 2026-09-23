/*
===============================================================================
Change Over Time Analysis (Trends & Seasonality)
===============================================================================
Script Purpose:
    - Track key sales performance metrics over different time grains.
    - Analyze high-level annual performance for long-term trends.
    - Evaluate aggregate monthly performance to identify overall seasonality.
    - Perform continuous time-series aggregation (Year-Month & DATETRUNC).
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Yearly Performance (High-Level Strategic Overview)
-------------------------------------------------------------------------------

SELECT 
    YEAR(order_date)             AS order_year, 
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year ASC;


-------------------------------------------------------------------------------
-- 2. Aggregate Monthly Performance (Seasonality Analysis)
-------------------------------------------------------------------------------

-- Aggregates data by month across ALL years (e.g., all Januaries combined)
-- Useful for detecting pure cyclical or seasonal patterns.
SELECT 
    MONTH(order_date)            AS order_month, 
    DATENAME(MONTH, order_date)  AS month_name,
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
    MONTH(order_date),
    DATENAME(MONTH, order_date)
ORDER BY order_month ASC;


-------------------------------------------------------------------------------
-- 3. Continuous Time-Series Trends (Year & Month Breakdown)
-------------------------------------------------------------------------------

-- Option A: Discrete Year and Month Columns
SELECT 
    YEAR(order_date)             AS order_year,
    MONTH(order_date)            AS order_month, 
    DATENAME(MONTH, order_date)  AS month_name,
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
    YEAR(order_date),
    MONTH(order_date),
    DATENAME(MONTH, order_date)
ORDER BY 
    order_year ASC, 
    order_month ASC;


-- Option B: Truncated Date (Ideal for BI Tools & Time-Series Plotting)
SELECT 
    DATETRUNC(MONTH, order_date) AS order_month_start,
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY order_month_start ASC;
