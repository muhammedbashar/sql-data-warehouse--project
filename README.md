
# SQL Server Data Warehouse & Sales Analytics

An end-to-end SQL Server data warehouse project integrating CRM and ERP data for data cleaning, transformation, exploratory analysis, and business insights.

---

## Table of Contents

- [Overview](#-overview)
- [Business Problem](#-business-problem)
- [Project Architecture](#-project-architecture)
- [Dataset](#-dataset)
- [Tools & Technologies](#-tools--technologies)
- [Project Workflow](#-project-workflow)
- [Key Insights](#-key-insights)
- [Reports](#-reports)
- [Project Structure](#-project-structure)
- [How to Run](#-how-to-run)
- [Results](#-results)
- [Future Improvements](#-future-improvements)
- [Author](#-author)

---

## Overview

This project develops a layered data warehouse using **SQL Server** to integrate CRM and ERP source data.

The project includes:

- ETL pipeline development
- Data cleaning and quality checks
- Dimensional data modeling
- Exploratory data analysis
- Advanced SQL analytics
- Customer and product reporting

The final output provides structured data and analytical insights to support business decision-making.

[⬆ Back to Top](#-table-of-contents)

---

## Business Problem

The business stores customer, product, and sales information across different source systems.

The objective is to:

- Integrate data from CRM and ERP systems.
- Improve data quality and consistency.
- Build a centralized reporting-ready data warehouse.
- Analyze sales performance and customer behavior.
- Generate actionable business insights.

[⬆ Back to Top](#-table-of-contents)

---

## Project Architecture

The project follows a three-layer data warehouse architecture:
<img src="https://img.sanishtech.com/u/d850104b357f9191f940a8361cf94a72.png" alt="data_architecture (1)" width="1377" height="845" loading="lazy" style="max-width:100%;height:auto;">

```text
CRM & ERP Source Data
          ↓
     Bronze Layer
          ↓
     Silver Layer
          ↓
      Gold Layer
          ↓
Exploratory & Advanced Analysis
          ↓
Customer & Product Reports
```

[⬆ Back to Top](#-table-of-contents)

---

## Dataset

The project uses six CSV source files:

### CRM Sources
- Customer information
- Product information
- Sales details

### ERP Sources
- Customer demographic information
- Customer location information
- Product category information

The data includes customer, product, sales, pricing, and transaction details.

[⬆ Back to Top](#-table-of-contents)

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL Server | Database development and data processing |
| T-SQL | ETL, data cleaning, and analysis |
| Data Warehouse | Bronze, Silver, and Gold layers |
| Draw.io | Architecture and data modeling diagrams |
| Git & GitHub | Version control and project documentation |

[⬆ Back to Top](#-table-of-contents)

---

## Project Workflow

### 1. Data Warehouse Development

- Created the `DataWarehouse` database.
- Developed Bronze, Silver, and Gold layers.
- Loaded raw CRM and ERP data using `BULK INSERT`.
- Cleaned and transformed data in the Silver layer.
- Created reporting-ready views in the Gold layer.

### 2. Data Quality Checks

Performed checks for:

- Duplicate records
- Missing values
- Invalid dates
- Data consistency
- Primary key uniqueness
- Fact-to-dimension relationships

### 3. Exploratory & Advanced Analysis

Conducted SQL-based analysis covering:

- Database and dimension exploration
- Measures and data ranges
- Magnitude and ranking analysis
- Trends over time
- Cumulative analysis
- Product and customer segmentation
- Part-to-whole analysis

[⬆ Back to Top](#-table-of-contents)

---

## Key Insights

| Metric | Result |
|---|---:|
| Total Sales | $29.36M |
| Total Quantity | 60,423 |
| Unique Orders | 27,659 |
| Sales Line Items | 60,398 |
| Customers | 18,484 |
| Products | 295 |

### Main Findings

- Bikes generated approximately **96.46% of total revenue**.
- Road Bikes generated the highest revenue among subcategories.
- The United States had the highest customer count and sales quantity.
- The customer base included New, Regular, and VIP segments.
- A small number of products contributed significantly to overall revenue.
- Customer and product performance varied across countries and categories.

[⬆ Back to Top](#-table-of-contents)

---

## Reports

Created SQL reporting views for:

### Customer Report

Includes:

- Total sales
- Order count
- Quantity purchased
- Customer lifespan
- Recency
- Average order value
- Customer segmentation

### Product Report

Includes:

- Total sales
- Order count
- Customer count
- Quantity sold
- Product lifespan
- Recency
- Product performance segmentation

[⬆ Back to Top](#-table-of-contents)

---

## Project Structure

```text
sql-server-data-warehouse-and-sales-analytics/
│
├── datasets/
├── docs/
├── scripts/
│   ├── 00_initialization/
│   ├── 01_bronze/
│   ├── 02_silver/
│   ├── 03_gold/
│   └── 04_analysis/
├── reports/
├── tests/
├── analysis/
├── README.md
├── LICENSE
└── .gitignore
```

[⬆ Back to Top](#-table-of-contents)

---

## How to Run

1. Clone the repository:

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

2. Open the project in SQL Server Management Studio.

3. Execute the initialization script:

```text
scripts/00_initialization/init_database.sql
```

4. Execute the Bronze layer scripts.

5. Load the Silver layer using the loading procedure.

6. Create the Gold layer views.

7. Run the quality-check scripts.

8. Execute the analysis and reporting scripts.

> **Note:** Update the source file paths in the Bronze loading procedure before execution.

[⬆ Back to Top](#-table-of-contents)

---

## Results

This project demonstrates the development of an end-to-end SQL Server data warehouse, from raw data ingestion to business-focused analytical reporting.

It provides structured customer and product insights through SQL-based exploratory analysis, advanced analytics, and reporting views.

[⬆ Back to Top](#-table-of-contents)

---

## Future Improvements

- Build an interactive Power BI dashboard.
- Automate the ETL pipeline.
- Add incremental data loading.
- Improve data validation and monitoring.
- Add additional business KPIs and reports.

[⬆ Back to Top](#-table-of-contents)

---

## Author

**Muhammed Bashar Ayyoli**

- LinkedIn: [Muhammed Bashar](https://www.linkedin.com/in/muhammed-bashar-b56770328/)
- Portfolio: [Data Analytics Portfolio](https://datascienceportfol.io/muhammedbashar)
- GitHub: [muhammedbashar](https://github.com/muhammedbashar)

