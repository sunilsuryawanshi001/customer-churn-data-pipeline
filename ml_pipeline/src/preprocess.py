from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer

def preprocess(df):
    customer_ids = df["customer_id"]

    x = df.drop(columns=["customer_id", "churn_label"])
    y = df["churn_label"]

    numeric = [
        "tenure_days",
        "tenure_months",
        "monthly_fee",
        "acquisition_cost",
        "lifetime_value"
    ]

    categorical = ["plan_type"]
    binary = ["is_new_customer", "churned_quickly"]

    preprocessor = ColumnTransformer(
        [
            ("num", StandardScaler(), numeric),
            ("cat", OneHotEncoder(handle_unknown="ignore"), categorical),
            ("bin", "passthrough", binary)
        ]
    )

    X_train, X_test, y_train, y_test, id_train, id_test = train_test_split(
        x, y, customer_ids,
        test_size=0.2,
        random_state=42,
        stratify=y
    )

    return X_train, X_test, y_train, y_test, id_test, preprocessor