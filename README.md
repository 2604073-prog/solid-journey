# 📊 Data Analytics & SQL Engineering Portfolio

## 🎯 Project Overview
This repository showcases end-to-end data processing workflows, featuring comprehensive exploratory data analysis (EDA), automated pipeline engineering, and rigorous relational database optimization. 

---

## 💻 Project 1: Retail Sales EDA & SQL Data Pipeline
* **Tech Stack:** Python 3 (JupyterLab), Pandas, SQLAlchemy, MySQL

### 🧼 Core Data Cleaning & Engineering Steps
* **Localized Imputation:** Handled missing review scores by segmenting data by product categories and populating empties using group-specific median values to preserve variance.
* **Text Standardization:** Converted the entire feature header index into uniform `snake_case` layout to prevent cross-language scripting errors between Python and SQL.
* **Chronological Mapping:** Developed string mapping logic to translate purchase patterns (e.g., matching "Annually" directly to 365, "Weekly" to 7) into structural integer values ready for numeric analytics.

### 🛞 Pipeline Architecture & Design
The architecture utilizes **SQLAlchemy engines** acting as automated data carriers. By configuring target connection vectors (`dialect+driver://`), the script packages the finalized dataframes as a clean cargo payload and pushes them straight into relational database layers using optimal transactional chunk sizes.

### 🚀 How to Run
1. Clone the repository: `git clone https://github.com`
2. Install dependencies: `pip install pandas sqlalchemy pymysql`
3. Run the notebook `FIRSTDAp.ipynb`.

---

## 🛢️ Project 2: Global Layoffs Relational Data Cleaning
* **Tech Stack:** MySQL Workbench, SQL

### 🧼 Core Data Cleaning & Engineering Steps
* **Staging Environment Architecture:** Established isolated working layers (`layoffs_new`) mirror-copied directly from raw schemas to preserve source data integrity.
* **Triplicate Records Isolation:** Implemented `ROW_NUMBER()` metrics windowed over core multi-column fingerprints (`company`, `location`, `date`, `total_laid_off`) to catch and eliminate true data duplicates.
* **Self-Join Missing Value Recovery:** Constructed relational self-joins matching structural entity anchors (`ON t1.company = t2.company`) to dynamically impute blank or `NULL` industry categories from historical source records.
* **Data Formatting & Validation:** Standardized text anomalies and fixed syntax-breaking temporal representations across core analytical columns.

### 🚀 How to Run
1. Open MySQL Workbench.
2. Load and execute the script: `data_cleaning_project.sql`.
3.
