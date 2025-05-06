USE Project;

SELECT * FROM supply_chain_view;
-- MTD Sales

SELECT SUM(Quantity * Price) AS MTD_Sales
FROM supply_chain_view
WHERE Date >= DATE_FORMAT(CURDATE(), '%Y-%m-01') 
AND Date <= CURDATE();

-- Inserting an example value

INSERT INTO supply_chain_view 
VALUES (123456, '2025-04-01', 'AAMPE0868L', 2, 10.00, 15.00, 'Music', 'Walnut Store #984', 'West', 'California', 'Glendale', 4466);

-- QTD Sales

SELECT SUM(Quantity * Price) AS QTD_Sales
FROM supply_chain_view
WHERE Date >= MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())*3-3 MONTH
AND Date <= CURDATE();

-- YTD Sales

SELECT SUM(Quantity * Price) AS YTD_Sales
FROM supply_chain_view
WHERE Date >= MAKEDATE(YEAR(CURDATE()), 1)
AND Date <= CURDATE();

-- Product wise sales

SELECT Product_Type, SUM(quantity*price) AS Total_Sales
FROM supply_chain_view
group by Product_Type
order by Total_Sales DESC;

-- Sales Growth MOM

SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,  
ROUND(SUM(Quantity * Price), 2) AS Monthly_Sales,
ROUND(LAG(SUM(Quantity * Price)) OVER (ORDER BY DATE_FORMAT(Date, '%Y-%m')), 2) AS Previous_Month_Sales,
    ROUND(((SUM(Quantity * Price) - LAG(SUM(Quantity * Price)) OVER (ORDER BY DATE_FORMAT(Date, '%Y-%m'))) 
        / NULLIF(LAG(SUM(Quantity * Price)) OVER (ORDER BY DATE_FORMAT(Date, '%Y-%m')), 0)) * 100, 2) AS MoM_Growth
FROM supply_chain_view
GROUP BY Month
ORDER BY Month;

-- Sales Growth YOY

SELECT YEAR(Date) AS Year, ROUND(SUM(Quantity * Price), 2) AS Yearly_Sales,
ROUND(LAG(SUM(Quantity * Price)) OVER (ORDER BY YEAR(Date)), 2) AS Previous_Year_Sales,
    ROUND(((SUM(Quantity * Price) - LAG(SUM(Quantity * Price)) OVER (ORDER BY YEAR(Date))) 
	/ NULLIF(LAG(SUM(Quantity * Price)) OVER (ORDER BY YEAR(Date)), 0)) * 100, 2) AS YoY_Growth
FROM supply_chain_view
GROUP BY Year
ORDER BY Year;

-- Daily Sales Trend

SELECT DATE(Date) AS Sales_Date,
    ROUND(SUM(Quantity * Price), 2) AS Daily_Sales
FROM supply_chain_view
GROUP BY Sales_Date
ORDER BY Sales_Date;

-- State wise sales

SELECT Store_State, ROUND(SUM(Quantity * Price), 2) AS State_Sales
FROM supply_chain_view
GROUP BY Store_State
ORDER BY State_Sales DESC;

-- Top 5 Store wise Sales

SELECT Store_Name, ROUND(SUM(Quantity * Price), 2) AS Store_Sales
FROM supply_chain_view
GROUP BY Store_Name
ORDER BY Store_Sales DESC
LIMIT 5;

-- Region wise sales

SELECT Store_Region, ROUND(SUM(Quantity * Price), 2) AS Region_Sales
FROM supply_chain_view
GROUP BY Store_Region
ORDER BY Region_Sales DESC;

-- Total Inventory

SELECT Product_Type, Quantity_on_Hand
FROM inventory_adjusted;

-- Total Inventory Value

SELECT Product_Type, Quantity_on_Hand, ROUND(SUM(Price*Cost_Amount), 2) AS Inventory_Value
FROM inventory_adjusted
group by Product_Type, Quantity_on_Hand;

-- Overstock, Out-of-stock, Under-stock:

SELECT Product_Key, Product_Name, Sku_Number, Quantity_on_Hand,
    CASE 
        WHEN Quantity_on_Hand <0 THEN 'Out-of-stock'
        WHEN Quantity_on_Hand < 10 THEN 'Under-stock'
        WHEN Quantity_on_Hand > 100 THEN 'Overstock'
        ELSE 'Optimal Stock'
    END AS Stock_Status
FROM inventory_adjusted;

DROP TABLE sales;

-- Purchase Method wise Sales

-- Method 1

SELECT S.Purchase_Method, ROUND(SUM(V.QUANTITY*V.PRICE), 2) AS Sales_Value
FROM supply_chain_view V JOIN Sales S
ON V.Cust_Key = S.Cust_Key
GROUP BY S.Purchase_Method;

-- Method 2

SELECT S.Purchase_Method, ROUND(SUM(V.Quantity * V.Price), 2) AS Sales_Value
FROM Sales S JOIN supply_chain_view V 
ON S.Order_Number = V.Order_Number 
GROUP BY S.Purchase_Method
ORDER BY Sales_Value DESC;

-- Not getting any values for Purchase Method wise Sales

