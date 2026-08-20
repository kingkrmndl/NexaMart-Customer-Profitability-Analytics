from pathlib import Path

import pandas as pd


# ============================================================
# 1. PROJECT PATHS
# ============================================================

PROJECT_DIR = Path(__file__).resolve().parent.parent

RAW_DATA_DIR = PROJECT_DIR / "01_Raw_Data"

PROCESSED_DATA_DIR = PROJECT_DIR / "02_Processed_Data"

EXCEL_FILE = RAW_DATA_DIR / "NexaMart_Raw_Data.xlsx"

OUTPUT_FILE = (
    PROCESSED_DATA_DIR
    / "NexaMart_Analytical_Dataset.xlsx"
)


# ============================================================
# 2. START
# ============================================================

print("=" * 70)

print("NexaMart — Analytical Dataset Builder")

print("=" * 70)


print("\nProject folder:")
print(PROJECT_DIR)

print("\nRaw data file:")
print(EXCEL_FILE)

print("\nOutput file:")
print(OUTPUT_FILE)


# ============================================================
# 3. CHECK SOURCE FILE
# ============================================================

if not EXCEL_FILE.exists():

    raise FileNotFoundError(
        f"Source Excel file not found:\n{EXCEL_FILE}"
    )


# ============================================================
# 4. CREATE PROCESSED DATA FOLDER
# ============================================================

PROCESSED_DATA_DIR.mkdir(
    parents=True,
    exist_ok=True
)


print("\nProcessed data folder ready:")
print(PROCESSED_DATA_DIR)


# ============================================================
# 5. LOAD SOURCE SHEETS
# ============================================================

print("\n" + "=" * 70)

print("LOADING SOURCE DATA")

print("=" * 70)


orders_df = pd.read_excel(
    EXCEL_FILE,
    sheet_name="Orders"
)


customers_df = pd.read_excel(
    EXCEL_FILE,
    sheet_name="Customers"
)


products_df = pd.read_excel(
    EXCEL_FILE,
    sheet_name="Products"
)


calendar_df = pd.read_excel(
    EXCEL_FILE,
    sheet_name="Calendar"
)


print(
    "\nOrders loaded:",
    len(orders_df)
)


print(
    "Customers loaded:",
    len(customers_df)
)


print(
    "Products loaded:",
    len(products_df)
)


print(
    "Calendar rows loaded:",
    len(calendar_df)
)


# ============================================================
# 6. STANDARDIZE DATE TYPES
# ============================================================

print("\n" + "=" * 70)

print("STANDARDIZING DATE FIELDS")

print("=" * 70)


orders_df["Order_Date"] = pd.to_datetime(
    orders_df["Order_Date"]
)


customers_df["Customer_Since"] = pd.to_datetime(
    customers_df["Customer_Since"]
)


# Find the date column in Calendar
calendar_date_column = None

possible_date_columns = [
    "Date",
    "Calendar_Date",
    "CalendarDate"
]


for column in possible_date_columns:

    if column in calendar_df.columns:

        calendar_date_column = column

        break


if calendar_date_column is None:

    raise ValueError(
        "Could not identify the date column in Calendar sheet."
    )


calendar_df[calendar_date_column] = pd.to_datetime(
    calendar_df[calendar_date_column]
)


print(
    "\nCalendar date column:",
    calendar_date_column
)


# ============================================================
# 7. CHECK SOURCE COLUMNS
# ============================================================

print("\n" + "=" * 70)

print("CHECKING REQUIRED COLUMNS")

print("=" * 70)


required_order_columns = [
    "Order_ID",
    "Order_Date",
    "Customer_ID",
    "Product_ID",
    "Region",
    "Sales_Channel",
    "Quantity",
    "Unit_Price",
    "Discount",
    "Unit_Cost",
    "Gross_Sales",
    "Discount_Amount",
    "Revenue",
    "COGS",
    "Gross_Profit",
    "Gross_Margin"
]


required_customer_columns = [
    "Customer_ID",
    "Customer_Name",
    "Customer_Segment",
    "City",
    "State",
    "Customer_Since"
]


required_product_columns = [
    "Product_ID",
    "Product_Name",
    "Category",
    "Subcategory",
    "Brand"
]


for column in required_order_columns:

    if column not in orders_df.columns:

        raise ValueError(
            f"Missing Orders column: {column}"
        )


for column in required_customer_columns:

    if column not in customers_df.columns:

        raise ValueError(
            f"Missing Customers column: {column}"
        )


for column in required_product_columns:

    if column not in products_df.columns:

        raise ValueError(
            f"Missing Products column: {column}"
        )


