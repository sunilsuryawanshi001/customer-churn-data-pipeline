CREATE OR REPLACE VIEW analytics.v_churn_summary AS
SELECT
    is_churned,
    COUNT(*) AS customer_count,
    AVG(tenure_months) AS avg_tenure_months,
    SUM(total_revenue) AS total_revenue
FROM analytics.customer_churn_base
GROUP BY is_churned;
