-- Which regions contribute the most and least to sales and profit?

-- Overall Performance
-- Based on the company's overall performance from 2023 to 2026, the West region generated the highest total sales (739,813.61) and total profit (110,798.82), followed by the East region with sales of 691,828.17 and profit of 94,883.26. These results indicate that both regions were the company's primary revenue and profit contributors throughout the period.
-- In contrast, although the Central region generated higher total sales (503,170.67) than the South region (391,721.91), it produced lower total profit (39,865.31 vs. 46,749.43). This suggests that the Central region operated with lower profitability, indicating potential issues such as lower-margin products, higher discount levels, or higher operating costs that require further investigation.
WITH Region_Performance AS (
    SELECT
        Region,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit
    FROM `precise-armor-451212-s0.superstore.sales_cleaned`
    GROUP BY Region
)

SELECT
    Region,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank,
    Total_Profit,
    RANK() OVER (ORDER BY Total_Profit DESC) AS Profit_Rank
FROM Region_Performance
ORDER BY Profit_Rank;

-- Annual Regional Performance  
-- Based on regional performance from 2023 to 2026, the West region consistently generated the highest sales and profit, maintaining the top rank throughout the period. Although sales slightly declined in 2024 compared to 2023, profit continued to increase, indicating improved profitability despite lower revenue. The East region consistently ranked second in both sales and profit. However, in 2025, profit decreased even though sales increased, suggesting lower profit efficiency.
-- The Central and South regions contributed significantly less than the West and East regions. While Central generally generated higher sales than South, its profitability weakened substantially in 2026, with profit falling to only 7,572 despite stable sales, causing its profit rank to drop below the South region.
WITH Region_Profit AS (
    SELECT
        EXTRACT(YEAR FROM `Order Date`) AS Year,
        Region,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit
    FROM `precise-armor-451212-s0.superstore.sales_cleaned`
    GROUP BY Year, Region
)

SELECT
    *,
    RANK() OVER (
        PARTITION BY Year
        ORDER BY Total_Sales DESC
    ) AS Sales_Rank,

    RANK() OVER (
        PARTITION BY Year
        ORDER BY Total_Profit DESC
    ) AS Profit_Rank
FROM Region_Profit
ORDER BY Year, Sales_Rank;