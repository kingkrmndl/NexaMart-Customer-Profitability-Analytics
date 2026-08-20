SELECT USER();
SELECT USER(), 
CURRENT_USER();

ALTER USER 'root'@'localhost' IDENTIFIED BY 'King@9832';
FLUSH PRIVILEGES;


SELECT
    Product_ID,
    Product_Name,
    Category,
    SUM(Revenue) AS Revenue,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) AS Gross_Margin
FROM fact_customer_profitability
GROUP BY
    Product_ID,
    Product_Name,
    Category
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    Region,
    SUM(Revenue) AS Revenue,
    SUM(Gross_Profit) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Orders
FROM fact_customer_profitability
GROUP BY Region
ORDER BY Gross_Profit DESC;

SELECT
    Sales_Channel,
    SUM(Revenue) AS Revenue,
    SUM(Gross_Profit) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Orders
FROM fact_customer_profitability
GROUP BY Sales_Channel
ORDER BY Gross_Profit DESC;

SELECT
    SUM(Gross_Sales) AS Gross_Sales,
    SUM(Discount_Amount) AS Discount_Amount,
    SUM(Revenue) AS Revenue,
    SUM(COGS) AS COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    ROUND(
        SUM(Discount_Amount) / NULLIF(SUM(Gross_Sales), 0) * 100,
        2
    ) AS Discount_Rate_Percent,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent
FROM fact_customer_profitability;

SELECT
    Category,
    SUM(Revenue) AS Revenue,
    SUM(Gross_Profit) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Orders,
    COUNT(DISTINCT Product_ID) AS Products
FROM fact_customer_profitability
GROUP BY Category
ORDER BY Gross_Profit DESC;