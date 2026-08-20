CREATE DATABASE NexaMart_Analytics;
SHOW DATABASES;
USE NexaMart_Analytics;
SELECT DATABASE();

CREATE TABLE fact_customer_profitability (
    Order_ID VARCHAR(20) NOT NULL,
    Order_Date DATE NOT NULL,

    Order_Year INT NOT NULL,
    Quarter VARCHAR(5) NOT NULL,
    Month INT NOT NULL,
    Month_Name VARCHAR(20) NOT NULL,
    Order_Year_Month VARCHAR(7) NOT NULL,

    Customer_ID VARCHAR(20) NOT NULL,
    Customer_Name VARCHAR(100) NOT NULL,
    Customer_Segment VARCHAR(50) NOT NULL,
    Customer_Since DATE NOT NULL,
    Customer_Tenure_Days INT NOT NULL,
    Customer_Tenure_Years DECIMAL(10,6) NOT NULL,

    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Region VARCHAR(20) NOT NULL,

    Product_ID VARCHAR(20) NOT NULL,
    Product_Name VARCHAR(150) NOT NULL,
    Category VARCHAR(100) NOT NULL,
    Subcategory VARCHAR(100) NOT NULL,
    Brand VARCHAR(100) NOT NULL,

    Sales_Channel VARCHAR(30) NOT NULL,

    Quantity INT NOT NULL,
    Unit_Price DECIMAL(15,2) NOT NULL,
    Discount DECIMAL(5,2) NOT NULL,
    Discount_Percent DECIMAL(6,2) NOT NULL,
    Discount_Amount DECIMAL(15,2) NOT NULL,
    Discount_Per_Unit DECIMAL(15,3) NOT NULL,

    Unit_Cost DECIMAL(15,2) NOT NULL,
    Gross_Sales DECIMAL(15,2) NOT NULL,
    Revenue DECIMAL(15,2) NOT NULL,
    Revenue_Per_Unit DECIMAL(15,3) NOT NULL,
    COGS DECIMAL(15,2) NOT NULL,
    Gross_Profit DECIMAL(15,2) NOT NULL,
    Profit_Per_Unit DECIMAL(15,3) NOT NULL,
    Gross_Margin DECIMAL(10,6) NOT NULL,

    Day_Name VARCHAR(20) NOT NULL,

    PRIMARY KEY (Order_ID)
);

SHOW TABLES;
select * from fact_customer_profitability;
drop table fact_customer_profitability;
DESCRIBE fact_customer_profitability;
SELECT COUNT(*) AS total_rows
FROM fact_customer_profitability;
ALTER TABLE fact_customer_profitability
    CHANGE COLUMN `Order_Year` `Year` INT NOT NULL,
    CHANGE COLUMN `Order_Year_Month` `Year_Month` VARCHAR(7) NOT NULL;
    
SHOW COLUMNS FROM fact_customer_profitability;
SELECT COUNT(DISTINCT Order_ID) AS unique_orders
FROM fact_customer_profitability;

-- missing values

SELECT
    COUNT(*) AS total_rows,
    COUNT(Order_ID) AS order_ids,
    COUNT(Order_Date) AS order_dates,
    COUNT(Customer_ID) AS customer_ids,
    COUNT(Product_ID) AS product_ids,
    COUNT(Revenue) AS revenues,
    COUNT(Gross_Profit) AS profits
FROM fact_customer_profitability;

SELECT
    ROUND(SUM(Gross_Sales), 2) AS gross_sales,
    ROUND(SUM(Discount_Amount), 2) AS discount_amount,
    ROUND(SUM(Revenue), 2) AS revenue,
    ROUND(SUM(COGS), 2) AS cogs,
    ROUND(SUM(Gross_Profit), 2) AS gross_profit,
    ROUND(SUM(Gross_Profit) / SUM(Revenue) * 100, 2) AS gross_margin_percent
FROM fact_customer_profitability;

 -- Which customers generate the most revenue and gross profit?
 
 SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,

    COUNT(DISTINCT Order_ID) AS Total_Orders,

    SUM(Quantity) AS Total_Units,

    ROUND(SUM(Gross_Sales), 2) AS Gross_Sales,

    ROUND(SUM(Discount_Amount), 2) AS Discount_Amount,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(COGS), 2) AS COGS,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region

ORDER BY
    Gross_Profit DESC;
    
    -- Top 10 customers by Gross Profit 
    
    SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent
FROM fact_customer_profitability
GROUP BY
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region
ORDER BY
    Gross_Profit DESC
LIMIT 10;

-- Which customer segment is actually most valuable to NexaMart?

SELECT
    Customer_Segment,

    COUNT(DISTINCT Customer_ID) AS Customers,

    COUNT(DISTINCT Order_ID) AS Total_Orders,

    SUM(Quantity) AS Total_Units,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(COGS), 2) AS COGS,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Customer_Segment

ORDER BY
    Gross_Profit DESC;
    
    -- lets us identify where NexaMart's profit actually comes from.
    
    SELECT
    Customer_Segment,

    COUNT(DISTINCT Customer_ID) AS Customers,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(
        SUM(Revenue) /
        SUM(SUM(Revenue)) OVER () * 100,
        2
    ) AS Revenue_Share_Percent,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) /
        SUM(SUM(Gross_Profit)) OVER () * 100,
        2
    ) AS Gross_Profit_Share_Percent,

    ROUND(
        SUM(Gross_Profit) /
        NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Customer_Segment

ORDER BY
    Gross_Profit DESC;
    
    -- where the profit is being generated geographically.
    
    SELECT
    Region,

    COUNT(DISTINCT Customer_ID) AS Customers,

    COUNT(DISTINCT Order_ID) AS Total_Orders,

    SUM(Quantity) AS Total_Units,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(COGS), 2) AS COGS,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) /
        NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Region

ORDER BY
    Gross_Profit DESC;
    
    -- what is driving regional profitability.
    
    SELECT
    Region,
    Customer_Segment,

    COUNT(DISTINCT Customer_ID) AS Customers,

    COUNT(DISTINCT Order_ID) AS Total_Orders,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit) /
        NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Region,
    Customer_Segment

ORDER BY
    Region,
    Gross_Profit DESC;
    
    -- Why does Corporate have a lower margin than Consumer?
    
    SELECT
    Customer_Segment,

    COUNT(DISTINCT Customer_ID) AS Customers,

    COUNT(DISTINCT Order_ID) AS Orders,

    ROUND(AVG(Discount_Percent), 2) AS Avg_Discount_Percent,

    ROUND(
        SUM(Discount_Amount),
        2
    ) AS Total_Discount_Amount,

    ROUND(
        SUM(Gross_Sales),
        2
    ) AS Gross_Sales,

    ROUND(
        SUM(Revenue),
        2
    ) AS Revenue,

    ROUND(
        SUM(Gross_Profit),
        2
    ) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit)
        / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Customer_Segment

ORDER BY
    Avg_Discount_Percent DESC;