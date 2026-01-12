CREATE OR REPLACE VIEW analytics.v_churn_by_plan AS
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE is_churned = TRUE) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE is_churned = TRUE) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percent
FROM analytics.customer_churn_base
GROUP BY plan_type;
