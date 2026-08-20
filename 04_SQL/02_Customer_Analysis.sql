SELECT *
FROM vw_customer_profitability
LIMIT 10;

-- Which customers generate the most Gross Profit?
SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    Orders,
    Revenue,
    Gross_Profit,
    Gross_Margin
FROM vw_customer_profitability
ORDER BY Gross_Profit DESC
LIMIT 20;

-- Which customers generate high revenue but have relatively low gross margins?
SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    Orders,
    Revenue,
    Gross_Profit,
    Gross_Margin
FROM vw_customer_profitability
WHERE Revenue >= 500000
ORDER BY Gross_Margin ASC
LIMIT 20;

SELECT
    Customer_ID,
    Customer_Name,
    Orders,
    Units,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(Gross_Profit, 2) AS Gross_Profit,
    ROUND(Gross_Margin, 2) AS Gross_Margin
FROM vw_customer_profitability
WHERE Customer_ID = 'CUS0861';
-- all 14 orders for Zayyan, sorted from the lowest-margin order to the highest-margin order. 
SELECT
    Order_ID,
    Order_Date,
    Product_Name,
    Category,
    Quantity,
    Unit_Price,
    Discount_Percent,
    Revenue,
    COGS,
    Gross_Profit,
    Gross_Margin
FROM fact_customer_profitability
WHERE Customer_ID = 'CUS0861'
ORDER BY Gross_Margin ASC; 
-- Zayyan is a high-value customer whose profitability is heavily concentrated in low-margin Exercise Bike purchases, particularly transactions receiving 15–20% discounts.


SELECT
    Product_Name,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS Gross_Margin
FROM fact_customer_profitability
WHERE Customer_ID = 'CUS0861'
GROUP BY Product_Name
ORDER BY Revenue DESC;

-- Exercise Bike profitability across the entire business,
SELECT
    Product_Name,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS Gross_Margin,
    ROUND(AVG(Discount_Percent), 2) AS Avg_Discount_Percent
FROM fact_customer_profitability
WHERE Product_Name = 'Exercise Bike'
GROUP BY Product_Name; 

-- higher discounts are systematically associated with lower margins
SELECT
    Discount_Percent,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS Gross_Margin
FROM fact_customer_profitability
WHERE Product_Name = 'Exercise Bike'
GROUP BY Discount_Percent
ORDER BY Discount_Percent;

-- What could NexaMart do about it?
SELECT
    ROUND(SUM(Gross_Sales), 2) AS Gross_Sales,
    ROUND(SUM(Revenue), 2) AS Actual_Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Actual_Gross_Profit,

    ROUND(SUM(Gross_Sales * (1 - 0.088)), 2) AS Scenario_Revenue,

    ROUND(
        SUM(Gross_Sales * (1 - 0.088) - COGS),
        2
    ) AS Scenario_Gross_Profit,

    ROUND(
        (
            SUM(Gross_Sales * (1 - 0.088) - COGS)
            - SUM(Gross_Profit)
        ),
        2
    ) AS Additional_Gross_Profit

FROM fact_customer_profitability
WHERE Customer_ID = 'CUS0861'
  AND Product_Name = 'Exercise Bike'; 
  
  -- Scenario analysis suggests that reducing Zayyan Kamdar's Exercise Bike discounting to the observed product-level average of 8.8% could have increased gross profit by approximately ₹59.6K, assuming sales volume and costs remained unchanged.
  -- How many customers are actually below the company's 26.91% overall gross margin?
  SELECT
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Gross_Margin < 26.91 THEN 1 ELSE 0 END) AS Below_Benchmark,
    SUM(CASE WHEN Gross_Margin >= 26.91 THEN 1 ELSE 0 END) AS At_Or_Above_Benchmark,
    ROUND(
        SUM(CASE WHEN Gross_Margin < 26.91 THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS Percent_Below_Benchmark
FROM vw_customer_profitability;

-- Are these 191 below-benchmark customers actually important financially?
SELECT
    CASE
        WHEN Gross_Margin < 26.91 THEN 'Below Benchmark'
        ELSE 'At or Above Benchmark'
    END AS Profitability_Group,

    COUNT(*) AS Customers,

    ROUND(SUM(Orders), 0) AS Orders,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) / SUM(Revenue) * 100,
        2
    ) AS Gross_Margin

FROM vw_customer_profitability

GROUP BY
    CASE
        WHEN Gross_Margin < 26.91 THEN 'Below Benchmark'
        ELSE 'At or Above Benchmark'
    END

ORDER BY Revenue DESC;

