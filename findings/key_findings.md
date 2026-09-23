## Key Findings

The analysis of the integrated CRM and ERP data revealed important insights into overall sales performance, product contribution, customer distribution, and business trends.


---
###   Table of Contents

- <a href="#1.-overall-business-performance">1. Overall Business Performance</a>
- <a href="#2.-sales-performance-by-category">2. Sales Performance by Category</a>
- <a href="#3.-product-and-subcategory-performance">3. Product and Subcategory Performance</a>
- <a href="#4.-customer-distribution-and-geographic-insights">4. Customer Distribution and Geographic Insights</a>
- <a href="#5.-customer-segmentation">5. Customer Segmentation</a>
- <a href="#6.-sales-trends-overtime">6. Sales Trends Over Time</a>
- <a href="#7.-cumulative-and-performance-analysis">7. Cumulative and Performance Analysis</a>
- <a href="#8.-customer-and-product-reporting">8. Customer and Product Reporting</a>
- <a href="#9.-main-analytical-takeaways">9. Main Analytical Takeaways</a>
- <a href="#summary">Summary</a>


---
<h2><a class="anchor" id="1.-overall-business-performance"></a>1. Overall Business Performance</h2>

- **Total Sales:** $29.36 million generated across the available sales data.
- **Total Quantity Sold:** 60,423 items.
- **Average Selling Price:** Approximately $486.
- **Sales Line Items:** 60,398.
- **Unique Orders:** 27,659.
- **Products:** 295.
- **Customers:** 18,484.
- All 18,484 customers in the customer dimension were represented in the sales fact data.

These metrics provide a high-level overview of the business scale and establish the foundation for further sales and customer analysis.

---
<h2><a class="anchor" id="2.-sales-performance-by-category"></a>2. Sales Performance by Category</h2>

- The **Bikes category generated $28.32 million**, accounting for approximately **96.46% of total revenue**.
- Accessories generated $700,262, representing approximately 2.39% of total revenue.
- Clothing generated $339,716, representing approximately 1.16% of total revenue.
- The Bikes category was the primary contributor to overall revenue, while Accessories and Clothing generated comparatively smaller revenue contributions.
- Although Accessories represented a high volume of sales line items, their total revenue contribution was substantially lower than that of Bikes.

---
<h2><a class="anchor" id="3.-product-and-subcategory-performance"></a>3. Product and Subcategory Performance</h2>

- **Road Bikes** generated the highest subcategory revenue at approximately **$14.52 million**.
- Mountain Bikes generated approximately $9.95 million.
- Touring Bikes generated approximately $3.84 million.
- The top five products by revenue were different variants of the Mountain-200 product line:
  - Mountain-200 Black-46: $1,373,454
  - Mountain-200 Black-42: $1,363,128
  - Mountain-200 Silver-38: $1,339,394
  - Mountain-200 Silver-46: $1,301,029
  - Mountain-200 Black-38: $1,294,854
- The lowest-revenue products included Racing Socks, Patch Kit/8 Patches, Bike Wash - Dissolver, and Touring Tire Tube.
- The product cost distribution showed that 110 products had a cost below $100, while 101 products fell within the $100–$500 range.

The product analysis highlights the strong revenue contribution of bike-related products and identifies products with relatively low revenue for further investigation.

---
<h2><a class="anchor" id="4.-customer-distribution-and-geographic-insights"></a>4. Customer Distribution and Geographic Insights</h2>

- The United States had the highest number of customers, with **7,482 customers**.
- Australia followed with 3,591 customers.
- The United Kingdom, France, Germany, and Canada accounted for additional customer populations.
- The United States also recorded the highest quantity sold, with **20,481 items**, followed by Australia with 13,346 items.
- Customer distribution by gender was relatively balanced:
  - Male: 9,341 customers
  - Female: 9,128 customers
  - Unavailable or unspecified: 15 customers

The geographic analysis shows that the United States was the largest customer market and the largest contributor to quantity sold among the reported countries.

