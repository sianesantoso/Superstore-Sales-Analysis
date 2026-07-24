-- Busines Overview 
-- 1. Total Order
-- 2. Total Sales
-- 3. AOV
-- 4. Total Profit
-- 5. Profit Profit Margin
-- 6. Total Customer 

-- From 2023–2026, the company generated 2.33 million in sales and 292.30 thousand in profit from 5,111 orders across 804 customers. The average order value reached 455.20, with an overall profit margin of 12.56%.

SELECT 
  COUNT(DISTINCT `Order ID`) AS `Total Order`,
  ROUND(SUM(Sales),2) AS `Total Sales`,
  ROUND(SUM(Profit),2) AS `Total Profit`,
  ROUND(SUM(Sales)/COUNT(DISTINCT `Order ID`),2) AS AOV,
  ROUND(SUM(Profit)/SUM(Sales)*100,2) AS `Profit Margin`,
  COUNT(DISTINCT `Customer ID`) AS `Total Customer`
FROM `precise-armor-451212-s0.superstore.sales_cleaned`;
