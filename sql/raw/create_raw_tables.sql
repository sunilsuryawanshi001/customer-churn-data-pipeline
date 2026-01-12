CREATE TABLE raw.customers (
    customer_id        VARCHAR PRIMARY KEY,
    signup_date        DATE,
    plan_type          VARCHAR,
    monthly_fee        NUMERIC(10,2),
    acquisition_cost   NUMERIC(10,2),
    churn_date         DATE
);


CREATE TABLE raw.subscriptions (
    subscription_id    VARCHAR PRIMARY KEY,
    customer_id        VARCHAR,
    month              DATE,
    monthly_fee        NUMERIC(10,2)
);


CREATE TABLE raw.revenue (
    subscription_id    VARCHAR,
    customer_id        VARCHAR,
    month              DATE,
    monthly_fee        NUMERIC(10,2),
    revenue_type       VARCHAR,
    amount             NUMERIC(12,2)
);


select * from raw.customers limit 10;
select count(*) from raw.customers;
select count(*) from raw.subscriptions;
select count(*) from raw.revenue;

