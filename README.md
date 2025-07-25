# Take Home Task for SellerX Application

## Data Model Design



### Base Models

Base models are created to clean and process the data from the raw data stored in the database.
Each model corresponds to a table of raw data:

- `base__devices` for the `device` table
- `base__stores` for the `store` table
- `base__transactions` for the `transaction` table

### Staging

Data from the different tables are combined at the staging level to create a master table.
Since we are only operating on a small sample of data that can be all linked together, only one staging table was created: `stg__store_transactions`

### Marts

Each view corresponds to one of the questions to be answered in the document:

#### `top_ten_stores_transaction_amount`

- Answers the question "Top 10 stores per transacted amount"
- Assumption: This is calculated based on all available transaction data, for all time

#### `top_ten_products_sold`

- Answers the question "Top 10 products sold"
- Assumption: Since Product SKUs and names do not correspond 1:1 (see screenshot below), I decided to use SKUs instead of product names. 
- This is especially since there are two product name columns available on the base table and there are different values per product SKU.
- Assumption: The `v3770009015028` SKU is to be used as-is; while most SKUs do not have any letters added, it is also possible that the `v` can still mean something

#### `avg_transaction_amount_store_type_country`

- Answers the question "Average transacted amount per store typology and country"
- Assumption: This is calculated based on all available transaction data, for all time

#### `percentage_transactions_device_type`

- Answers the question "Top 10 stores per transacted amount"
- Assumption: This is calculated based on all available transaction data, for all time

#### `avg_time_first_five_transactions_per_store`

- Answers the question "Top 10 stores per transacted amount"
- Assumption: Since there is no available data for store operating hours, this metric is calculated by counting the days from the first transaction of the store to the fifth transaction of the store
- Assumption: This is calculated based on all available transaction data, for all time
- Assumption: All timestamps are assumed to be in the same timezone; it does not always follow that 

### Additional Improvements for Scaling Up

- Change the materialization of `base__transactions` from table to incremental, to minimize the need for full refreshes
- Add a custom `safe_cast` macro on base model columns to ensure that all incoming data is in the right data type. The current dbt macro for `safe_cast` on Snowflake can only used for strings.
- Utilize sensitive data classification feature of Snowflake (available only in Enterprise Edition) to better manage PII in the system
- Activate multi-cluster warehouse feature if scaling is needed
