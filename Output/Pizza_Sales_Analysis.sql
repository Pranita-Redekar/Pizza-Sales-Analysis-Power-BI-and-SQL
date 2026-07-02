DROP TABLE IF EXISTS PIZZA_SALES;
CREATE TABLE PIZZA_SALES
(
	pizza_id INTEGER PRIMARY KEY ,
	order_id INTEGER ,
	pizza_name_id TEXT,
	quantity INTEGER,
	order_date DATE,
	order_time TIME,
	unit_price NUMERIC(10,2),
	total_price NUMERIC(10,2),
	pizza_size VARCHAR(10),
	pizza_category VARCHAR(50),
	pizza_name TEXT,
	pizza_ingredients TEXT
	 
);

SELECT * FROM PIZZA_SALES;

-- KPI's
-- 1. Total Revenue
SELECT SUM(total_price) AS "Total_Revenue"
FROM PIZZA_SALES;

-- 2. Total Orders
SELECT COUNT(DISTINCT order_id) AS "Total_Orders" 
FROM PIZZA_SALES;

-- 3.Average Order Value
SELECT ROUND(SUM(Total_Price) / COUNT(DISTINCT Order_ID),2) AS "AVG_Order_Value"
FROM PIZZA_SALES;

-- 4.Total Pizza Sold
SELECT SUM(quantity) AS "Total_Pizza_Sold"
FROM PIZZA_SALES;

-- 5.Average Pizza Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
AS DECIMAL(10,2)) AS "AVG_Pizza_Per_Order"
FROM PIZZA_SALES;

-- ANALYSIS
-- 1.Monthly Trend for Total Revenue
SELECT TO_CHAR(order_date,'MONTH') AS "Month", SUM(total_price)AS "Total_Revenue"
FROM PIZZA_SALES
GROUP BY TO_CHAR(order_date, 'MONTH');

-- 2.Daily Trend for Total Orders
SELECT TO_CHAR(order_date,'DAY') AS "DAY", COUNT(DISTINCT order_id) AS "Total_Orders"
FROM PIZZA_SALES
GROUP BY TO_CHAR(order_date, 'DAY');

-- 3.Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) AS "Total_Revenue",
ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM PIZZA_SALES),2) As "Percentage"
FROM PIZZA_SALES
GROUP BY pizza_category;

-- 4.Percentage of Sales by Pizza Size
SELECT pizza_size, SUM(total_price) AS "Total_Revenue",
ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM PIZZA_SALES),2) As "PCT"
FROM PIZZA_SALES
GROUP BY pizza_size;

-- 5.Total Pizza Sold by Pizza Sales and Category
SELECT pizza_size, SUM(quantity) AS "Total_Pizza_Sold"
FROM PIZZA_SALES
GROUP BY pizza_size;

SELECT pizza_category, SUM(quantity) AS "Total_Pizza_Sold"
FROM PIZZA_SALES
GROUP BY pizza_category;

-- 6.Revenue by Pizza Name 
SELECT pizza_name, SUM(total_price) AS "Total_Revenue"
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY "Total_Revenue";

-- TOP & BOTTOM ANALYSIS
-- 1.Top Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS "Total_Revenue"
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY "Total_Revenue" DESC
LIMIT 5;

-- 2.Bottom Pizza by Revenue
SELECT pizza_name, SUM(total_price) AS "Total_Revenue"
FROM PIZZA_SALES
GROUP BY pizza_name
ORDER BY "Total_Revenue" 
LIMIT 5;

-- 3.Top Pizza by Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS "Total_Orders "
FROM PIZZA_SALES 
GROUP BY pizza_name
ORDER BY "Total_Orders " DESC
LIMIT 5;

-- 4.Bottom Pizza by Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS "Total_Orders"
FROM PIZZA_SALES 
GROUP BY pizza_name
ORDER BY "Total_Orders" 
LIMIT 5;

-- 5.Top Pizza by Quantity Sold
SELECT pizza_name, SUM(quantity) AS "Total_Quantity_Sold"
FROM PIZZA_SALES 
GROUP BY pizza_name
ORDER BY "Total_Quantity_Sold" DESC
LIMIT 5;

-- 6.Bottom Pizza by Quantity Sold
SELECT pizza_name, SUM(quantity) AS "Total_Quantity_Sold"
FROM PIZZA_SALES 
GROUP BY pizza_name
ORDER BY "Total_Quantity_Sold" ASC
LIMIT 5;