-- Which customer segment is responsible for most of the below-benchmark revenue?"
SELECT
    Customer_Segment,

    COUNT(*) AS Customers,

    ROUND(SUM(Orders), 0) AS Orders,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) / SUM(Revenue) * 100,
        2
    ) AS Gross_Margin

FROM vw_customer_profitability

WHERE Gross_Margin < 26.91

GROUP BY Customer_Segment

ORDER BY Revenue DESC; 


-- Find the highest-revenue Corporate customers below benchmark

SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    Orders,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(Gross_Profit, 2) AS Gross_Profit,
    ROUND(Gross_Margin, 2) AS Gross_Margin
FROM vw_customer_profitability
WHERE Customer_Segment = 'Corporate'
  AND Gross_Margin < 26.91
ORDER BY Revenue DESC
LIMIT 20;

-- Analyze Siddharth's product mix

SELECT
    Product_Name,
    Category,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / SUM(Revenue) * 100,
        2
    ) AS Gross_Margin,
    ROUND(AVG(Discount_Percent), 2) AS Avg_Discount_Percent
FROM fact_customer_profitability
WHERE Customer_ID = 'CUS0898'
GROUP BY
    Product_Name,
    Category
ORDER BY Revenue DESC;

-- Investigate Siddharth's Exercise Bike discount
SELECT
    Order_ID,
    Order_Date,
    Quantity,
    Unit_Price,
    Discount_Percent,
    Gross_Sales,
    Revenue,
    COGS,
    Gross_Profit,
    ROUND(Gross_Margin * 100, 2) AS Gross_Margin_Percent
FROM fact_customer_profitability
WHERE Customer_ID = 'CUS0898'
  AND Product_Name = 'Exercise Bike'
ORDER BY Order_Date;

-- Is Exercise Bike inherently a low-margin product, or does the 20% discount systematically destroy its margin across the entire customer base?
SELECT
    Discount_Percent,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / SUM(Revenue) * 100,
        2
    ) AS Gross_Margin
FROM fact_customer_profitability
WHERE Product_Name = 'Exercise Bike'
GROUP BY Discount_Percent
ORDER BY Discount_Percent;

-- How much additional gross profit could the business generate if high-discount Exercise Bike sales were brought closer to the 5% discount level? 
SELECT
    Discount_Percent,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Actual_Gross_Profit,
    ROUND(
        SUM(Revenue) * 24.21 / 100,
        2
    ) AS Benchmark_Gross_Profit_At_5pct,
    ROUND(
        (SUM(Revenue) * 24.21 / 100) - SUM(Gross_Profit),
        2
    ) AS Potential_Profit_Uplift
FROM fact_customer_profitability
WHERE Product_Name = 'Exercise Bike'
GROUP BY Discount_Percent
ORDER BY Discount_Percent;
-- Which customers are receiving the highest discounts on Exercise Bikes? 
SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    COUNT(*) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / SUM(Revenue) * 100,
        2
    ) AS Gross_Margin,
    ROUND(AVG(Discount_Percent), 2) AS Avg_Discount
FROM fact_customer_profitability
WHERE Product_Name = 'Exercise Bike'
GROUP BY
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region
HAVING AVG(Discount_Percent) >= 15
ORDER BY Revenue DESC;
-- Executive KPI view
CREATE OR REPLACE VIEW vw_executive_kpis AS
SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    SUM(Quantity) AS Total_Units,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(COGS), 2) AS Total_COGS,
    ROUND(SUM(Gross_Profit), 2) AS Total_Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin,
    ROUND(
        SUM(Revenue) / NULLIF(COUNT(DISTINCT Order_ID), 0),
        2
    ) AS Average_Order_Value
FROM fact_customer_profitability;
SELECT * FROM vw_executive_kpis; 

-- Monthly performance view
CREATE OR REPLACE VIEW vw_monthly_performance AS
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin
FROM fact_customer_profitability
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Month;

SELECT *
FROM vw_monthly_performance; 


-- Segment Performance
CREATE OR REPLACE VIEW vw_segment_performance AS
SELECT
    Customer_Segment,
    COUNT(DISTINCT Customer_ID) AS Customers,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin
FROM fact_customer_profitability
GROUP BY Customer_Segment
ORDER BY Revenue DESC;

SELECT *
FROM vw_segment_performance;

-- Regional Performance
SELECT
    Region,
    COUNT(DISTINCT Customer_ID) AS Customers,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin
FROM fact_customer_profitability
GROUP BY Region
ORDER BY Revenue DESC;

CREATE OR REPLACE VIEW vw_customer_profitability AS
SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin
FROM fact_customer_profitability
GROUP BY
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region;
    
    SELECT *