---
<h2><a class="anchor" id="5.-customer-segmentation"></a>5. Customer Segmentation</h2>

Customers were segmented according to their transaction history and spending behavior:

- **New:** 14,631 customers
- **Regular:** 2,198 customers
- **VIP:** 1,655 customers

The segmentation rules were:

- VIP: At least 12 months of transaction history and spending above $5,000.
- Regular: At least 12 months of transaction history and spending of $5,000 or less.
- New: Transaction history of less than 12 months.

The results show that the New segment contained the largest number of customers, while the Regular and VIP segments represented smaller groups of customers with longer transaction histories.

---
<h2><a class="anchor" id="6.-sales-trends-overtime"></a>6. Sales Trends Over Time</h2>

- The sales data covered the period from **December 2010 to January 2014**, representing approximately 37 months.
- Annual sales increased from $43,419 in 2010 to $7.08 million in 2011.
- Sales in 2012 totaled approximately $5.84 million.
- 2013 recorded the highest annual sales at approximately **$16.34 million**.
- January 2014 recorded $45,642 in sales, representing a partial year in the available dataset.
- At the monthly level, December recorded the highest total sales among the reported months, with approximately **$3.21 million**.
- November and October also recorded relatively high monthly sales compared with several earlier months.

The time-based analysis demonstrates variations in sales performance across years and months and provides a foundation for evaluating business growth patterns and seasonality.

---
<h2><a class="anchor" id="7.-cumulative-and-performance-analysis"></a>7. Cumulative and Performance Analysis</h2>

- Cumulative sales analysis was used to calculate running total sales over time.
- Monthly sales and average selling prices were evaluated using window functions.
- Yearly and monthly product performance was compared against average sales performance and previous periods.
- The analysis classified product performance using comparisons such as Above Average, Average, and Below Average.
- Year-over-year and month-over-month comparisons were used to identify changes in product sales performance, including increasing and decreasing patterns.

These analytical techniques helped evaluate sales progression and product-level performance changes over time rather than relying only on overall totals.

---
<h2><a class="anchor" id="8.-customer-and-product-reporting"></a>8. Customer and Product Reporting</h2>

Reusable reporting views were developed for customer and product analysis.

#### Customer Reporting

The customer reporting view included:

- Total orders
- Total sales
- Total quantity
- Distinct products purchased
- Last order date
- Customer lifespan
- Recency
- Average order value
- Average monthly spending
- Age group
- Customer segment

#### Product Reporting

The product reporting view included:

- Total orders
- Total customers
- Total sales
- Total quantity
- Product lifespan
- Recency
- Average sales amount per unit
- Average order revenue
- Average monthly revenue
- Product performance segment

These reporting views provide structured, reusable outputs for business analysis and future reporting or dashboard development.

---
<h2><a class="anchor" id="9.-main-analytical-takeaways"></a>9. Main Analytical Takeaways</h2>

- Revenue was highly concentrated in the Bikes category, particularly Road Bikes, Mountain Bikes, and Touring Bikes.
- The United States represented the largest customer market and the highest quantity sold among the reported countries.
- A large proportion of customers belonged to the New segment under the defined segmentation rules.
- The Mountain-200 product line appeared among the highest-revenue individual products.
- Several lower-revenue products and subcategories were identified through ranking analysis.
- Time-based analysis revealed differences in sales performance across years and months.
- Customer and product reporting views consolidated important business KPIs into reusable analytical outputs.

---
<h2><a class="anchor" id="summary"></a>Summary</h2>

The project transformed CRM and ERP source data into a structured SQL Server data warehouse using Bronze, Silver, and Gold layers. Exploratory and advanced SQL analysis was then performed to evaluate business performance, revenue contribution, customer distribution, product rankings, time-based trends, cumulative performance, and customer and product segmentation.

The resulting reporting views and analytical queries provide a foundation for understanding sales performance and supporting further business intelligence and reporting activities.