# Nokia-Strategic-Analysis-Medallion-Architecture
End-to-end data engineering &amp; analytics project on Nokia's performance (1994-2026). Implementing Medallion Architecture (Bronze, Silver, Gold) with SQL Server &amp; Power BI to visualize strategic shifts and stock price volatility.

Nokia Strategic Performance Analysis (1994-2026) 📊
##Project Overview
This project provides an end-to-end data engineering and analytics solution focused on Nokia’s historical market performance. By implementing the Medallion Architecture, I transformed raw historical data into strategic business insights, visualizing decades of market shifts, revenue trends, and stock price volatility.

##Technical Architecture: The Medallion Approach
To ensure data integrity and scalability, the project is structured into three functional layers:

Bronze Layer (Raw): Ingested raw datasets (CSV) containing over 30 years of Nokia's market and financial data.

Silver Layer (Cleansed): Used SQL and Python to handle time-series gaps, normalize currencies, and ensure data consistency.

Gold Layer (Curated): Developed a professional Star Schema with optimized Fact and Dimension tables to power high-performance analytics.

##Key Features & Insights
Strategic Phase Mapping: Correlated stock fluctuations with major corporate eras: Domination Era, iPhone Shock, Windows Phone Bet, and the 5G Transformation.

Market Intelligence: Deep-dive analysis of revenue distribution by geographical regions (MEA, Europe, Asia Pacific) and product lines.

AI-Driven Analytics: Leveraged Power BI’s Key Influencers to identify hidden drivers behind revenue changes.

Tech Stack
Data Engineering: SQL Server (T-SQL), Python.

Data Modeling: Star Schema (Fact/Dimension tables).

Visualization: Power BI.

Methodology: Medallion Architecture.

Repository Structure
PROJECT.pbix: The interactive Power BI dashboard.

SQLQueries/: T-SQL scripts for data transformation and modeling.

Screenshots/: Visual evidence of the dashboards and data model.

Data/: (Recommended) Raw CSV files used for the analysis.

##How to Use
Clone the repository.

Execute the SQL scripts to build the database schema.

Open the .pbix file to explore the interactive visualizations.

##Developed by Eslam Samir

Business Information Systems (BIS) Student | Aspiring Data Analyst

Developed by Eslam Samir

Business Information Systems (BIS) Student | Aspiring Data Analyst