print(
    "\nAll required columns found."
)


# ============================================================
# 8. PREPARE CUSTOMER DIMENSION
# ============================================================

print("\n" + "=" * 70)

print("PREPARING CUSTOMER DATA")

print("=" * 70)


customer_columns = [
    "Customer_ID",
    "Customer_Name",
    "Customer_Segment",
    "City",
    "State",
    "Customer_Since"
]


customer_dim = customers_df[
    customer_columns
].copy()


print(
    "\nCustomer dimension rows:",
    len(customer_dim)
)


# ============================================================
# 9. PREPARE PRODUCT DIMENSION
# ============================================================

print("\n" + "=" * 70)

print("PREPARING PRODUCT DATA")

print("=" * 70)


product_columns = [
    "Product_ID",
    "Product_Name",
    "Category",
    "Subcategory",
    "Brand"
]


product_dim = products_df[
    product_columns
].copy()


print(
    "\nProduct dimension rows:",
    len(product_dim)
)


# ============================================================
# 10. PREPARE CALENDAR DIMENSION
# ============================================================

print("\n" + "=" * 70)

print("PREPARING CALENDAR DATA")

print("=" * 70)


calendar_columns = [
    calendar_date_column
]


# Add only columns that actually exist
calendar_attributes = [
    "Year",
    "Quarter",
    "Month",
    "Month_Name",
    "Year_Month",
    "Week",
    "Day",
    "Day_Name"
]


for column in calendar_attributes:

    if column in calendar_df.columns:

        calendar_columns.append(column)


calendar_dim = calendar_df[
    calendar_columns
].copy()


calendar_dim = calendar_dim.rename(
    columns={
        calendar_date_column: "Calendar_Date"
    }
)


print(
    "\nCalendar dimension rows:",
    len(calendar_dim)
)


print(
    "Calendar columns:"
)


for column in calendar_dim.columns:

    print(
        " -",
        column
    )


# ============================================================
# 11. MERGE ORDERS WITH CUSTOMERS
# ============================================================

print("\n" + "=" * 70)

print("MERGING ORDERS WITH CUSTOMERS")

print("=" * 70)


analytical_df = orders_df.merge(
    customer_dim,
    on="Customer_ID",
    how="left",
    validate="many_to_one"
)


print(
    "\nRows after customer merge:",
    len(analytical_df)
)


# ============================================================
# 12. VALIDATE CUSTOMER MERGE
# ============================================================

customer_merge_columns = [
    "Customer_Name",
    "Customer_Segment",
    "City",
    "State",
    "Customer_Since"
]


customer_merge_missing = (

    analytical_df[
        customer_merge_columns
    ]

    .isna()

    .any(axis=1)

    .sum()
)


print(
    "Rows with missing customer information:",
    customer_merge_missing
)


if customer_merge_missing != 0:

    raise ValueError(
        "Customer merge failed — missing customer attributes found."
    )


print(
    "Customer merge successful."
)


# ============================================================
# 13. MERGE WITH PRODUCTS
# ============================================================

print("\n" + "=" * 70)

print("MERGING ORDERS WITH PRODUCTS")

print("=" * 70)


analytical_df = analytical_df.merge(
    product_dim,
    on="Product_ID",
    how="left",
    validate="many_to_one"
)


print(
    "\nRows after product merge:",
    len(analytical_df)
)


# ============================================================
# 14. VALIDATE PRODUCT MERGE
# ============================================================

product_merge_columns = [
    "Product_Name",
    "Category",
    "Subcategory",
    "Brand"
]


product_merge_missing = (

    analytical_df[
        product_merge_columns
    ]

    .isna()

    .any(axis=1)

    .sum()
)


print(
    "Rows with missing product information:",
    product_merge_missing
)


if product_merge_missing != 0:

    raise ValueError(
        "Product merge failed — missing product attributes found."
    )


print(
    "Product merge successful."
)


# ============================================================
# 15. MERGE WITH CALENDAR
# ============================================================

print("\n" + "=" * 70)

print("MERGING ORDERS WITH CALENDAR")

print("=" * 70)


analytical_df = analytical_df.merge(
    calendar_dim,
    left_on="Order_Date",
    right_on="Calendar_Date",
    how="left",
    validate="many_to_one"
)


# Remove duplicate calendar date field
if "Calendar_Date" in analytical_df.columns:

    analytical_df = analytical_df.drop(
        columns=["Calendar_Date"]
    )


print(
    "\nRows after calendar merge:",
    len(analytical_df)
)


