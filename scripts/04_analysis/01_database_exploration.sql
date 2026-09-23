/*
===============================================================================
Database Metadata & Schema Exploration
===============================================================================
Script Purpose:
    - Inspect database architecture, tables, and views.
    - Retrieve column names, data types, nullability, and field limits 
      for dimension and fact tables in the 'gold' schema.
===============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Table & View Inventory
-------------------------------------------------------------------------------

-- Retrieve a list of all tables and views in the database
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
ORDER BY 
    TABLE_SCHEMA ASC, 
    TABLE_NAME ASC;


-------------------------------------------------------------------------------
-- 2. Column Metadata Inspections
-------------------------------------------------------------------------------

-- Retrieve all columns for 'gold.dim_customers'
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold' 
  AND TABLE_NAME   = 'dim_customers'
ORDER BY ORDINAL_POSITION ASC;


-- Retrieve all columns for 'gold.dim_products'
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold' 
  AND TABLE_NAME   = 'dim_products'
ORDER BY ORDINAL_POSITION ASC;


-- Retrieve all columns for 'gold.fact_sales'
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold' 
  AND TABLE_NAME   = 'fact_sales'
ORDER BY ORDINAL_POSITION ASC;


-------------------------------------------------------------------------------
-- 3. BONUS: Unified Schema Summary Query
-------------------------------------------------------------------------------

-- Retrieve column details for ALL tables in the 'gold' schema in a single pass
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    ORDINAL_POSITION,
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold'
ORDER BY 
    TABLE_NAME ASC, 
    ORDINAL_POSITION ASC;
