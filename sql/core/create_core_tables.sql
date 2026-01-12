CREATE TABLE core.customers_clean (
    customer_id        VARCHAR PRIMARY KEY,
    signup_date        DATE,
    plan_type          VARCHAR,
    monthly_fee        NUMERIC(10,2),
    acquisition_cost   NUMERIC(10,2),
    churn_date         DATE,
    is_churned         BOOLEAN
);


CREATE TABLE core.subscriptions_clean (
    subscription_id    VARCHAR PRIMARY KEY,
    customer_id        VARCHAR,
    month              DATE,
    monthly_fee        NUMERIC(10,2)
);


CREATE TABLE core.revenue_agg (
    customer_id        VARCHAR PRIMARY KEY,
    total_revenue      NUMERIC(12,2),
    avg_revenue        NUMERIC(12,2),
    revenue_txn_count  INTEGER
);
