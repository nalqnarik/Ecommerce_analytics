# E-Commerce Data Analytics Project

[![SQL](https://img.shields.io/badge/Language-SQL-blue.svg)](https://www.postgresql.org/)
[![Python](https://img.shields.io/badge/Language-Python-yellow.svg)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

## Overview
This project is an end-to-end e-commerce data analytics solution designed to explore, analyze, and visualize customer behavior, sales performance, and product trends. It transforms raw transactional data into meaningful, actionable insights that support data-driven business decisions.

The core goal is to simulate a robust, real-world analytics workflow: 
**Database Setup ➔ Data Cleaning ➔ Advanced Analysis ➔ Interactive Dashboards**

---

## Tech Stack
* **Database:** PostgreSQL
* **Data Generation:** Python (`faker`)
* **Visualization:** Power BI / Tableau / Matplotlib & Seaborn
* **Environment & Tools:** SQL, Jupyter Notebook, Git, VS Code

---

## Features
* **Data Generation:** Real lifelike Data generation using Python.
* **SQL Analytics:** Complex queries for data extraction, cohort analysis, and KPIs calculation.
* **Customer Behavior Analysis:** Insights into purchase frequency, customer retention, and churn.
* **Sales Trend Analysis:** Time-series tracking of revenue, order volume, and seasonality trends.
* **Product Performance:** Identification of top-moving stock, high-margin categories, and slow-moving items.
* **Interactive Dashboards:** Dynamic visualizations capturing key business metrics:
    * Total Revenue & MoM Growth
    * Order Volume & Average Order Value (AOV)
    * Top Performing Products & Categories
    * RFM Customer Segmentation

---

## 🗂️ Project Structure
```text
ecommerce-analytics/
│
├── data/               # Raw and cleaned datasets (CSV/Parquet)
├── sql/                # DDL schemas, views, and analytical queries
├── dashboard/          # Power BI (.pbix) or Tableau (.twbx) files
├── python/             # Python script for data generation
└── README.md           # Project documentation