# ============================================================
# 16. VALIDATE CALENDAR MERGE
# ============================================================

calendar_check_columns = [
    column

    for column in calendar_attributes

    if column in analytical_df.columns
]


if calendar_check_columns:

    calendar_merge_missing = (

        analytical_df[
            calendar_check_columns
        ]

        .isna()

        .any(axis=1)

        .sum()
    )

else:

    calendar_merge_missing = 0


print(
    "Rows with missing calendar information:",
    calendar_merge_missing
)


if calendar_merge_missing != 0:

    raise ValueError(
        "Calendar merge failed — missing calendar attributes found."
    )


print(
    "Calendar merge successful."
)


# ============================================================
# 17. RECALCULATE FINANCIAL METRICS
# ============================================================

print("\n" + "=" * 70)

print("RECALCULATING FINANCIAL METRICS")

print("=" * 70)


analytical_df["Gross_Sales_Calc"] = (

    analytical_df["Quantity"]

    *

    analytical_df["Unit_Price"]
)


analytical_df["Discount_Amount_Calc"] = (

    analytical_df["Gross_Sales_Calc"]

    *

    analytical_df["Discount"]
)


analytical_df["Revenue_Calc"] = (

    analytical_df["Gross_Sales_Calc"]

    -

    analytical_df["Discount_Amount_Calc"]
)


analytical_df["COGS_Calc"] = (

    analytical_df["Quantity"]

    *

    analytical_df["Unit_Cost"]
)


analytical_df["Gross_Profit_Calc"] = (

    analytical_df["Revenue_Calc"]

    -

    analytical_df["COGS_Calc"]
)


analytical_df["Gross_Margin_Calc"] = (

    analytical_df["Gross_Profit_Calc"]

    /

    analytical_df["Revenue_Calc"]
)


print(
    "Financial metrics recalculated."
)


# ============================================================
# 18. VALIDATE FINANCIAL METRICS
# ============================================================

print("\n" + "=" * 70)

print("VALIDATING FINANCIAL METRICS")

print("=" * 70)


revenue_difference = (

    analytical_df["Revenue"]

    -

    analytical_df["Revenue_Calc"]
)


cogs_difference = (

    analytical_df["COGS"]

    -

    analytical_df["COGS_Calc"]
)


profit_difference = (

    analytical_df["Gross_Profit"]

    -

    analytical_df["Gross_Profit_Calc"]
)


margin_difference = (

    analytical_df["Gross_Margin"]

    -

    analytical_df["Gross_Margin_Calc"]
)


max_revenue_difference = (

    revenue_difference

    .abs()

    .max()
)


max_cogs_difference = (

    cogs_difference

    .abs()

    .max()
)


max_profit_difference = (

    profit_difference

    .abs()

    .max()
)


max_margin_difference = (

    margin_difference

    .abs()

    .max()
)


print(
    "\nMaximum Revenue difference:",
    max_revenue_difference
)


print(
    "Maximum COGS difference:",
    max_cogs_difference
)


print(
    "Maximum Gross Profit difference:",
    max_profit_difference
)


print(
    "Maximum Gross Margin difference:",
    max_margin_difference
)


if max_revenue_difference > 0.01:

    raise ValueError(
        "Revenue validation failed."
    )


if max_cogs_difference > 0.01:

    raise ValueError(
        "COGS validation failed."
    )


if max_profit_difference > 0.01:

    raise ValueError(
        "Gross Profit validation failed."
    )


if max_margin_difference > 0.0001:

    raise ValueError(
        "Gross Margin validation failed."
    )


print(
    "\nFinancial validation passed."
)


# ============================================================
# 19. CREATE ANALYTICAL FIELDS
# ============================================================

print("\n" + "=" * 70)

print("CREATING ANALYTICAL FIELDS")

print("=" * 70)


# Customer tenure at order date

analytical_df["Customer_Tenure_Days"] = (

    analytical_df["Order_Date"]

    -

    analytical_df["Customer_Since"]
).dt.days


analytical_df["Customer_Tenure_Years"] = (

    analytical_df["Customer_Tenure_Days"]

    /

    365.25
)


# Discount percentage

analytical_df["Discount_Percent"] = (

    analytical_df["Discount"]

    *

    100
)


# Profit per unit

analytical_df["Profit_Per_Unit"] = (

    analytical_df["Gross_Profit"]

    /

    analytical_df["Quantity"]
)


# Revenue per unit

analytical_df["Revenue_Per_Unit"] = (

    analytical_df["Revenue"]

    /

    analytical_df["Quantity"]
)


# Discount amount per unit

