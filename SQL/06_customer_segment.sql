-- Which customer segments are the most profitable?

-- Overall Segment Performance
-- Based on overall sales performance from 2023-2026, the Consumer segment generated the highest total sales and total profit, making it the largest contributor to company revenue and profitability. However, the Home Office segment achieved the highest profit margin (14.02%), indicating better profit efficiency despite having lower sales volume. Meanwhile, the Consumer segment, although generating the highest profit, had the lowest profit margin compared to other segments, suggesting that high revenue does not always translate into the highest profitability.
SELECT
    `Segment` AS `Customer Segment`,
    COUNT(DISTINCT(`Customer ID`)) AS `Total Customer`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM `precise-armor-451212-s0.superstore.sales_cleaned`
GROUP BY 1
ORDER BY 3 DESC;

-- Trend over Time
-- Based on annual performance, the Consumer segment consistently generated the highest sales and total profit from 2023 to 2026, followed by the Corporate segment. The Home Office segment maintained the highest profit margin in 2023 and 2024, showing strong profitability efficiency despite lower sales. However, in 2026, the Consumer segment achieved the highest profit margin (13.82%), indicating improved profitability efficiency over time. Meanwhile, the Corporate segment experienced a decline in profit margin in 2026, despite having the second-highest sales.
SELECT
    EXTRACT(YEAR FROM `Order Date`) AS Year,
    `Segment` AS `Customer Segment`,
    COUNT(DISTINCT `Customer ID`) AS `Total Customer`,
    ROUND(SUM(Sales), 2) AS `Total Sales`,
    ROUND(SUM(Profit), 2) AS `Total Profit`,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM `precise-armor-451212-s0.superstore.sales_cleaned`
GROUP BY Year, `Customer Segment`
ORDER BY Year, `Total Profit` DESC,`Total Sales` DESC;