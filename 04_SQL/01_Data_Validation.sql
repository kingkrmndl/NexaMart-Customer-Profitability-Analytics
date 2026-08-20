-- Customer Profitability Analysis
SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    COUNT(DISTINCT Order_ID) AS Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
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
ORDER BY Gross_Profit DESC
LIMIT 20;

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
ORDER BY Gross_Profit DESC
LIMIT 20;

SELECT *
FROM vw_customer_profitability
ORDER BY Gross_Profit ASC
LIMIT 20;

-- Are our most profitable customers also our most valuable customers in terms of revenue?
DESCRIBE vw_customer_profitability;
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
ORDER BY Revenue DESC
LIMIT 20;