import pandas as pd
import psycopg2
from dotenv import load_dotenv
import os

load_dotenv()

def load_ml_features():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )

    query = """
    SELECT
        customer_id,
        churn_label,
        tenure_days,
        tenure_months,
        is_new_customer,
        monthly_fee,
        acquisition_cost,
        lifetime_value,
        plan_type,
        churned_quickly
    FROM ml.customer_churn_features
    """

    df = pd.read_sql(query, conn)
    conn.close()
    return df
