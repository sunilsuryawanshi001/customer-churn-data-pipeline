# Customer Churn Data Engineering & Analytics Pipeline

## 📌 Overview

This project demonstrates an **end-to-end data engineering pipeline** built using **PostgreSQL, SQL, and Python**.  
The primary goal is to transform raw customer data into **clean, analytics-ready and ML-ready datasets** using layered SQL transformations.

A lightweight machine learning pipeline is included **only as a downstream consumer** to validate how curated data can be used for churn risk analysis.

> **Primary focus:** Data pipelines, SQL transformations, and data modeling  
> **Secondary focus:** Downstream ML consumption (not ML optimization)

---

## 🎯 Problem Statement

Customer churn is a key business challenge where organizations want to identify customers who are likely to stop using a service.

From a **data engineering perspective**, the challenge is to:
- ingest customer data reliably
- clean and standardize it using SQL
- model it into reusable layers
- expose it for analytics and predictive use cases

---

## 🧱 High-Level Architecture

![alt text](customer-churn-data-pipeline.png)


---

## 📁 Project Structure

customer-churn-data-pipeline/
├── data_pipeline/ # Data ingestion logic
├── sql/ # SQL transformations (RAW, CORE, ML)
├── ml_pipeline/ # Downstream ML consumption
├── README.md
├── requirements.txt
└── .env


---

## 🧩 Data Pipeline (Core Focus)

The **data pipeline** is responsible for preparing high-quality data using SQL-first transformations.

### Responsibilities
- Ingest raw customer data into PostgreSQL
- Apply deterministic SQL transformations
- Build analytics- and ML-ready tables
- Enforce data quality checks

### Data Layers

| Layer      | Description                                |
|------------|--------------------------------------------|
| RAW        | Source data stored without modification    |
| CORE       | Cleaned and standardized customer entities |
| ML         | Feature tables designed for predictive use |
| Validation | Data quality and consistency checks        |

---

## 🤖 ML Pipeline (Downstream Consumer)

The ML pipeline **consumes curated feature tables** produced by the data pipeline.

### ML Workflow
1. Load features from `ml.customer_churn_features`
2. Apply preprocessing (scaling, encoding)
3. Split data into training and testing sets
4. Train a baseline churn prediction model
5. Evaluate using ROC-AUC
6. Identify high-risk churn customers

> The ML pipeline does not perform data ingestion or SQL transformations.

---

## 📊 Sample Model Output

- **ROC-AUC:** ~0.87
- High recall for churned customers
- Ranked churn probabilities for risk-based segmentation

Example:

| customer_id | churn_probability | risk_level |
|-------------|-------------------|------------|
| 1137        | 0.99              | HIGH       |
| 1672        | 0.99              | HIGH       |
| 1278        | 0.99              | HIGH       |

---

## ⚙️ Technologies Used

### Core Technologies
- PostgreSQL
- SQL
- Python

### Python Libraries
- pandas
- psycopg2
- SQLAlchemy
- python-dotenv
- scikit-learn

---

## ▶️ How to Run the Project

### 1️⃣ Configure environment variables

Create a `.env` file in the project root:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=your_database
DB_USER=your_user
DB_PASSWORD=your_password


### 2️⃣ Install dependencies

pip install -r requirements.txt


### 3️⃣ Run SQL pipeline

Execute SQL scripts in the following order:

sql/raw

sql/core

sql/ml

sql/validation


### 4️⃣ Run ML pipeline

cd ml_pipeline
python run_pipeline.py


🧠 Key Design Principles

SQL-first data transformations

Layered schema design (RAW → CORE → ML)

Clear separation of data and ML pipelines

Deterministic feature engineering

Environment-based configuration management


🚀 Future Enhancements

Workflow orchestration using Apache Airflow

BI dashboards for churn analytics

Prediction storage and monitoring

Cloud deployment (GCP / AWS)
