CREATE OR REPLACE VIEW analytics.v_high_value_active_customers AS
SELECT
    customer_id,
    plan_type,
    total_revenue,
    tenure_months
FROM analytics.customer_churn_base
WHERE is_churned = FALSE
ORDER BY total_revenue DESC;
