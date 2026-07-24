-- Which categories and sub-categories generate the highest and lowest profit?

-- Category Analysis 
-- Based on the overall category performance, Technology achieved the highest total sales (839,893.28), total profit (146,543.38), and profit margin (17.45%), making it the strongest-performing category. In contrast, although Furniture generated higher sales than Office Supplies, it produced significantly lower profit (19,730.00 vs. 126,023.44) and the lowest profit margin (2.61% vs. 17.22%), indicating that strong sales did not translate into strong profitability.
WITH Category_Performance AS (
    SELECT
        Category,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
    FROM `precise-armor-451212-s0.superstore.sales_cleaned`
    GROUP BY Category
)

SELECT
    Category,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank,
    Total_Profit,
    RANK() OVER (ORDER BY Total_Profit DESC) AS Profit_Rank,
    Profit_Margin,
    RANK() OVER (ORDER BY Profit_Margin DESC) AS Profit_Margin_Rank
FROM Category_Performance
ORDER BY Sales_Rank;


-- Based on the annual category performance, Technology consistently generated the highest sales in most years, except in 2024 when Furniture ranked first. Technology also recorded the highest profit in 2024–2026, while Office Supplies led in profit in 2023. Although Furniture maintained relatively high sales and showed continuous sales growth, it consistently generated the lowest profit and profit margin across all years, suggesting persistent profitability issues despite strong revenue.

WITH Category_Performance AS (
    SELECT
        EXTRACT(YEAR FROM `Order Date`) AS Year,
        Category,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
    FROM `precise-armor-451212-s0.superstore.sales_cleaned`
    GROUP BY Year, Category
)

SELECT
    Year,
    Category,
    Total_Sales,
    RANK() OVER (
        PARTITION BY Year
        ORDER BY Total_Sales DESC
    ) AS Sales_Rank,
    Total_Profit,
    RANK() OVER (
        PARTITION BY Year
        ORDER BY Total_Profit DESC
    ) AS Profit_Rank,
    Profit_Margin,
    RANK() OVER (
        PARTITION BY Year
        ORDER BY Profit_Margin DESC
    ) AS Profit_Margin_Rank
FROM Category_Performance
ORDER BY Year, Sales_Rank;


-- Sub-Category Analysis
-- Based on the overall sub-category performance, Copiers generated the highest total profit (56,093.94), followed by Phones (45,050.83) and Accessories (41,936.64). In contrast, Tables recorded the lowest profit (-17,753.21), followed by Bookcases (-3,632.07) and Supplies (-1,171.39). These results indicate that profitability varies considerably across sub-categories, with some generating substantial profits while others consistently incur losses.
WITH SubCategory_Performance AS (
    SELECT
        Category,
        `Sub-Category`,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
    FROM `precise-armor-451212-s0.superstore.sales_cleaned`
    GROUP BY Category, `Sub-Category`
)

SELECT
    Category,
    `Sub-Category`,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank,
    Total_Profit,
    RANK() OVER (ORDER BY Total_Profit DESC) AS Profit_Rank,
    Profit_Margin,
    RANK() OVER (ORDER BY Profit_Margin DESC) AS Profit_Margin_Rank
FROM SubCategory_Performance
ORDER BY Sales_Rank;