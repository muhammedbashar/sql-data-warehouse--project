/*
===============================================================================
Ranking Analysis (Top & Bottom Performers)
===============================================================================
Script Purpose:
    - Identify top and bottom performing Products and Subcategories by revenue.
    - Identify top high-value customers by revenue.
    - Identify customers with the lowest order frequency.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Product & Subcategory Ranking (Revenue)
-------------------------------------------------------------------------------

-- Top 5 Products by Revenue
SELECT TOP 5
    p.product_name, 
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
    ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Bottom 5 Worst-Performing Products by Revenue
SELECT TOP 5
    p.product_name, 
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
    ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- Top 5 Subcategories by Revenue
SELECT TOP 5
    p.subcategory, 
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
    ON s.product_key = p.product_key
GROUP BY p.subcategory
ORDER BY total_revenue DESC;

-- Bottom 5 Worst-Performing Subcategories by Revenue
SELECT TOP 5
    p.subcategory, 
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
    ON s.product_key = p.product_key
GROUP BY p.subcategory
ORDER BY total_revenue ASC;


-------------------------------------------------------------------------------
-- 2. Customer Ranking (Revenue & Order Count)
-------------------------------------------------------------------------------

-- Top 10 Customers by Revenue
SELECT TOP 10
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
    SUM(s.sales_amount)                    AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
    ON s.customer_key = c.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

-- Bottom 3 Customers by Order Count
SELECT TOP 3
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
    COUNT(DISTINCT s.order_number)         AS total_orders_placed
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
    ON s.customer_key = c.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders_placed ASC;
