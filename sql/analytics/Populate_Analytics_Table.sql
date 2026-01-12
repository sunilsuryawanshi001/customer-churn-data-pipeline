INSERT INTO analytics.customer_churn_base(
	customer_id,
	signup_date,
    plan_type,
    monthly_fee,
    acquisition_cost,
    is_churned,
    tenure_months,
    total_revenue,
    avg_revenue,
    revenue_txn_count
)
SELECT
	c.customer_id,
	c.signup_date,
	c.plan_type,
	c.monthly_fee,
	c.acquisition_cost,
	c.is_churned,
	-- tenure calculation
	(
		DATE_PART('year', AGE(COALESCE(c.churn_date, CURRENT_DATE), c.signup_date)) * 12
		+
		DATE_PART('month', AGE(COALESCE(c.churn_date, CURRENT_DATE), c.signup_date))
	)::INT AS tenure_months,
	-- revenue
	COALESCE(r.total_revenue, 0) AS total_revenue,
	COALESCE(r.avg_revenue, 0) AS avg_revenue,
	COALESCE(r.revenue_txn_count, 0) AS revenue_txn_count
FROM core.customers_clean c
LEFT JOIN core.revenue_agg r
	ON c.customer_id = r.customer_id;