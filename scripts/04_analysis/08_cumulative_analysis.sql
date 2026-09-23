/*
===============================================================================
Cumulative Analysis (Running Totals & Moving Averages)
===============================================================================
Script Purpose:
    - Track progressive business accumulation over time (running total sales).
    - Measure price stability/trends over time (moving average price).
    - Aggregate metrics at monthly and annual granularities.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Monthly Cumulative Analysis
-------------------------------------------------------------------------------

WITH MonthlySales AS (
    SELECT 
        DATETRUNC(MONTH, order_date) AS order_month,
        SUM(sales_amount)            AS total_sales,
        AVG(price)                   AS average_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
)
SELECT 
    order_month,
    total_sales,
    -- Progressive total accumulated month-over-month
    SUM(total_sales) OVER (
        ORDER BY order_month 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales,
    
    -- Cumulative average selling price over time
    AVG(average_price) OVER (
        ORDER BY order_month 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS moving_average_price
FROM MonthlySales
ORDER BY order_month ASC;


-------------------------------------------------------------------------------
-- 2. Yearly Cumulative Analysis
-------------------------------------------------------------------------------

WITH YearlySales AS (
    SELECT 
        DATETRUNC(YEAR, order_date) AS order_year,
        SUM(sales_amount)           AS total_sales,
        AVG(price)                  AS average_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(YEAR, order_date)
)
SELECT 
    order_year,
    total_sales,
    -- Progressive total accumulated year-over-year
    SUM(total_sales) OVER (
        ORDER BY order_year 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales,
    
    -- Cumulative average selling price over years
    AVG(average_price) OVER (
        ORDER BY order_year 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS moving_average_price
FROM YearlySales
ORDER BY order_year ASC;
