CREATE OR REPLACE VIEW analytics.v_revenue_at_risk AS
SELECT
    plan_type,
    SUM(total_revenue) AS revenue_lost
FROM analytics.customer_churn_base
WHERE is_churned = TRUE
GROUP BY plan_type;
