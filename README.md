# NexaMart Customer Profitability & Revenue Intelligence

![Status](https://img.shields.io/badge/status-complete-brightgreen)
![Python](https://img.shields.io/badge/Python-pandas%20%7C%20numpy%20%7C%20Faker-blue)
![SQL](https://img.shields.io/badge/SQL-Data%20Modelling%20%26%20Analysis-orange)
![Power BI](https://img.shields.io/badge/Power%20BI-DAX%20%7C%20Dashboards-yellow)
![Excel](https://img.shields.io/badge/Excel-Raw%20Data-green)
![License](https://img.shields.io/badge/license-Portfolio%20Project-lightgrey)

> **Note:** NexaMart is a **fictional retail company**. All data used in this project is **synthetically generated** and does not represent the performance of any real business.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Business Context](#business-context)
3. [Business Problem](#business-problem)
4. [Project Objective](#project-objective)
5. [Technology Stack](#technology-stack)
6. [Analytical Workflow](#analytical-workflow)
7. [Dataset Design](#dataset-design)
8. [Customer Design](#customer-design)
9. [Analytical Architecture](#analytical-architecture)
10. [Data Structure & Table Architecture](#data-structure--table-architecture)
11. [Python: Data Generation & Preparation](#python-data-generation--preparation)
12. [SQL: Data Processing & Analysis](#sql-data-processing--analysis)
13. [Power BI: Data Model, DAX & Dashboard](#power-bi-data-model-dax--dashboard)
14. [Power BI Dashboard Pages](#power-bi-dashboard-pages)
15. [Dashboard Screenshots](#dashboard-screenshots)
16. [Data Validation & Quality Assurance](#data-validation--quality-assurance)
17. [Business Insights](#business-insights)
18. [Key Management Recommendations](#key-management-recommendations)
19. [Executive Summary](#executive-summary)
20. [Project Structure](#project-structure)
21. [Business Value / Portfolio Value](#business-value--portfolio-value)
22. [Interview / Project Takeaways](#interview--project-takeaways)
23. [Conclusion](#conclusion)
24. [Author / Portfolio](#author--portfolio)

---

## Project Overview

**NexaMart Customer Profitability & Revenue Intelligence** is an end-to-end business analytics project that simulates a multi-category retail business and analyzes it across the full analytics stack — **Python, SQL, Excel, and Power BI**.

The project converts raw, transaction-level retail data into a validated, business-ready analytical layer, and ultimately into an interactive Power BI dashboard suite that answers core commercial questions: which customers, products, categories, regions, and channels actually drive **profit** — not just revenue.

| Attribute | Detail |
|---|---|
| **Project Title** | NexaMart Customer Profitability & Revenue Intelligence |
| **Company** | NexaMart (fictional) |
| **Industry** | Retail |
| **Project Type** | End-to-End Business Analytics & Customer Profitability Analysis |
| **Data Type** | Synthetic business transaction dataset |
| **Analysis Period** | January 2023 – December 2025 |
| **Tools Used** | Python, SQL, Excel, Power BI |

---

## Business Context

NexaMart is a fictional multi-category retail company operating across multiple regions and sales channels. Management wants to better understand:

- Revenue performance
- Customer value
- Customer profitability
- Product profitability
- Category performance
- Regional performance
- Sales channel performance
- Discount impact on profitability

This project simulates a realistic retail business environment and demonstrates how raw transactional data can be transformed into actionable business intelligence that supports management decision-making.

---

## Business Problem

Revenue growth does not necessarily translate into proportional profit growth. A business can grow its top line while its profitability quietly erodes through excessive discounting, an unfavorable product mix, or reliance on low-margin channels.

Management therefore requires a data-driven analytical framework to understand the drivers of revenue and profitability across customers, products, categories, regions, and sales channels.

This analysis aims to answer:

1. Which products generate the most revenue and profit?
2. Which products and categories have weak profitability?
3. Which customers contribute the most value?
4. Which customer segments are the most profitable?
5. Which regions perform best and worst?
6. Which sales channels are most profitable?
7. How do discounts affect profitability and margins?
8. Where are the biggest opportunities for improving profit?

---

## Project Objective

Build an end-to-end analytics solution using **Python, SQL, Excel, and Power BI** that transforms transactional data into actionable business insights and management recommendations — from raw data generation, through validation and modelling, to an interactive decision-support dashboard.

---

## Technology Stack

### Excel
- Raw data storage
- Data inspection

### Python
- Synthetic data generation
- Data preparation
- Data validation
- Feature creation
- Exploratory analysis

**Libraries:** `pandas`, `numpy`, `Faker`, `openpyxl`, `matplotlib`

### SQL
- Data modelling
- Data transformation
- Business queries
- Customer profitability analysis
- Product analysis
- Category analysis
- Regional analysis
- Sales channel analysis
- KPI calculations
- Analytical views

### Power BI
- Data modelling
- Relationships
- DAX calculations
- KPI development
- Interactive dashboards
- Slicers
- Business visualisation

---

## Analytical Workflow

The project follows a structured, end-to-end analytics pipeline, moving data from raw generation through to business-ready insight:

```
Raw Data
   ↓
Python Data Generation & Preparation
   ↓
Data Cleaning
   ↓
Data Validation
   ↓
Exploratory Analysis
   ↓
SQL Data Modelling & Business Analysis
   ↓
Business Metrics
   ↓
Power BI Data Model & DAX
   ↓
Interactive Dashboard
   ↓
Business Insights
   ↓
Management Recommendations
```

Each stage builds on the previous one. Python establishes a clean, validated dataset; SQL structures that dataset into business-oriented aggregates and analytical views; Power BI turns those views into an interactive, decision-ready dashboard; and the final insights and recommendations translate all of the above into language a business stakeholder can act on.

---

## Dataset Design

| Attribute | Value |
|---|---|
| Dataset Type | Synthetic business transaction dataset |
| Company | NexaMart |
| Time Period | January 2023 – December 2025 |
| Orders | 10,000 |
| Customers | 1,000 |
| Products | 50 |
| Regions | North, South, East, West |
| Sales Channels | Online, Store |
| Customer Segments | Consumer, Small Business, Corporate |

The dataset was designed to support:

- Revenue analysis
- Gross profit analysis
- Gross margin analysis
- Customer profitability
- Product performance
- Category performance
- Regional performance
- Sales channel performance
- Discount analysis

---

## Customer Design

**Total Customers:** 1,000
**Customer ID Range:** `CUS0001` – `CUS1000`
**Customer Acquisition Period:** January 2021 – December 2025

### Customer Segments

- **Consumer** — smaller order values, more variable purchasing behaviour
- **Small Business** — moderate order values, more regular purchasing behaviour
- **Corporate** — larger order values, higher purchasing frequency

### Geographic Coverage

West Bengal, Maharashtra, Karnataka, Tamil Nadu, Delhi, Telangana, Gujarat, Uttar Pradesh — mapped to four business regions: **North, South, East, West**.

### Observed Order Distribution (by Segment)

| Segment | Orders |
|---|---|
| Consumer | 3,543 |
| Corporate | 3,478 |
| Small Business | 2,979 |
| **Total** | **10,000** |

> **Important:** These figures represent the distribution of **orders**, not the population share of customers. A segment can generate a disproportionate share of orders or profit relative to its customer count.

---

## Analytical Architecture

```
NexaMart
   ↓
Python
  - Data Generation
  - Data Preparation
  - Validation
  - Feature Creation
   ↓
Excel
  - Raw Dataset
  - Data Inspection
   ↓
SQL
  - Data Modelling
  - Business Queries
  - KPI Analysis
  - Customer Analysis
  - Product Analysis
   ↓
Power BI
  - Data Model
  - DAX
  - KPIs
  - Interactive Filters
  - Dashboards
   ↓
Business Insights
  - Findings
  - Recommendations
```

---

## Data Structure & Table Architecture

### Primary Fact Table: `fact_customer_profitability`

**Purpose:** Transaction-level customer profitability information.
**Primary Identifier:** `Order_ID`

| Category | Fields |
|---|---|
| **Customer** | `Customer_ID`, `Customer_Name`, `Customer_Segment`, `Customer_Since`, `Customer_Tenure_Days`, `Customer_Tenure_Years` |
| **Geographic** | `City`, `State`, `Region` |
| **Product** | `Product_ID`, `Product_Name`, `Category`, `Subcategory`, `Brand` |
| **Time** | `Order_Date`, `Year`, `Quarter`, `Month`, `Month_Name`, `Year_Month`, `Day_Name` |
| **Sales** | `Sales_Channel`, `Quantity`, `Unit_Price` |
| **Discount** | `Discount`, `Discount_Percent`, `Discount_Amount`, `Discount_Per_Unit` |
| **Financial** | `Unit_Cost`, `Gross_Sales`, `Revenue`, `Revenue_Per_Unit`, `COGS`, `Gross_Profit`, `Profit_Per_Unit`, `Gross_Margin` |

### Analytical View: `nexamart_analytics.vw_customer_profitability`

**Purpose:** Supports customer-level profitability analysis and Power BI visualisation.

**Key Dimensions:** Customer, Customer Segment, Region, State, Product, Category, Sales Channel, Time
**Key Metrics:** Revenue, COGS, Gross Profit, Gross Margin, Quantity, Discount Amount
**Data Granularity:** Order level

### Aggregation Principles

```
Customer Count = DISTINCT Customer_ID
Product Count  = DISTINCT Product_ID
Order Count    = DISTINCT Order_ID
Revenue        = SUM(Revenue)
Gross Profit   = SUM(Gross_Profit)
Gross Margin   = Gross Profit / Revenue
```

These principles ensure metrics are aggregated correctly regardless of the level of granularity being viewed. Counts of customers, products, and orders always use **distinct** counts to avoid inflation from multiple transaction rows belonging to the same entity, while financial metrics such as Revenue and Gross Profit are summed at the transaction level and Gross Margin is always **recalculated as a ratio of aggregates** (Gross Profit ÷ Revenue) rather than averaged row-by-row, which preserves mathematical accuracy at every level of the data model.

---

## Python: Data Generation & Preparation

Python was used to generate the synthetic NexaMart retail dataset from the ground up, simulating realistic business relationships between customers, products, and orders.

**Environment:** Python
**Libraries:** `pandas`, `numpy`, `Faker`, `openpyxl`, `matplotlib`

### Generated Entities

| Entity | Count |
|---|---|
| Customers | 1,000 |
| Products | 50 |
| Orders | 10,000 |

### Generated Attributes

| Entity | Attributes |
|---|---|
| **Customer** | `Customer_ID`, `Customer_Name`, `Customer_Segment`, `Customer_Since`, `Location`, `State`, `Region`, Customer Tenure |
| **Product** | `Product_ID`, `Product_Name`, `Category`, `Subcategory`, `Brand`, `Unit_Price`, `Unit_Cost` |
| **Order** | `Order_ID`, `Order_Date`, `Customer_ID`, `Product_ID`, `Quantity`, `Sales_Channel`, `Discount`, `Revenue`, `COGS`, `Gross_Profit`, `Gross_Margin` |

### Data Generation Relationships

```
Customer          → Orders
Product           → Orders
Customer Segment  → Customer Behaviour
Product           → Category / Subcategory / Brand
State             → Region
Order             → Revenue / Cost / Profitability
```

**Customer behaviour logic:**
- Consumer → smaller, more variable orders
- Small Business → moderate, more regular orders
- Corporate → larger, higher-frequency orders

### Financial Logic

```
Gross Sales   = Quantity × Unit Price
Revenue       = Gross Sales − Discount Amount
COGS          = Quantity × Unit Cost
Gross Profit  = Revenue − COGS
Gross Margin  = Gross Profit ÷ Revenue
```

### Python-Layer Validation

- Customer count
- Product count
- Order count
- Segment distribution
- Regional distribution
- Channel distribution
- Revenue
- COGS
- Gross profit
- Gross margin
- Duplicate IDs
- Missing values
- Invalid values

### Initial Generated Dataset — Financial Summary

> This reflects the dataset **immediately after Python generation**, prior to SQL modelling and Power BI aggregation. See [Important Financial Consistency Note](#-important-financial-consistency-note) below.

| Metric | Value |
|---|---|
| Gross Sales | **₹190.37M** |
| Discount Amount | **₹19.53M** |
| Revenue | **₹170.85M** |
| COGS | **₹124.68M** |
| Gross Profit | **₹46.17M** |
| Gross Margin | **27.02%** |

---

## SQL: Data Processing & Analysis

SQL served as the analytical layer between the raw transactional data and Power BI, responsible for validating, structuring, and aggregating the dataset into business-ready views.

### SQL Objectives

- Validate raw data
- Organise business entities
- Aggregate transaction data
- Calculate business metrics
- Analyse customers, customer segments, products, categories, regions, and sales channels
- Prepare analytical views

### Validation Performed in SQL

- Total orders
- Unique customers
- Unique products
- Duplicate `Order_ID`
- Missing values
- Segment distribution
- Regional distribution
- Channel distribution
- Revenue, COGS, Gross Profit reconciliation

### Financial Calculations

```sql
Gross Sales   = Quantity * Unit_Price
Revenue       = Gross_Sales - Discount_Amount
COGS          = Quantity * Unit_Cost
Gross_Profit  = Revenue - COGS
Gross_Margin  = Gross_Profit / Revenue
```

### Core Analysis Areas

| Analysis Area | Metrics Produced |
|---|---|
| **Customer Profitability** | Customer revenue, gross profit, gross margin, order count, quantity, discount amount, segment, region, channel |
| **Customer Segment** | Consumer, Small Business, Corporate comparisons |
| **Product / Category** | Product & category revenue, gross profit, gross margin, quantity, discount |
| **Regional** | North, South, East, West |
| **Sales Channel** | Online, Store |
| **Time** | `Order_Date`, Year, Quarter, Month, Month_Name, Year_Month |

**Analytical View Produced:** `nexamart_analytics.vw_customer_profitability`

### SQL → Power BI Workflow

```
Raw Transaction Data
       ↓
SQL Validation
       ↓
SQL Transformation / Aggregation
       ↓
Analytical Views
       ↓
Power BI Data Model
       ↓
DAX Measures
       ↓
Interactive Dashboard
```

---

## Power BI: Data Model, DAX & Dashboard

Power BI represents the final business intelligence and visualisation layer of the project, turning the SQL analytical view into an interactive, decision-ready dashboard suite.

### Power BI Objectives

- Monitor overall performance
- Analyse revenue and profitability
- Compare customer segments
- Analyse customers, products, and categories
- Compare regions and channels
- Analyse discounts
- Provide interactive filtering
- Support management decisions

### Data Model Dimensions

Customers · Products · Categories · Regions · Sales Channels · Time · Transactions · Profitability

### Core Business Measures (DAX)

| Measure | Formula |
|---|---|
| Revenue | `SUM(Revenue)` |
| Gross Profit | `Revenue − COGS` |
| Gross Margin | `Gross Profit ÷ Revenue` |
| Gross Sales | Sum of gross sales before discount |
| Discount Amount | Sum of discount value applied |
| COGS | Sum of cost of goods sold |
| Order Count | Distinct count of `Order_ID` |
| Customer Count | Distinct count of `Customer_ID` |
| Product Count | Distinct count of `Product_ID` |
| Average Order Value | Revenue ÷ Order Count |

### Filters & Slicers

Region · Customer Segment · Sales Channel · Product · Category · Time

The **Region slicer** was specifically tested to ensure regional selections propagate correctly across all relevant dashboard visuals, maintaining consistent filter context throughout the report.

---

## Power BI Dashboard Pages

The completed Power BI solution contains **three main dashboard pages**, each designed to answer a distinct business question.

### Page 1 — Executive Dashboard

**Purpose:** Provide management with a high-level view of overall business performance.

**Key Metrics:** Revenue, Gross Profit, Gross Margin, Orders, Customers, product performance, regional performance, and time trends.

**What it answers:** *"How is the business performing overall, and where is that performance concentrated?"*

### Page 2 — Customer & Segment Analysis

**Purpose:** Analyse customer value, customer profitability, and customer segments.

**Key Analysis:** Customer contribution, top customers, customer profitability, customer segments, revenue by segment, gross profit by segment, segment comparisons.

**What it answers:** *"Which customers and segments actually drive profit, not just revenue?"*

### Page 3 — Product & Category Analysis

**Purpose:** Analyse product and category profitability.

**Key Analysis:** Product revenue, product gross profit, product margin, category revenue, category gross profit, quantity sold, discount behaviour, product comparison.

**What it answers:** *"Which products and categories should be prioritised, expanded, or reviewed?"*

### Visualisation Approach

| Visual Type | Usage |
|---|---|
| KPI Cards | High-level headline metrics |
| Bar / Column Charts | Comparisons across products, categories, segments, regions, channels |
| Line Charts | Time trends |
| Donut / Pie Charts | Composition and contribution (used selectively) |
| Tables | Detailed customer and product analysis |
| Slicers | Interactive filtering |

### Dashboard Design Principles

- Clear visual hierarchy
- Consistent KPI presentation
- Limited clutter
- Business-focused titles
- Consistent spacing and formatting
- Interactive filtering
- Actionable comparisons

---

## Dashboard Screenshots

> **Note:** Image filenames below are representative placeholders matching the `screenshots/` folder structure. Replace them with the actual exported filenames if they differ in your repository.

### Executive Dashboard

![Executive Dashboard](screenshots/executive_dashboard.png)

*Answers: How is NexaMart performing overall — revenue, profit, margin, orders, and top-level trends across regions and time?*

### Customer & Segment Analysis

![Customer & Segment Analysis](screenshots/customer_segment_analysis.png)

*Answers: Which customers and customer segments generate the most value and profit for the business?*

### Product & Category Analysis

![Product & Category Analysis](screenshots/product_category_analysis.png)

*Answers: Which products and categories are the strongest — and weakest — contributors to gross profit and margin?*

---

## Data Validation & Quality Assurance

Validation was performed continuously across every layer of the pipeline:

```
1. Python generation
2. Raw data validation
3. SQL validation
4. Financial validation
5. Power BI model validation
6. Dashboard validation
```

### Python Validation

- Customer count, product count, order count
- Unique IDs
- Missing values
- Invalid values
- Relationship integrity

**Expected values:** Customers = 1,000 · Products = 50 · Orders = 10,000

### Financial Validation

```
Gross Sales   = Quantity × Unit Price
Revenue       = Gross Sales − Discount Amount
COGS          = Quantity × Unit Cost
Gross Profit  = Revenue − COGS
Gross Margin  = Gross Profit ÷ Revenue
```

**Initial financial benchmark (post-generation):**

| Metric | Value |
|---|---|
| Gross Sales | ₹190.37M |
| Discount Amount | ₹19.53M |
| Revenue | ₹170.85M |
| COGS | ₹124.68M |
| Gross Profit | ₹46.17M |
| Gross Margin | 27.02% |

### SQL Validation

Orders · Customers · Products · Revenue · COGS · Gross Profit · Segments · Regions · Channels

### Power BI Validation

Revenue · Gross Profit · Gross Margin · Orders · Customers · Products · Regional totals · Segment totals

### Filter Validation

Region · Customer Segment · Sales Channel · Product · Category · Time

### Cross-Source Validation

```
Python
  ↓
SQL
  ↓
Power BI
```

Any differences observed between layers were investigated through: aggregation level, filter context, relationships, distinct counts, analytical views, and DAX evaluation context.

### ⚠ Important Financial Consistency Note

This project contains **two distinct sets of financial figures**, and they are intentionally **not** the same:

| | Gross Sales | Discount | Revenue | COGS | Gross Profit | Gross Margin |
|---|---|---|---|---|---|---|
| **Initial Python Dataset Validation** | ₹190.37M | ₹19.53M | ₹170.85M | ₹124.68M | ₹46.17M | 27.02% |
| **Final Analytical / Power BI Figures** | ₹194.14M | ₹19.76M | ₹174.38M | ₹127.46M | ₹46.92M | 26.91% |

The **first set** represents the initial generated dataset immediately after Python validation. The **second set** represents the final analytical/reporting layer — after SQL transformation and Power BI modelling — and is the figure set used throughout the **Business Insights**, **Executive Summary**, and dashboard sections of this README. The two sets are not interchangeable and should not be mixed.

---

## Business Insights

### 1. Overall Business Performance

**Finding:** NexaMart generated **₹174.38 million** in revenue and **₹46.92 million** in gross profit across **10,000 orders**. The resulting gross margin was **26.91%**, meaning approximately ₹26.91 of gross profit was generated for every ₹100 of revenue.

| Metric | Value |
|---|---|
| Revenue | **₹174.38M** |
| Gross Profit | **₹46.92M** |
| Gross Margin | **26.91%** |
| Orders | **10,000** |
| Customers | **998** |

**Business Implication:** NexaMart demonstrates a substantial revenue base and positive gross profitability. However, a 26.91% gross margin means profitability must be evaluated alongside revenue growth. Management should assess which customers, products, regions, and channels contribute most effectively to gross profit rather than judging performance on revenue alone.

---

### 2. Customer Performance

**Finding:** The highest-profit customers are concentrated in the **Corporate** segment. The Top Customers by Gross Profit analysis shows the leading customers generate substantial individual contributions to overall profitability, with the top performer generating approximately **₹0.35 million** in gross profit.

**Top 5 Customers by Gross Profit:**

| Rank | Customer | Approx. Gross Profit |
|---|---|---|
| 1 | Dalbir Agrawal | ₹346.9K |
| 2 | Siddharth Bains | ₹338.2K |
| 3 | Ryan Lai | ₹310.0K |
| 4 | Ekani Raj | ₹290.7K |
| 5 | Gautam Mane | ₹279.1K |

All leading customers in the Top 10 Gross Profit analysis belong to the **Corporate** segment.

**Business Implication:** Corporate customers represent an important source of customer-level profitability. Management should focus on retaining high-value Corporate customers and understanding their purchasing behaviour, while also monitoring customer concentration risk from over-reliance on a small number of highly profitable accounts.

---

### 3. Customer Segment Performance

**Finding:** Customer segments show a clear divergence between margin efficiency and absolute profit contribution. **Consumer** customers have the highest average gross margin, followed by **Small Business**, while **Corporate** has the lowest average gross margin — yet the highest individual customers by gross profit are concentrated in the Corporate segment.

| Segment | Average Gross Margin |
|---|---|
| Consumer | **37%** |
| Small Business | **35%** |
| Corporate | **31%** |

**Business Implication:** Corporate customers generate strong absolute profit despite a lower average margin. Management should avoid evaluating segments on gross margin alone and instead balance **absolute gross profit contribution** with **gross margin percentage**. Consumer customers may offer stronger margin efficiency, while Corporate customers offer greater absolute profit contribution. Potential improvement levers include pricing, discount management, and product mix optimisation.

---

### 4. Product & Category Performance

**Finding:** Product profitability is concentrated among a small number of high-performing products. At category level, **Furniture** generates the highest revenue and gross profit, **Electronics** achieves a substantially higher gross margin, and **Office Supplies** has the highest margin but the lowest absolute scale.

**Top Products:**

| Product ID | Product | Revenue | Gross Profit | Gross Margin |
|---|---|---|---|---|
| PROD045 | Exercise Bike | ₹25.12M | ₹4.97M | 19.80% |
| PROD014 | Standing Desk | ₹15.28M | ₹3.59M | 23.48% |
| PROD012 | Executive Office Chair | ₹10.74M | ₹2.58M | — |

**Category Performance:**

| Category | Revenue | Gross Profit | Gross Margin |
|---|---|---|---|
| Furniture | ₹65.91M | ₹16.51M | 25.05% |
| Electronics | ₹32.15M | ₹10.44M | **32.46%** |
| Sports & Fitness | ₹41.62M | ₹10.37M | 24.92% |
| Home & Lifestyle | ₹31.85M | ₹8.50M | 26.68% |
| Office Supplies | ₹2.85M | ₹1.10M | **38.74%** |

**Business Implication:** Furniture should remain a major commercial priority given its scale. Electronics is attractive because its 32.46% margin is well above the overall business margin of 26.91%, while still contributing meaningfully to revenue and profit. Office Supplies shows strong margin efficiency but limited scale — worth investigating for careful expansion. At the product level, high-profit products merit stronger inventory and promotional support, while lower-margin products should be reviewed for pricing, discounting, sourcing, and cost optimisation.

---

### 5. Regional Performance

**Finding:** **South** is the largest contributor to revenue and gross profit, while **West** achieves the highest gross margin.

| Region | Revenue | Gross Profit | Gross Margin | Orders |
|---|---|---|---|---|
| South | ₹69.83M | ₹18.45M | 26.43% | 3,821 |
| North | ₹44.07M | ₹11.98M | 27.19% | 2,608 |
| West | ₹38.50M | ₹10.59M | **27.50%** | 2,318 |
| East | ₹21.98M | ₹5.89M | 26.82% | 1,253 |

**Business Implication:** South should remain a strategic priority due to its strong revenue and profit contribution. West is a useful benchmark for margin efficiency — management should investigate the pricing, product mix, discounting, and customer composition that allow West to outperform on margin. The strategic objective is to combine South's scale with West's margin efficiency.

---

### 6. Sales Channel Performance

**Finding:** **Store** generates higher absolute revenue and gross profit, while **Online** achieves a higher gross margin and more orders.

| Channel | Revenue | Gross Profit | Gross Margin | Quantity Sold | Orders |
|---|---|---|---|---|---|
| Store | ₹92.33M | ₹24.36M | 26.39% | 26,991 | 4,564 |
| Online | ₹82.06M | ₹22.56M | **27.49%** | 23,501 | **5,436** |

Store generates approximately **₹10.27M more revenue** and **₹1.80M more gross profit** than Online. Online has a **1.10 percentage-point higher gross margin** and approximately **872 more orders**.

**Business Implication:** Store remains important as the largest absolute contributor to revenue and gross profit. However, Online's higher margin and order volume signal strong digital growth potential. Management should investigate product mix, pricing, discount levels, and customer behaviour with the objective of growing Online sales without sacrificing its profitability advantage.

---

### 7. Discount & Profitability Analysis

**Finding:** NexaMart generated approximately **₹194.14M** in gross sales, with **₹19.76M** in discount amount, resulting in **₹174.38M** in revenue. The overall discount rate is **10.18%**, and gross profit is approximately **₹46.92M**, producing a gross margin of **26.91%**.

| Metric | Value |
|---|---|
| Gross Sales | ₹194.14M |
| Discount Amount | ₹19.76M |
| Revenue | ₹174.38M |
| COGS | ₹127.46M |
| Gross Profit | ₹46.92M |
| Discount Rate | **10.18%** |
| Gross Margin | **26.91%** |

**Business Implication:** Discounting should be managed as a **profitability lever**, not merely a sales-generation mechanism. Management should identify which products, segments, regions, and channels see higher discounts paired with weaker margins, and pursue a targeted discount strategy that protects gross margin while still supporting sales growth.

---

## Key Management Recommendations

| # | Recommendation | Why It Matters | Expected Business Impact |
|---|---|---|---|
| 1 | **Protect and grow high-profit customers** | The top Corporate customers contribute disproportionately to gross profit; losing them would materially affect profitability. | Stabilises and grows the profit base through targeted retention efforts. |
| 2 | **Improve Corporate customer margin** | Corporate has the lowest average gross margin (31%) despite the highest absolute profit contribution. | Improves overall profitability without sacrificing Corporate revenue scale. |
| 3 | **Prioritise high-profit products** | A small number of products (e.g., Exercise Bike, Standing Desk) drive a disproportionate share of gross profit. | Better inventory, marketing, and shelf/placement allocation toward proven profit drivers. |
| 4 | **Expand attractive categories such as Electronics carefully** | Electronics combines meaningful scale with a 32.46% margin, well above the company average. | Incremental margin-accretive revenue growth if expansion is managed carefully. |
| 5 | **Use West as a margin-efficiency benchmark** | West achieves the highest regional gross margin (27.50%) despite not having the largest revenue. | Provides a replicable model for improving margins in other regions. |
| 6 | **Scale Online while protecting its margin advantage** | Online has a higher margin and more orders than Store, indicating efficient, scalable growth potential. | Growing Online strategically could raise overall company margin over time. |
| 7 | **Optimise discounting** | A 10.18% overall discount rate directly compresses gross margin; discount effectiveness varies by segment/product/region. | A more targeted discount strategy protects margin while still supporting sales volume. |
| 8 | **Monitor revenue versus profitability, not revenue alone** | A 26.91% overall gross margin shows that revenue growth alone is not sufficient. | Encourages profit-based decision-making across the leadership team going forward. |

---

## Executive Summary

NexaMart, a fictional multi-category retailer, generated **₹174.38M** in revenue and **₹46.92M** in gross profit across **10,000 orders** and **998 customers**, for an overall gross margin of **26.91%**. Gross sales of **₹194.14M** were reduced by **₹19.76M** in discounts (a **10.18%** discount rate) to arrive at reported revenue, against a cost base (COGS) of **₹127.46M**.

Performance is not evenly distributed. **South** is the largest contributor to revenue and gross profit among all regions, while **West** achieves the highest regional gross margin — a useful benchmark for margin efficiency elsewhere. **Store** remains the largest channel by absolute revenue and profit, but **Online** operates at a higher margin and a higher order count, pointing to strong, profitable growth potential in digital sales.

At the category level, **Furniture** is the largest category by revenue and gross profit, **Electronics** combines healthy scale with a strong 32.46% margin, and **Office Supplies** posts the highest margin of any category but at the smallest scale. Customer-level analysis shows that **Corporate** customers — while carrying the lowest average segment margin (31% vs. 37% for Consumer and 35% for Small Business) — dominate the list of top individual customers by absolute gross profit, underscoring the need to evaluate customers on both margin and absolute contribution.

Together, these findings support a clear strategic direction: protect and grow the most profitable customers and products, use high-margin regions and channels as internal benchmarks, expand attractive categories carefully, and treat discounting as a profitability lever rather than a blunt sales tool.

---

## Project Structure

```
NexaMart-Customer-Profitability-Revenue-Intelligence/
│
├── python/
│   ├── 01_generate_customers.py
│   ├── 02_generate_orders.py
│   ├── 03_*.py
│   ├── 04_*.py
│   ├── 05_*.py
│   ├── 06_*.py
│   └── 07_*.py
│
├── sql/
│   ├── validation_queries.sql
│   ├── customer_analysis.sql
│   ├── product_analysis.sql
│   ├── regional_analysis.sql
│   ├── channel_analysis.sql
│   └── profitability_analysis.sql
│
├── data/
│   └── NexaMart_Raw_Data.xlsx
│
├── powerbi/
│   └── NexaMart_Customer_Profitability.pbix
│
├── screenshots/
│   ├── executive_dashboard.png
│   ├── customer_segment_analysis.png
│   └── product_category_analysis.png
│
├── presentation/
│   └── NexaMart_Business_Analytics_Presentation.pptx
│
└── README.md
```

> The filenames and folder names above are **representative** of the project's structure. Update them to match the actual filenames present in your repository if they differ.

---

## Business Value / Portfolio Value

This project was built to demonstrate a realistic, end-to-end business analytics workflow — from raw data through to management-ready recommendations.

### Technical Skills Demonstrated

Python · SQL · Power BI · DAX · Excel · Data validation · Data modelling · Business analytics

### Analytical Skills Demonstrated

Customer profitability analysis · Revenue analysis · Margin analysis · Product analysis · Segment analysis · Regional analysis · Channel analysis · Discount analysis · KPI development · Business recommendations

### Business Skills Demonstrated

- Translating raw data into actionable insights
- Identifying the true drivers of profitability, not just revenue
- Supporting management-level decision-making with evidence
- Distinguishing **revenue growth** from **profitable growth**

---

## Interview / Project Takeaways

### "Tell me about your NexaMart project."

*This project simulates an end-to-end retail analytics engagement for a fictional company, NexaMart. The core business problem was that revenue growth doesn't guarantee profit growth, so I built a pipeline to understand where profitability actually comes from. I used Python to generate and validate a realistic synthetic dataset of 10,000 orders across 1,000 customers and 50 products. I then used SQL to model the data, run validation checks, and build analytical views covering customers, products, categories, regions, channels, and discounts. Finally, I built a three-page Power BI dashboard — an executive overview, a customer & segment view, and a product & category view — using DAX measures for revenue, gross profit, and gross margin. The key findings were that Corporate customers drive the most absolute profit despite having the lowest margin, South leads on scale while West leads on margin, and Online is a smaller but more profitable channel than Store. I translated these into concrete recommendations around customer retention, margin improvement, category expansion, and discount optimisation.*

### Likely Interview Questions & Answers

**1. Why did you use synthetic data?**
To build a complete, realistic retail analytics project without access to proprietary business data, while still controlling data quality and being able to validate every number end-to-end.

**2. Why did you use Python?**
For generating and preparing the dataset, performing feature creation, and running initial data validation before the data entered the SQL layer.

**3. Why SQL?**
SQL provided the structured, reusable analytical layer — validation, aggregation, and business logic — that sits between raw data and the Power BI dashboard.

**4. Why Power BI?**
Power BI turns validated SQL views into an interactive, business-facing dashboard with DAX measures, filters, and slicers that support real management decision-making.

**5. What is gross margin?**
Gross margin is gross profit expressed as a percentage of revenue (`Gross Profit ÷ Revenue`), showing how much of each rupee of revenue is retained after direct costs.

**6. Difference between revenue and gross profit?**
Revenue is total sales after discounts; gross profit is revenue minus the cost of goods sold (COGS). Revenue measures sales scale, while gross profit measures actual profitability.

**7. Why can high revenue still mean weak profitability?**
Because revenue doesn't account for cost structure. High-revenue products, customers, or channels can carry high discounts or high costs, resulting in a low gross margin despite strong sales.

**8. How did you validate your data?**
At every layer — Python (counts, duplicates, missing/invalid values), SQL (aggregation and reconciliation checks), and Power BI (cross-checking KPI totals and filter behaviour against the SQL layer).

**9. How did you handle customer counts?**
Customer counts were calculated using `DISTINCT Customer_ID` to avoid inflation from multiple orders per customer, which is why the reported customer count (998) is close to, but not exactly, the generated 1,000.

**10. Why is South important?**
South is the largest region by both revenue and gross profit, making it the single biggest driver of company-wide performance.

**11. Why is West interesting?**
West has the highest regional gross margin (27.50%), making it a useful internal benchmark for how the business can be more profitable, not just larger.

**12. Why is Online strategically important?**
Online has a higher gross margin and more orders than Store, suggesting it can scale profitably if managed carefully.

**13. Why is Electronics attractive?**
Electronics combines meaningful revenue scale with a 32.46% gross margin — well above the company average of 26.91% — making it a strong candidate for careful expansion.

**14. Why is Office Supplies not automatically the best category despite the highest margin?**
Because it has the smallest revenue and gross profit of all categories — high margin efficiency doesn't offset its limited scale and overall contribution to company profit.

**15. How can discounts affect profitability?**
Discounts directly reduce revenue and therefore compress gross margin; without monitoring, discounting used purely to drive volume can erode profitability even as sales grow.

**16. How did you make the Region slicer work across visuals?**
By ensuring the data model relationships and filter context were correctly configured, then explicitly testing the Region slicer against every relevant visual to confirm selections propagated consistently.

**17. What business recommendation would you prioritise?**
Protecting and growing high-profit Corporate customers, since they represent the single largest concentration of absolute gross profit and the highest retention risk if lost.

---

## Conclusion

The **NexaMart Customer Profitability & Revenue Intelligence** project demonstrates a complete, end-to-end approach to converting raw transactional data into validated, decision-ready business intelligence. Starting from synthetic data generation in Python, through structured business modelling in SQL, to an interactive three-page Power BI dashboard, the project consistently distinguishes **revenue growth** from **profitable growth** and translates that distinction into concrete, evidence-based management recommendations.

---

## Author / Portfolio

**Author:** Kingkar Mandal
**Role Target:** Data Analyst
**Skills:** SQL | Python | Power BI | Excel | Econometrics & Data Analytics
