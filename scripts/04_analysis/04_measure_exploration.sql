/*
===============================================================================
Key Business Metrics & Measures Exploration
===============================================================================
Script Purpose:
    - Calculate top-level KPIs (Total Sales, Quantity, Average Price, Orders).
    - Analyze entity totals (Products, Customers, Active Purchasing Customers).
    - Generate a unified summary report aggregating all key business metrics.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Sales & Revenue KPI Exploration
-------------------------------------------------------------------------------

SELECT 
    -- Financials & Volume
    SUM(sales_amount)                  AS total_sales,
    SUM(quantity)                      AS total_quantity_sold,
    AVG(price)                         AS average_price,
    
    -- Order Counts
    COUNT(order_number)                AS total_number_of_orders,
    COUNT(DISTINCT order_number)       AS total_number_of_unique_orders
FROM gold.fact_sales;


-------------------------------------------------------------------------------
-- 2. Dimension Metrics (Products & Customers)
-------------------------------------------------------------------------------

-- Product Counts
SELECT 
    COUNT(product_name)                AS total_number_of_products,
    COUNT(DISTINCT product_name)       AS total_number_of_unique_products
FROM gold.dim_products;

-- Total Registered Customers
SELECT 
    COUNT(customer_key)                AS total_number_of_customers
FROM gold.dim_customers;

-- Active Customers (Placed at least 1 order)
SELECT 
    COUNT(DISTINCT customer_key)       AS order_placed_customers
FROM gold.fact_sales;


-------------------------------------------------------------------------------
-- 3. Unified Key Metrics Executive Report
-------------------------------------------------------------------------------

-- Option A: Consolidated Metrics Summary (Single Row - Highly Efficient)
SELECT 
    (SELECT SUM(sales_amount) FROM gold.fact_sales)            AS total_sales,
    (SELECT SUM(quantity) FROM gold.fact_sales)                AS total_quantity,
    (SELECT AVG(price) FROM gold.fact_sales)                   AS avg_price,
    (SELECT COUNT(DISTINCT order_number) FROM gold.fact_sales) AS total_orders,
    (SELECT COUNT(DISTINCT product_key) FROM gold.dim_products) AS total_products,
    (SELECT COUNT(customer_key) FROM gold.dim_customers)       AS total_customers,
    (SELECT COUNT(DISTINCT customer_key) FROM gold.fact_sales) AS active_customers;


-- Option B: Vertical Key-Value Report (Stacked Format via Aggregated Union)
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Unique Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(product_key) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers
UNION ALL
SELECT 'Active Customers', COUNT(DISTINCT customer_key) FROM gold.fact_sales;
