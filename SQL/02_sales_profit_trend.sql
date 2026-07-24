-- Analyze sales and profit performance over time.

-- Annual Performance 
-- Based on the company's annual performance from 2023 to 2026, total sales declined by 4.26% in 2024 before recovering strongly in 2025 and continuing to grow in 2026. In contrast, total profit increased every year despite the sales decline in 2024, with the highest annual profit growth recorded in 2025 (33.29%).
WITH Yearly_Sales AS (
  SELECT 
    EXTRACT(YEAR FROM `Order Date`) AS Year,
    ROUND(SUM(Sales),2) AS `Total Sales`,
    ROUND(SUM(Profit),2) AS `Total Profit`
  FROM `precise-armor-451212-s0.superstore.sales_cleaned`
  GROUP BY 1
)

SELECT 
  Year,
  `Total Sales`,
  `Total Profit`,
  # growth percentage 
  ROUND((`Total Sales`-LAG(`Total Sales`) OVER(ORDER BY Year))/ABS(LAG(`Total Sales`) OVER(ORDER BY Year))*100,2) AS `Growth Sales Percentage`,
  ROUND((`Total Profit`-LAG(`Total Profit`) OVER(ORDER BY Year))/ABS(LAG(`Total Profit`) OVER(ORDER BY Year))*100,2) AS `Growth Profit Percentage`
FROM Yearly_Sales;



-- Seasonal Quarterly Performance 
-- From 2023 to 2026, both sales and profit consistently peaked in Q4 before declining sharply in Q1 of the following year, indicating a recurring seasonal pattern. After Q1, performance generally recovered throughout the remaining quarters. However, two notable exceptions occurred in Q3 2025, where profit declined by 2.09% despite higher sales, and Q2 2026, where profit fell significantly by 35.02% even though sales continued to grow.
WITH Quarterly_Sales AS (
  SELECT
    EXTRACT(YEAR FROM `Order Date`) AS Year,
    EXTRACT(QUARTER FROM `Order Date`) AS Quarter,
    ROUND(SUM(Sales),2) AS `Total Sales`,
    ROUND(SUM(Profit),2) AS `Total Profit`
  FROM `precise-armor-451212-s0.superstore.sales_cleaned`
  GROUP BY 1,2
)

SELECT
  Year,
  CONCAT('Q', Quarter) AS Quarter,
  `Total Sales`,
  `Total Profit`,
  ROUND(
    (`Total Sales` -
      LAG(`Total Sales`) OVER(PARTITION BY Year ORDER BY Quarter))
    / ABS(LAG(`Total Sales`) OVER(PARTITION BY Year ORDER BY Quarter))
    *100,2
  ) AS `Sales Growth`,
  ROUND(
    (`Total Profit` -
      LAG(`Total Profit`) OVER(PARTITION BY Year ORDER BY Quarter))
    / ABS(LAG(`Total Profit`) OVER(PARTITION BY Year ORDER BY Quarter))
    *100,2
  ) AS `Profit Growth`
FROM Quarterly_Sales
ORDER BY Year, Quarter;

WITH Quarterly_Sales AS (
  SELECT
    EXTRACT(YEAR FROM `Order Date`) AS Year,
    EXTRACT(QUARTER FROM `Order Date`) AS Quarter,
    ROUND(SUM(Sales),2) AS `Total Sales`,
    ROUND(SUM(Profit),2) AS `Total Profit`
  FROM `precise-armor-451212-s0.superstore.sales_cleaned`
  GROUP BY 1,2
)

SELECT
  Year,
  CONCAT('Q', Quarter) AS Quarter,
  `Total Sales`,
  `Total Profit`,
  ROUND(
    (`Total Sales` -
      LAG(`Total Sales`) OVER(ORDER BY Year, Quarter))
    / ABS(LAG(`Total Sales`) OVER(ORDER BY Year, Quarter))
    *100,2
  ) AS `Sales Growth`,
  ROUND(
    (`Total Profit` -
      LAG(`Total Profit`) OVER(ORDER BY Year, Quarter))
    / ABS(LAG(`Total Profit`) OVER(ORDER BY Year, Quarter))
    *100,2
  ) AS `Profit Growth`
FROM Quarterly_Sales
ORDER BY Year, Quarter;
