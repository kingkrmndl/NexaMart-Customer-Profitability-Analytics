SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,
    COUNT(DISTINCT Order_ID) AS Orders,
    SUM(Quantity) AS Units_Sold,
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
LIMIT 20;

SELECT
    ROUND(
        SUM(Gross_Profit) /
        NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Overall_Gross_Margin_Percent
FROM fact_customer_profitability;

-- High-revenue, below-average-margin customers

SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region,

    COUNT(DISTINCT Order_ID) AS Orders,

    ROUND(SUM(Revenue), 2) AS Revenue,

    ROUND(SUM(Gross_Profit), 2) AS Gross_Profit,

    ROUND(
        SUM(Gross_Profit)
        / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Percent

FROM fact_customer_profitability

GROUP BY
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Region

HAVING
    SUM(Revenue) >= 900000

    AND

    (
        SUM(Gross_Profit)
        / NULLIF(SUM(Revenue), 0) * 100
    ) < 26.91

ORDER BY
    Gross_Profit DESC;