FROM vw_customer_profitability
ORDER BY Revenue DESC
LIMIT 20;

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    Product_Name,
    Category,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Quantity) AS Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin
FROM fact_customer_profitability
GROUP BY
    Product_Name,
    Category
ORDER BY Revenue DESC;

SELECT *
FROM vw_product_performance
ORDER BY Revenue DESC;

SHOW CREATE VIEW vw_customer_profitability;

SHOW CREATE VIEW vw_monthly_performance;
SELECT VIEW_DEFINITION
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'vw_monthly_performance';
  
  SELECT
    Order_ID,
    COUNT(DISTINCT Region) AS Region_Count
FROM fact_customer_profitability
GROUP BY Order_ID
HAVING COUNT(DISTINCT Region) > 1;

SELECT
    Order_ID,
    COUNT(DISTINCT Customer_ID) AS Customer_Count
FROM fact_customer_profitability
GROUP BY Order_ID
HAVING COUNT(DISTINCT Customer_ID) > 1;

SELECT
    Order_ID,
    COUNT(DISTINCT Customer_Segment) AS Segment_Count
FROM fact_customer_profitability
GROUP BY Order_ID
HAVING COUNT(DISTINCT Customer_Segment) > 1;

SELECT
    Order_ID,
    COUNT(DISTINCT Sales_Channel) AS Channel_Count
FROM fact_customer_profitability
GROUP BY Order_ID
HAVING COUNT(DISTINCT Sales_Channel) > 1;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Order_ID) AS Unique_Orders,
    COUNT(*) - COUNT(DISTINCT Order_ID) AS Additional_Rows
FROM fact_customer_profitability;

SELECT
    SUM(Order_ID IS NULL) AS Missing_Order_ID,
    SUM(Customer_ID IS NULL) AS Missing_Customer_ID,
    SUM(Order_Date IS NULL) AS Missing_Order_Date,
    SUM(Region IS NULL) AS Missing_Region,
    SUM(Customer_Segment IS NULL) AS Missing_Segment,
    SUM(Sales_Channel IS NULL) AS Missing_Channel,
    SUM(Quantity IS NULL) AS Missing_Quantity,
    SUM(Revenue IS NULL) AS Missing_Revenue,
    SUM(COGS IS NULL) AS Missing_COGS,
    SUM(Gross_Profit IS NULL) AS Missing_Gross_Profit
FROM fact_customer_profitability;

SELECT
    COUNT(*) AS Incorrect_Gross_Profit_Rows
FROM fact_customer_profitability
WHERE ABS(Gross_Profit - (Revenue - COGS)) > 0.01;

SELECT
    COUNT(*) AS Incorrect_Revenue_Rows
FROM fact_customer_profitability
WHERE ABS(Revenue - (Gross_Sales - Discount_Amount)) > 0.01;

DESCRIBE fact_customer_profitability;

SELECT
    COUNT(*) AS Incorrect_COGS_Rows
FROM fact_customer_profitability
WHERE ABS(COGS - (Quantity * Unit_Cost)) > 0.01;

SELECT
    COUNT(*) AS Incorrect_Margin_Rows
FROM fact_customer_profitability
WHERE ABS(Gross_Margin - (Gross_Profit / NULLIF(Revenue, 0))) > 0.000001;

SELECT
    SUM(Quantity <= 0) AS Invalid_Quantity,
    SUM(Unit_Price < 0) AS Negative_Unit_Price,
    SUM(Unit_Cost < 0) AS Negative_Unit_Cost,
    SUM(Gross_Sales < 0) AS Negative_Gross_Sales,
    SUM(Revenue < 0) AS Negative_Revenue,
    SUM(COGS < 0) AS Negative_COGS
FROM fact_customer_profitability;

SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units,
    ROUND(SUM(Gross_Sales), 2) AS Gross_Sales,
    ROUND(SUM(Discount_Amount), 2) AS Total_Discount,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM fact_customer_profitability;

SELECT
    Year_Month,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units,
    ROUND(SUM(Gross_Sales), 2) AS Gross_Sales,
    ROUND(SUM(Discount_Amount), 2) AS Discount,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM fact_customer_profitability
GROUP BY Year_Month
ORDER BY Year_Month;

SELECT
    `Year_Month`,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units,
    ROUND(SUM(Gross_Sales), 2) AS Gross_Sales,
    ROUND(SUM(Discount_Amount), 2) AS Discount,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM fact_customer_profitability
GROUP BY `Year_Month`
ORDER BY `Year_Month`;