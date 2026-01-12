CREATE OR REPLACE VIEW analytics.v_customer_overview AS
SELECT
    customer_id,
    plan_type,
    is_churned,
    tenure_months,
    total_revenue,
    avg_revenue,
    revenue_txn_count
FROM analytics.customer_churn_base;
