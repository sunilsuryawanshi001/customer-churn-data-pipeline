INSERT INTO ml.customer_churn_features
SELECT
    customer_id,
    CASE
        WHEN is_churned = TRUE THEN 1
        ELSE 0
    END AS churn_label,
    CASE
        WHEN is_churned = TRUE AND churn_date IS NOT NULL
            THEN (churn_date - signup_date)
        ELSE (CURRENT_DATE - signup_date)
    END AS tenure_days,
    CASE
        WHEN is_churned = TRUE AND churn_date IS NOT NULL
            THEN FLOOR((churn_date - signup_date) / 30.0)
        ELSE FLOOR((CURRENT_DATE - signup_date) / 30.0)
    END AS tenure_months,
    CASE
        WHEN
            (
              CASE
                  WHEN is_churned = TRUE AND churn_date IS NOT NULL
                      THEN (churn_date - signup_date)
                  ELSE (CURRENT_DATE - signup_date)
              END
            ) <= 90
        THEN 1
        ELSE 0
    END AS is_new_customer,
    monthly_fee::NUMERIC(10,2) AS monthly_fee,
    acquisition_cost::NUMERIC(10,2) AS acquisition_cost,
    (
        monthly_fee *
        CASE
            WHEN is_churned = TRUE AND churn_date IS NOT NULL
                THEN GREATEST(FLOOR((churn_date - signup_date) / 30.0), 1)
            ELSE GREATEST(FLOOR((CURRENT_DATE - signup_date) / 30.0), 1)
        END
    )::NUMERIC(12,2) AS lifetime_value,
    plan_type,
    CASE
        WHEN is_churned = TRUE
         AND churn_date IS NOT NULL
         AND (churn_date - signup_date) <= 90
        THEN 1
        ELSE 0
    END AS churned_quickly
FROM core.customers_clean;
