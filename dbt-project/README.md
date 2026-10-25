# Orders Analytics with dbt and Databricks

A small dbt project that turns sample order data into clean, analysis-ready models on Databricks. It demonstrates seed loading, SQL transformations, and a simple data-quality test suite.

## Pipeline

```text
seeds/raw_orders.csv
        |
        v
models/stg_orders.sql
        |
        v
models/orders_summary.sql
```

- `raw_orders` loads the CSV seed.
- `stg_orders` standardizes order dates and statuses and converts amounts from cents to currency units.
- `orders_summary` reports order counts and revenue grouped by status.

The CSV contains fictional sample records and is included for local development and demonstration.

## Stack

- dbt Core 1.10
- dbt-databricks 1.10
- Databricks SQL Warehouse
- SQL

## Run locally

1. Install Python 3.9 or later and create an isolated environment:

   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   python -m pip install -r requirements.txt
   ```

2. Create `.env` in this folder with the Databricks SQL warehouse settings:

   ```dotenv
   DATABRICKS_HOST=your-workspace-host
   DATABRICKS_HTTP_PATH=/sql/1.0/warehouses/your-warehouse-id
   DATABRICKS_CATALOG=your-unity-catalog
   DATABRICKS_SCHEMA=default
   DATABRICKS_TOKEN=your-personal-access-token
   ```

   Get the host and HTTP path from the SQL warehouse connection details. Choose a Unity Catalog and schema that exist and that your account can use. Keep the token private; `.env` is excluded from Git.

3. Load the environment and verify the connection:

   ```bash
   set -a
   source .env
   set +a
   dbt debug
   ```

4. Load the seed, build the models, and run the tests:

   ```bash
   dbt seed
   dbt run
   dbt test
   ```

The default profile is in `profiles.yml`. The profile uses environment variables so credentials are not embedded in project configuration.

## Project layout

```text
dbt-project/
├── models/
│   ├── orders_summary.sql
│   ├── schema.yml
│   └── stg_orders.sql
├── seeds/
│   └── raw_orders.csv
├── .env                  # local settings; not committed
├── dbt_project.yml
├── profiles.yml
└── requirements.txt
```

## Data quality

The staging model tests require `order_id` to be unique and non-null, and check that each row has a date and status. The summary model checks that its output fields are populated.

## Notes

- A Databricks workspace, SQL warehouse, Unity Catalog, schema, and appropriate grants are required to run the project.
- The project does not include credentials or provision Databricks resources.
