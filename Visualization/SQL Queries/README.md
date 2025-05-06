📦 Supply Chain Analysis Project
👋 Welcome!
This project was designed to simulate a real-world supply chain environment. By working with multiple datasets, I analyzed inventory flow, sales performance, and product demand to help identify business bottlenecks and opportunities. The project used SQL for data modeling and analysis, and Excel/Power BI for dashboard creation and visualization.

🛠 Tools Used
SQL (MySQL / SQL Server) – For data extraction, cleaning, and transformation

Excel – For dashboard visualization and reporting

Power BI – For building interactive visual dashboards (optional extension)

🧠 Project Objective
To analyze company-wide supply chain operations:

Identify top-selling products and regions

Track inventory value and stock health

Measure month-over-month (MoM) and year-over-year (YoY) growth

Detect sales patterns and customer behavior

🧩 Data Overview
The analysis was based on a combination of fact and dimension tables:

supply_chain_view: Contains sales transactions (quantity, price, customer, product, location)

inventory_adjusted: Holds inventory quantity and cost for each product

sales: Contains purchase method and customer transaction data

Supporting tables: Calendar, stores, customers, geolocation data

🔍 Key Insights Extracted Using SQL
Sales Metrics:

MTD (Month-to-Date), QTD, and YTD Sales were calculated dynamically based on today’s date using functions like CURDATE(), DATE_FORMAT() and MAKEDATE().

Example Query:
SELECT SUM(Quantity * Price) AS MTD_Sales
FROM supply_chain_view
WHERE Date >= DATE_FORMAT(CURDATE(), '%Y-%m-01') 
AND Date <= CURDATE();



Sales Trends:

MoM Growth calculated using LAG() and window functions.

YoY Growth analyzed by grouping and comparing yearly sales trends.

Daily sales trends provided granular transaction insights.

Product & Store Analysis:

Top-performing product categories, states, regions, and stores were ranked.

Example: The West region consistently contributed the highest sales.

Inventory Health:

Inventory was categorized as Overstock, Under-stock, Out-of-stock, or Optimal.

Inventory value was calculated as Quantity_on_Hand * Cost_Amount.

Customer Behavior:

Sales were broken down by purchase method (Cash, Credit, Debit, etc.).

Joins with the sales table linked customer transactions with product and revenue data.

📈 Sample KPIs Created
Total Sales

Monthly and Yearly Growth Rates

Top 5 Store Sales

Inventory Value by Product

Stock Health Classification

Purchase Method Analysis

🎯 Outcome & Skills Demonstrated
SQL Mastery: Complex queries with subqueries, joins, aggregations, and window functions

Dashboarding: Built clear and intuitive Excel dashboards (also extendable to Power BI)

Analytical Thinking: Derived meaningful insights that would guide business decisions in a real-world supply chain system

Data Storytelling: Presented the data in a way that is easy to understand for non-technical stakeholders

✅ Final Output
An interactive Excel dashboard that provides a high-level summary and deep drill-down views.

Insight-ready data models that are ready for integration with BI tools.

Real-world simulation of how businesses can optimize inventory, sales, and distribution using data.
