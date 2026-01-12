def show_churn_risk(results, threshold=0.7, top_n=10):
    results["risk_level"] = results["churn_probability"].apply(
        lambda x: "HIGH" if x >= threshold else "LOW"
    )

    high_risk = (
        results[results["risk_level"] == "HIGH"]
        .sort_values("churn_probability", ascending=False)
        .head(top_n)
    )

    print("\n🚨 HIGH RISK CUSTOMERS 🚨\n")
    print(high_risk)

    return high_risk
