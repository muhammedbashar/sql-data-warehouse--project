/*
===============================================================================
Performance Analysis (Target vs. Actual & Period-over-Period Growth)
===============================================================================
Script Purpose:
    - Year-over-Year (YoY) Analysis: Compare annual product sales against both 
      historical average product performance and the previous year's sales.
    - Month-over-Month (MoM) Analysis: Compare monthly product sales against 
      average monthly performance and the prior month's sales.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Year-Over-Year (YoY) Product Performance Analysis
-------------------------------------------------------------------------------

WITH YearlyProductSales AS (
    SELECT 
        YEAR(s.order_date)  AS order_year,
        p.product_name,
        SUM(s.sales_amount) AS current_sales
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_products p 
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
    GROUP BY 
        YEAR(s.order_date),
        p.product_name
),
YearlyMetrics AS (
    SELECT 
        order_year,
        product_name,
        current_sales,
        -- Historical benchmark averages
        AVG(current_sales) OVER (PARTITION BY product_name) AS avg_yearly_sales,
        -- Prior period value
        LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_year_sales
    FROM YearlyProductSales
)
SELECT 
    order_year,
    product_name,
    current_sales,
    avg_yearly_sales,
    
    -- Performance against overall average
    current_sales - avg_yearly_sales AS diff_avg,
    CASE 
        WHEN current_sales > avg_yearly_sales THEN 'Above Average'
        WHEN current_sales < avg_yearly_sales THEN 'Below Average'
        ELSE 'Average'
    END AS avg_change_segment,
    
    -- Performance against previous year
    prev_year_sales,
    current_sales - prev_year_sales AS diff_prev_year,
    CASE 
        WHEN current_sales > prev_year_sales THEN 'Increasing'
        WHEN current_sales < prev_year_sales THEN 'Decreasing'
        WHEN current_sales = prev_year_sales THEN 'No Change'
        ELSE 'New Product / Initial Year'
    END AS prev_year_change_segment
FROM YearlyMetrics
ORDER BY 
    product_name ASC, 
    order_year ASC;


-------------------------------------------------------------------------------
-- 2. Month-Over-Month (MoM) Product Performance Analysis
-------------------------------------------------------------------------------

WITH MonthlyProductSales AS (
    SELECT 
        DATETRUNC(MONTH, s.order_date) AS order_month,
        p.product_name,
        SUM(s.sales_amount)            AS current_sales
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_products p 
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
    GROUP BY 
        DATETRUNC(MONTH, s.order_date),
        p.product_name
),
MonthlyMetrics AS (
    SELECT 
        order_month,
        YEAR(order_month)  AS order_year,
        MONTH(order_month) AS order_month_num,
        product_name,
        current_sales,
        -- Historical benchmark averages
        AVG(current_sales) OVER (PARTITION BY product_name) AS avg_monthly_sales,
        -- Prior period value
        LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) AS prev_month_sales
    FROM MonthlyProductSales
)
SELECT 
    order_year,
    order_month_num,
    product_name,
    current_sales,
    avg_monthly_sales,
    
    -- Performance against overall average
    current_sales - avg_monthly_sales AS diff_avg,
    CASE 
        WHEN current_sales > avg_monthly_sales THEN 'Above Average'
        WHEN current_sales < avg_monthly_sales THEN 'Below Average'
        ELSE 'Average'
    END AS avg_change_segment,
    
    -- Performance against previous month
    prev_month_sales,
    current_sales - prev_month_sales AS diff_prev_month,
    CASE 
        WHEN current_sales > prev_month_sales THEN 'Increasing'
        WHEN current_sales < prev_month_sales THEN 'Decreasing'
        WHEN current_sales = prev_month_sales THEN 'No Change'
        ELSE 'New Product / Initial Month'
    END AS prev_month_change_segment
FROM MonthlyMetrics
ORDER BY 
    product_name ASC, 
    order_month ASC;
