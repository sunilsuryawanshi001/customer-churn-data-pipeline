from src.data_loader import load_ml_features
from src.preprocess import preprocess
from src.train_and_predict import train_and_predict
from src.risk_analysis import show_churn_risk

def main():
    print("📥 Loading ML features...")
    df = load_ml_features()

    print("🧹 Preprocessing data...")
    X_train, X_test, y_train, y_test, id_test, preprocessor = preprocess(df)

    print("🤖 Training model & predicting churn...")
    results = train_and_predict(
        X_train, X_test, y_train, y_test, id_test, preprocessor
    )

    print("📌 Identifying churn-risk customers...")
    show_churn_risk(results, threshold=0.7)

    print("\n✅ ML pipeline completed successfully")

if __name__ == "__main__":
    main()