analytical_df["Discount_Per_Unit"] = (

    analytical_df["Discount_Amount"]

    /

    analytical_df["Quantity"]
)


# ============================================================
# 20. REMOVE CALCULATION-ONLY COLUMNS
# ============================================================

calculation_columns = [
    "Gross_Sales_Calc",
    "Discount_Amount_Calc",
    "Revenue_Calc",
    "COGS_Calc",
    "Gross_Profit_Calc",
    "Gross_Margin_Calc"
]


analytical_df = analytical_df.drop(
    columns=calculation_columns
)


# ============================================================
# 21. REORDER COLUMNS
# ============================================================

preferred_column_order = [
    "Order_ID",
    "Order_Date",
    "Year",
    "Quarter",
    "Month",
    "Month_Name",
    "Year_Month",
    "Customer_ID",
    "Customer_Name",
    "Customer_Segment",
    "Customer_Since",
    "Customer_Tenure_Days",
    "Customer_Tenure_Years",
    "City",
    "State",
    "Region",
    "Product_ID",
    "Product_Name",
    "Category",
    "Subcategory",
    "Brand",
    "Sales_Channel",
    "Quantity",
    "Unit_Price",
    "Discount",
    "Discount_Percent",
    "Discount_Amount",
    "Discount_Per_Unit",
    "Unit_Cost",
    "Gross_Sales",
    "Revenue",
    "Revenue_Per_Unit",
    "COGS",
    "Gross_Profit",
    "Profit_Per_Unit",
    "Gross_Margin"
]


available_columns = [

    column

    for column in preferred_column_order

    if column in analytical_df.columns
]


remaining_columns = [

    column

    for column in analytical_df.columns

    if column not in available_columns
]


analytical_df = analytical_df[
    available_columns + remaining_columns
]


# ============================================================
# 22. FINAL DATASET VALIDATION
# ============================================================

print("\n" + "=" * 70)

print("FINAL DATASET VALIDATION")

print("=" * 70)


print(
    "\nFinal rows:",
    len(analytical_df)
)


print(
    "Final columns:",
    len(analytical_df.columns)
)


print(
    "Duplicate Order IDs:",
    analytical_df["Order_ID"].duplicated().sum()
)


print(
    "Total missing values:",
    analytical_df.isna().sum().sum()
)


if len(analytical_df) != len(orders_df):

    raise ValueError(
        "Row count changed during transformation."
    )


if analytical_df["Order_ID"].duplicated().sum() != 0:

    raise ValueError(
        "Duplicate Order IDs found."
    )


if analytical_df.isna().sum().sum() != 0:

    raise ValueError(
        "Missing values found in final analytical dataset."
    )


# ============================================================
# 23. DISPLAY SAMPLE
# ============================================================

print("\n" + "=" * 70)

print("FIRST 5 ANALYTICAL RECORDS")

print("=" * 70)


print(
    analytical_df.head(5).to_string(
        index=False
    )
)


# ============================================================
# 24. BASIC BUSINESS SUMMARY
# ============================================================

print("\n" + "=" * 70)

print("BASIC BUSINESS SUMMARY")

print("=" * 70)


total_revenue = analytical_df[
    "Revenue"
].sum()


total_cogs = analytical_df[
    "COGS"
].sum()


total_profit = analytical_df[
    "Gross_Profit"
].sum()


overall_margin = (

    total_profit

    /

    total_revenue
)


print(
    f"\nRevenue: ₹{total_revenue:,.2f}"
)


print(
    f"COGS: ₹{total_cogs:,.2f}"
)


print(
    f"Gross Profit: ₹{total_profit:,.2f}"
)


print(
    f"Gross Margin: {overall_margin:.2%}"
)


# ============================================================
# 25. SAVE ANALYTICAL DATASET
# ============================================================

print("\n" + "=" * 70)

print("SAVING ANALYTICAL DATASET")

print("=" * 70)


with pd.ExcelWriter(
    OUTPUT_FILE,
    engine="openpyxl"
) as writer:

    analytical_df.to_excel(
        writer,
        sheet_name="Analytical_Data",
        index=False
    )


print(
    "\nAnalytical dataset successfully written to:"
)


print(
    OUTPUT_FILE
)


# ============================================================
# 26. FINAL MESSAGE
# ============================================================

print("\n" + "=" * 70)

print("TRANSFORMATION COMPLETE")

print("=" * 70)


print(
    "\nRaw data was NOT modified."
)


print(
    "Analytical dataset created successfully."
)


print(
    "\nNext step: inspect the analytical workbook."
)