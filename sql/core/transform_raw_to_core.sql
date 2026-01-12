-- Transform raw customers
insert into core.customers_clean(
	customer_id,
	signup_date,
	plan_type,
	monthly_fee,
	acquisition_cost,
	churn_date,
	is_churned
)
select 
	customer_id,
	signup_date,
	plan_type,
	monthly_fee,
	acquisition_cost,
	churn_date,
	CASE
		WHEN churn_date IS NULL THEN FALSE
		ELSE TRUE
	END AS is_churned
FROM raw.customers;

select * from core.customers_clean limit 10;


-- Transform raw subscriptions
INSERT INTO core.subscriptions_clean(
	subscription_id,
	customer_id,
	month,
	monthly_fee
)
SELECT
	subscription_id,
	customer_id,
	month,
	monthly_fee
FROM raw.subscriptions;


-- Transform raw revenue
INSERT INTO core.revenue_agg(
	customer_id,
	total_revenue,
	avg_revenue,
	revenue_txn_count
)
SELECT
	customer_id,
	SUM(amount) AS total_revenue,
	AVG(amount) AS avg_revenue,
	COUNT(*) AS revenue_txn_count
FROM raw.revenue
GROUP BY customer_id;