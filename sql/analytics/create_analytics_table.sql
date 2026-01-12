CREATE TABLE analytics.customer_churn_base(
	customer_id VARCHAR PRIMARY KEY,
	signup_date DATE,
	plan_type VARCHAR,
	monthly_fee NUMERIC(10,2),
	acquisition_cost NUMERIC(10,2),
	is_churned BOOLEAN,
	tenure_months INTEGER,
	total_revenue NUMERIC(12,2),
	avg_revenue NUMERIC(12,2),
	revenue_txn_count INTEGER
);