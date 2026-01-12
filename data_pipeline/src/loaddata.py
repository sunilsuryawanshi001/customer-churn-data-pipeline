import os
import pandas as pd
import psycopg2
from dotenv import load_dotenv

# ----------------------------------
# LOAD ENV VARIABLES
# ----------------------------------
load_dotenv()

DB_CONFIG = {
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT"),
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD")
}

DATA_ROOT = os.getenv("DATA_ROOT_PATH")

# ----------------------------------
# CONNECT TO DATABASE
# ----------------------------------
conn = psycopg2.connect(**DB_CONFIG)
cursor = conn.cursor()

# ----------------------------------
# LOAD CSV INTO RAW SCHEMA (ONE TIME)
# ----------------------------------
def load_csv_to_raw(table_name, file_name):
    file_path = os.path.join(DATA_ROOT, file_name)

    df = pd.read_csv(file_path)

    # Convert NaN → None (PostgreSQL NULL)
    df = df.where(pd.notnull(df), None)

    # Normalize YYYY-MM → YYYY-MM-01
    if table_name in ["subscriptions", "revenue"]:
        df["month"] = df["month"].apply(
            lambda x: f"{x}-01" if x is not None else None
        )

    print(f"Loading {file_name} → raw.{table_name}")

    for _, row in df.iterrows():
        columns = ",".join(df.columns)
        placeholders = ",".join(["%s"] * len(row))

        query = f"""
            INSERT INTO raw.{table_name} ({columns})
            VALUES ({placeholders})
        """
        cursor.execute(query, tuple(row))

    conn.commit()
    print(f"Inserted {len(df)} rows into raw.{table_name}\n")

# ----------------------------------
# LOAD DATA (CUSTOMERS ALREADY LOADED)
# ----------------------------------

# DO NOT reload customers
# load_csv_to_raw("customers", "customers.csv")

cursor.execute("TRUNCATE TABLE raw.subscriptions;")
load_csv_to_raw("subscriptions", "subscriptions.csv")

cursor.execute("TRUNCATE TABLE raw.revenue;")
load_csv_to_raw("revenue", "revenue.csv")

# ----------------------------------
# CLOSE CONNECTION
# ----------------------------------
cursor.close()
conn.close()

print("✅ Raw data loading completed successfully.")
