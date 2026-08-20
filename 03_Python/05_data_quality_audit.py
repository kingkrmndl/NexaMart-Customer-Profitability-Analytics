from pathlib import Path

import pandas as pd


# ============================================================
# 1. PROJECT PATHS
# ============================================================

PROJECT_DIR = Path(__file__).resolve().parent.parent

RAW_DATA_DIR = PROJECT_DIR / "01_Raw_Data"

EXCEL_FILE = RAW_DATA_DIR / "NexaMart_Raw_Data.xlsx"


# ============================================================
# 2. START
# ============================================================

print("=" * 70)

print("NexaMart — Data Quality Audit")

print("=" * 70)


print("\nExcel file:")

print(EXCEL_FILE)


if not EXCEL_FILE.exists():

    raise FileNotFoundError(
        f"Excel file not found: {EXCEL_FILE}"
    )


# ============================================================
# 3. LOAD DATA
# ============================================================

print("\nLoading data...")


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


print(
    "Orders loaded:",
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


# ============================================================
# 4. BASIC STRUCTURE
# ============================================================

print("\n" + "=" * 70)

print("1. BASIC STRUCTURE")

print("=" * 70)


print(
    "\nOrders shape:",
    orders_df.shape
)


print(
    "Customers shape:",
    customers_df.shape
)


print(
    "Products shape:",
    products_df.shape
)


print(
    "\nOrders columns:"
)


for column in orders_df.columns:

    print(
        " -",
        column
    )


# ============================================================
# 5. DUPLICATE ORDER IDS
# ============================================================

print("\n" + "=" * 70)

print("2. DUPLICATE ORDER ID CHECK")

print("=" * 70)


duplicate_order_ids = (

    orders_df[
        "Order_ID"
    ]

    .duplicated()

    .sum()
)


print(
    "\nDuplicate Order IDs:",
    duplicate_order_ids
)


if duplicate_order_ids == 0:

    print(
        "PASS — All Order IDs are unique."
    )

else:

    print(
        "FAIL — Duplicate Order IDs found."
    )


# ============================================================
# 6. MISSING VALUES
# ============================================================

print("\n" + "=" * 70)

print("3. MISSING VALUE CHECK")

print("=" * 70)


missing_by_column = (

    orders_df

    .isna()

    .sum()
)


print(
    "\nMissing values by column:"
)


print(
    missing_by_column
)


total_missing = (

    missing_by_column

    .sum()
)


print(
    "\nTotal missing values:",
    total_missing
)


if total_missing == 0:

    print(
        "PASS — No missing values."
    )

else:

    print(
        "FAIL — Missing values detected."
    )


# ============================================================
# 7. CUSTOMER ID REFERENTIAL INTEGRITY
# ============================================================

print("\n" + "=" * 70)

print("4. CUSTOMER ID VALIDATION")

print("=" * 70)


invalid_customer_ids = (

    set(
        orders_df[
            "Customer_ID"
        ]
    )

    -

    set(
        customers_df[
            "Customer_ID"
        ]
    )
)


print(
    "\nInvalid Customer IDs:",
    len(invalid_customer_ids)
)


if len(invalid_customer_ids) == 0:

    print(
        "PASS — Every order has a valid customer."
    )

else:

    print(
        "FAIL — Invalid Customer IDs found."
    )


# ============================================================
# 8. PRODUCT ID REFERENTIAL INTEGRITY
# ============================================================

print("\n" + "=" * 70)

print("5. PRODUCT ID VALIDATION")

print("=" * 70)


invalid_product_ids = (

    set(
        orders_df[
            "Product_ID"
        ]
    )

    -

    set(
        products_df[
            "Product_ID"
        ]
    )
)


print(
    "\nInvalid Product IDs:",
    len(invalid_product_ids)
)


if len(invalid_product_ids) == 0:

    print(
        "PASS — Every order has a valid product."
    )

else:

    print(
        "FAIL — Invalid Product IDs found."
    )


# ============================================================
# 9. QUANTITY CHECK
# ============================================================

print("\n" + "=" * 70)

print("6. QUANTITY VALIDATION")

print("=" * 70)


invalid_quantity = (

    orders_df[
        "Quantity"
    ]

    <=

    0
)


invalid_quantity_count = (

    invalid_quantity

    .sum()
)


print(
    "\nOrders with invalid quantity:",
    invalid_quantity_count
)


print(
    "Minimum quantity:",
    orders_df[
        "Quantity"
    ].min()
)


print(
    "Maximum quantity:",
    orders_df[
        "Quantity"
    ].max()
)


if invalid_quantity_count == 0:

    print(
        "PASS — All quantities are positive."
    )

else:

    print(
        "FAIL — Invalid quantities found."
    )


# ============================================================
# 10. UNIT PRICE CHECK
# ============================================================

print("\n" + "=" * 70)

print("7. UNIT PRICE VALIDATION")

print("=" * 70)


invalid_price = (

    orders_df[
        "Unit_Price"
    ]

    <=

    0
)


invalid_price_count = (

    invalid_price

    .sum()
)


print(
    "\nOrders with invalid unit price:",
    invalid_price_count
)


print(
    "Minimum unit price:",
    orders_df[
        "Unit_Price"
    ].min()
)


print(
    "Maximum unit price:",
    orders_df[
        "Unit_Price"
    ].max()
)


if invalid_price_count == 0:

    print(
        "PASS — All unit prices are positive."
    )

else:

    print(
        "FAIL — Invalid unit prices found."
    )


# ============================================================
# 11. UNIT COST CHECK
# ============================================================

print("\n" + "=" * 70)

print("8. UNIT COST VALIDATION")

print("=" * 70)


invalid_cost = (

    orders_df[
        "Unit_Cost"
    ]

    <=

    0
)


invalid_cost_count = (

    invalid_cost

    .sum()
)


print(
    "\nOrders with invalid unit cost:",
    invalid_cost_count
)


if invalid_cost_count == 0:

    print(
        "PASS — All unit costs are positive."
    )

else:

    print(
        "FAIL — Invalid unit costs found."
    )


# ============================================================
# 12. DISCOUNT CHECK
# ============================================================

print("\n" + "=" * 70)

print("9. DISCOUNT VALIDATION")

print("=" * 70)


invalid_discount = (

    (

        orders_df[
            "Discount"
        ]

        <

        0
    )

    |

    (

        orders_df[
            "Discount"
        ]

        >

        1
    )
)


invalid_discount_count = (

    invalid_discount

    .sum()
)


print(
    "\nInvalid discounts:",
    invalid_discount_count
)


print(
    "Discount values:"
)


print(

    sorted(

        orders_df[
            "Discount"
        ]

        .unique()
    )
)


if invalid_discount_count == 0:

    print(
        "PASS — All discounts are valid."
    )

else:

    print(
        "FAIL — Invalid discounts found."
    )


# ============================================================
# 13. REVENUE VALIDATION
# ============================================================

print("\n" + "=" * 70)

print("10. REVENUE CALCULATION CHECK")

print("=" * 70)


expected_revenue = (

    orders_df[
        "Gross_Sales"
    ]

    -

    orders_df[
        "Discount_Amount"
    ]
)


revenue_difference = (

    orders_df[
        "Revenue"
    ]

    -

    expected_revenue
)


max_revenue_difference = (

    revenue_difference

    .abs()

    .max()
)


print(
    "\nMaximum revenue difference:",
    max_revenue_difference
)


if max_revenue_difference <= 0.01:

    print(
        "PASS — Revenue calculations are correct."
    )

else:

    print(
        "FAIL — Revenue calculation mismatch."
    )


# ============================================================
# 14. COGS VALIDATION
# ============================================================

print("\n" + "=" * 70)

print("11. COGS CALCULATION CHECK")

print("=" * 70)


expected_cogs = (

    orders_df[
        "Quantity"
    ]

    *

    orders_df[
        "Unit_Cost"
    ]
)


cogs_difference = (

    orders_df[
        "COGS"
    ]

    -

    expected_cogs
)


max_cogs_difference = (

    cogs_difference

    .abs()

    .max()
)


print(
    "\nMaximum COGS difference:",
    max_cogs_difference
)


if max_cogs_difference <= 0.01:

    print(
        "PASS — COGS calculations are correct."
    )

else:

    print(
        "FAIL — COGS calculation mismatch."
    )


# ============================================================
# 15. GROSS PROFIT VALIDATION
# ============================================================

print("\n" + "=" * 70)

print("12. GROSS PROFIT CALCULATION CHECK")

print("=" * 70)


expected_profit = (

    orders_df[
        "Revenue"
    ]

    -

    orders_df[
        "COGS"
    ]
)


profit_difference = (

    orders_df[
        "Gross_Profit"
    ]

    -

    expected_profit
)


max_profit_difference = (

    profit_difference

    .abs()

    .max()
)


print(
    "\nMaximum gross profit difference:",
    max_profit_difference
)


if max_profit_difference <= 0.01:

    print(
        "PASS — Gross profit calculations are correct."
    )

else:

    print(
        "FAIL — Gross profit calculation mismatch."
    )


# ============================================================
# 16. GROSS MARGIN VALIDATION
# ============================================================

print("\n" + "=" * 70)

print("13. GROSS MARGIN CALCULATION CHECK")

print("=" * 70)


expected_margin = (

    orders_df[
        "Gross_Profit"
    ]

    /

    orders_df[
        "Revenue"
    ]
)


margin_difference = (

    orders_df[
        "Gross_Margin"
    ]

    -

    expected_margin
)


max_margin_difference = (

    margin_difference

    .abs()

    .max()
)


print(
    "\nMaximum gross margin difference:",
    max_margin_difference
)


if max_margin_difference <= 0.0001:

    print(
        "PASS — Gross margin calculations are correct."
    )

else:

    print(
        "FAIL — Gross margin calculation mismatch."
    )


# ============================================================
# 17. DATE VALIDATION
# ============================================================

print("\n" + "=" * 70)

print("14. ORDER DATE VALIDATION")

print("=" * 70)


orders_df[
    "Order_Date"
] = pd.to_datetime(

    orders_df[
        "Order_Date"
    ]
)


minimum_date = (

    orders_df[
        "Order_Date"
    ]

    .min()
)


maximum_date = (

    orders_df[
        "Order_Date"
    ]

    .max()
)


print(
    "\nMinimum Order Date:",
    minimum_date
)


print(
    "Maximum Order Date:",
    maximum_date
)


if minimum_date < pd.Timestamp(
    "2023-01-01"
):

    print(
        "FAIL — Order date before 2023."
    )

else:

    print(
        "PASS — Order dates are within expected range."
    )


# ============================================================
# 18. CUSTOMER COVERAGE
# ============================================================

print("\n" + "=" * 70)

print("15. CUSTOMER COVERAGE")

print("=" * 70)


customers_with_orders = (

    orders_df[
        "Customer_ID"
    ]

    .nunique()
)


total_customers = (

    customers_df[
        "Customer_ID"
    ]

    .nunique()
)


customer_coverage = (

    customers_with_orders

    /

    total_customers
)


print(
    "\nCustomers with orders:",
    customers_with_orders
)


print(
    "Total customers:",
    total_customers
)


print(
    f"Customer coverage: {customer_coverage:.2%}"
)


# ============================================================
# 19. PRODUCT COVERAGE
# ============================================================

print("\n" + "=" * 70)

print("16. PRODUCT COVERAGE")

print("=" * 70)


products_with_orders = (

    orders_df[
        "Product_ID"
    ]

    .nunique()
)


total_products = (

    products_df[
        "Product_ID"
    ]

    .nunique()
)


product_coverage = (

    products_with_orders

    /

    total_products
)


print(
    "\nProducts with orders:",
    products_with_orders
)


print(
    "Total products:",
    total_products
)


print(
    f"Product coverage: {product_coverage:.2%}"
)


# ============================================================
# 20. FINAL DATA QUALITY SCORECARD
# ============================================================

print("\n" + "=" * 70)

print("FINAL DATA QUALITY SCORECARD")

print("=" * 70)


checks = {

    "Duplicate Order IDs":
        duplicate_order_ids == 0,

    "Missing Values":
        total_missing == 0,

    "Invalid Customer IDs":
        len(invalid_customer_ids) == 0,

    "Invalid Product IDs":
        len(invalid_product_ids) == 0,

    "Invalid Quantities":
        invalid_quantity_count == 0,

    "Invalid Prices":
        invalid_price_count == 0,

    "Invalid Costs":
        invalid_cost_count == 0,

    "Invalid Discounts":
        invalid_discount_count == 0,

    "Revenue Calculation":
        max_revenue_difference <= 0.01,

    "COGS Calculation":
        max_cogs_difference <= 0.01,

    "Gross Profit Calculation":
        max_profit_difference <= 0.01,

    "Gross Margin Calculation":
        max_margin_difference <= 0.0001
}


print()


for check_name, passed in checks.items():

    status = (
        "PASS"
        if passed
        else
        "FAIL"
    )

    print(
        f"{check_name:<30} {status}"
    )


failed_checks = [

    name

    for name, passed

    in checks.items()

    if not passed
]


# ============================================================
# 21. FINAL RESULT
# ============================================================

print("\n" + "=" * 70)

print("DATA QUALITY AUDIT RESULT")

print("=" * 70)


if not failed_checks:

    print(
        "\nPASS — All data quality checks passed."
    )

    print(
        "\nThe NexaMart dataset is ready for transformation and analysis."
    )

else:

    print(
        "\nFAIL — Some data quality checks failed."
    )

    print(
        "\nFailed checks:"
    )

    for check in failed_checks:

        print(
            " -",
            check
        )

    raise ValueError(
        "Data quality audit failed."
    )


print("\n" + "=" * 70)

print("AUDIT COMPLETE")

print("=" * 70)