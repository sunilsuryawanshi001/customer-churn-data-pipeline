CREATE TABLE IF NOT EXISTS ml.customer_churn_features(
	customer_id VARCHAR PRIMARY KEY,
	--target
	churn_label INT,
	--tenure features
	tenure_months INT,
	is_new_customer INT,
	--revenue features
	monthly_charges NUMERIC(10,2),
	total_charges NUMERIC(12,2),
	avg_monthly_spend NUMERIC(10,2),
	--contract and payment
	contract_type VARCHAR,
	payment_method VARCHAR,
	paperless_billing INT,
	--services binary flags
	has_internet_service INT,
	has_online_security INT,
	has_streaming INT,
	--aggregated behavior
	service_count INT,
	--metadata
	feature_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);