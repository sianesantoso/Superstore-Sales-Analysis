-- Does offering higher discounts lead to higher sales but lower profit?
-- Within the Furniture category, Tables received the highest average discount (25.81%) and recorded the largest loss (-17,753.21) with a negative profit margin (-8.53%). Similarly, Bookcases had the second-highest average discount (21.53%) and also generated negative profit. In contrast, Chairs and Furnishings offered lower average discounts while maintaining positive profits and profit margins. These findings suggest that discounting strategies for Tables and Bookcases should be reviewed, as higher average discounts may be contributing to their poor profitability.

-- Overall correlation 
-- Correlation analysis shows that discount has almost no linear relationship with sales (r = -0.0278), indicating that offering higher discounts does not necessarily increase sales. While discount has only a weak negative relationship with total profit (r = -0.2189), it has a very strong negative relationship with profit margin (r = -0.8648). This suggests that although higher discounts do not always reduce total profit substantially, they are strongly associated with lower profitability relative to sales.
SELECT
    ROUND(CORR(Discount, Sales), 4) AS Correlation_Discount_Sales,
    ROUND(CORR(Discount, Profit), 4) AS Correlation_Discount_Profit,
    ROUND(CORR(Discount, SAFE_DIVIDE(Profit, Sales) * 100), 4) AS Correlation_Discount_Profit_Margin
FROM `precise-armor-451212-s0.superstore.sales_cleaned`;

-- Discount Level Analysis
-- Profit margin consistently declines as discount levels increase. Orders with no discount achieve the highest profit margin (29.56%), while discounts above 20% result in negative profit margins. Combined with the correlation analysis, these findings suggest that higher discounts substantially reduce profitability without showing a meaningful relationship with higher sales.
SELECT
    CASE
        WHEN Discount = 0 THEN '0%'
        WHEN Discount <= 0.10 THEN '1-10%'
        WHEN Discount <= 0.20 THEN '11-20%'
        WHEN Discount <= 0.30 THEN '21-30%'
        ELSE '>30%'
    END AS Discount_Group,
    COUNT(*) AS Orders,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(AVG(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin
FROM `precise-armor-451212-s0.superstore.sales_cleaned`
GROUP BY Discount_Group
    ORDER BY
    CASE Discount_Group
        WHEN '0%' THEN 1
        WHEN '1-10%' THEN 2
        WHEN '11-20%' THEN 3
        WHEN '21-30%' THEN 4
        ELSE 5
    END;

-- Furniture has the highest average discount (17.30%) and also records the lowest profit margin (2.61%). In contrast, Technology has the lowest average discount (13.15%) while achieving the highest profit margin (13.90%). Although this comparison is based on only three categories and does not establish a causal relationship, it is consistent with the overall finding that higher discounts are associated with lower profitability.
SELECT
    Category,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Percent,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM `precise-armor-451212-s0.superstore.sales_cleaned`
GROUP BY Category
ORDER BY Avg_Discount_Percent DESC;

-- Drilldown from Business Question 2 
-- Do Tables and Bookcases also have a high average discount compared to other sub-categories?
-- Within the Furniture category, Tables received the highest average discount (25.81%) and recorded the largest loss (-17,753.21) with a negative profit margin (-8.53%). Similarly, Bookcases had the second-highest average discount (21.53%) and also generated negative profit. In contrast, Chairs and Furnishings offered lower average discounts while maintaining positive profits and profit margins. These findings suggest that higher discount levels may be associated with lower profitability within the Furniture category, particularly for Tables and Bookcases.
SELECT
    `Sub-Category` AS Sub_Category,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Percent,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM `precise-armor-451212-s0.superstore.sales_cleaned`
WHERE Category = 'Furniture'
GROUP BY `Sub-Category`
ORDER BY Avg_Discount_Percent DESC;