# 📊 Retail Sales EDA & SQL Data Pipeline

## 🎯 Project Overview
This project focuses on the Exploratory Data Analysis (EDA) of a seasonal retail sales dataset. The goal was to clean messy transaction records, engineer consistent features, and construct a reliable data pipeline to shift clean data directly into a SQL warehouse for production analytics.

## 🛠️ Tech Stack & Environment
* **Language:** Python 3 (JupyterLab)
* **Libraries:** Pandas,SQLAlchemy
* **Database Target:** MySQL 
* **Version Control:** Git & GitHub

## 🧼 Core Data Cleaning & Engineering Steps
* **Localized Imputation:** Handled missing review scores by segmenting data by product categories and populating empties using group-specific median values to preserve variance.
* **Text Standardization:** Converted the entire feature header index into uniform `snake_case` layout to prevent cross-language scripting errors between Python and SQL.
* **Chronological Mapping:** Developed string mapping logic to translate purchase patterns (e.g., matching "Annually" directly to 365, "Weekly" to 7) into structural integer values ready for numeric analytics.

## 🛞 Pipeline Architecture & Design
The architecture utilizes **SQLAlchemy engines** acting as automated data carriers. By configuring target connection vectors (`dialect+driver://`), the script packages the finalized dataframes as a clean cargo payload and pushes them straight into relational database layers using optimal transactional chunk sizes.

## 🚀 How to Run the Project
1. Clone the repository: `git clone https://github.com`
2. Install dependencies: `pip install pandas sqlalchemy pymysql`
3. Run the notebook `FIRSTDAp.ipynb` inside JupyterLab or classic Jupyter Notebook.
4.
