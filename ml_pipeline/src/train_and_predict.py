from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline
from sklearn.metrics import classification_report, roc_auc_score
import joblib
import os
import pandas as pd

def train_and_predict(X_train, X_test, y_train, y_test, customer_ids, preprocessor):
    model = LogisticRegression(
        max_iter=1000,
        class_weight="balanced"
    )

    pipeline = Pipeline(
        [
            ("preprocessor", preprocessor),
            ("model", model)
        ]
    )

    pipeline.fit(X_train, y_train)

    y_pred = pipeline.predict(X_test)
    y_prob = pipeline.predict_proba(X_test)[:, 1]

    print("\n📊 Classification Report\n")
    print(classification_report(y_test, y_pred))
    print(f"ROC-AUC: {roc_auc_score(y_test, y_prob):.4f}")

    os.makedirs("models", exist_ok=True)
    joblib.dump(pipeline, "models/churn_model.pkl")

    results = pd.DataFrame({
        "customer_id": customer_ids.values,
        "churn_probability": y_prob,
        "churn_prediction": y_pred
    })

    return results
