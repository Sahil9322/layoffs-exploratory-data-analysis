# 📊 Layoffs Exploratory Data Analysis Using SQL

## 📌 Project Overview

This project focuses on performing **Exploratory Data Analysis (EDA)** on a cleaned layoffs dataset using **MySQL**.

The purpose of this project is to explore the cleaned dataset and identify useful patterns and trends in company layoffs.

After completing the data-cleaning process, SQL queries were used to investigate layoffs from different perspectives, including:

* Total layoffs
* Companies with the highest number of layoffs
* Companies with 100% workforce layoffs
* Industries with the highest layoffs
* Countries with the highest layoffs
* Layoffs by year
* Layoffs by company stage
* Monthly layoffs
* Monthly rolling totals
* Company ranking by year

The project demonstrates how SQL can be used to transform a cleaned dataset into meaningful analytical information.

---

# 🎯 Project Objectives

The main objectives of this project are:

1. Explore the cleaned layoffs dataset.
2. Identify the maximum number of employees laid off.
3. Identify companies that laid off 100% of their workforce.
4. Find companies with the highest total layoffs.
5. Analyze layoffs by industry.
6. Analyze layoffs by country.
7. Analyze layoffs by year.
8. Analyze layoffs by company stage.
9. Analyze monthly layoffs.
10. Calculate a cumulative/rolling total of layoffs over time.
11. Rank companies based on yearly layoffs.

---

# 📂 Dataset

The project uses the cleaned **Layoffs dataset**.

The original dataset can be accessed here:

👉 **[Layoffs Dataset – layoffs.csv](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)**

**Dataset Source:** Alex The Analyst – MySQL YouTube Series

The dataset contains information such as:

* Company
* Location
* Industry
* Total employees laid off
* Percentage laid off
* Date
* Company stage
* Country
* Funds raised

---

# 🛠️ Tools & Technologies

**Database:** MySQL
**Language:** SQL
**Tool:** MySQL Workbench
**Project Type:** Exploratory Data Analysis
**Dataset:** Company Layoffs Dataset

---

# 🔍 Analysis Performed

## 1. Initial Dataset Exploration

The first step was to view the cleaned dataset and understand its structure.

```sql
SELECT *
FROM layoffs_staging3;
```

This provides an overview of the available data before beginning the analysis.

---

## 2. Maximum Layoffs

I calculated the maximum values for:

* Total employees laid off
* Percentage of employees laid off

```sql
SELECT MAX(total_laid_off),
       MAX(percentage_laid_off)
FROM layoffs_staging3;
```

This helps identify the highest values present in the dataset.

---

## 3. Companies That Laid Off 100% of Employees

I identified companies where the `percentage_laid_off` value was `1`, representing a 100% layoff.

```sql
SELECT *
FROM layoffs_staging3
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
```

The results were sorted by the total number of employees laid off to identify the largest complete-workforce layoffs.

---

## 4. Companies With 100% Layoffs and Highest Funding

I also analyzed companies that laid off 100% of their workforce and sorted them based on the amount of funds they had raised.

```sql
SELECT *
FROM layoffs_staging3
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
```

This provides another perspective on companies that completely shut down their workforce.

---

## 5. Companies With the Highest Total Layoffs

I grouped the data by company and calculated the total number of layoffs for each company.

```sql
SELECT company,
       SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company
ORDER BY 2 DESC;
```

This helps identify companies with the largest cumulative number of layoffs in the dataset.

---

## 6. Date Range of the Dataset

I identified the earliest and latest dates available in the dataset.

```sql
SELECT MIN(date),
       MAX(date)
FROM layoffs_staging3;
```

This helps understand the time period covered by the dataset.

---

# 🏭 Industry Analysis

## 7. Layoffs by Industry

I grouped layoffs by industry and calculated the total layoffs for each industry.

```sql
SELECT industry,
       SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY industry
ORDER BY 2 DESC;
```

This allows industries to be compared based on their total number of layoffs.

### Questions this analysis can help answer:

* Which industries experienced the highest layoffs?
* Which industries experienced relatively fewer layoffs?
* How are layoffs distributed across different industries?

---

# 🌎 Country Analysis

## 8. Layoffs by Country

I grouped the dataset by country and calculated the total layoffs.

```sql
SELECT country,
       SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY country
ORDER BY 2 DESC;
```

This provides a country-level comparison of layoffs.

### Questions this analysis can help answer:

* Which countries recorded the highest layoffs?
* How are layoffs distributed geographically?
* Which countries appear most affected in the dataset?

---

# 📅 Time-Based Analysis

## 9. Layoffs by Year

I grouped layoffs by year to understand how layoffs changed over time.

```sql
SELECT YEAR(date),
       SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY YEAR(date)
ORDER BY 2 DESC;
```

This provides a year-by-year view of total layoffs.

---

## 10. Layoffs by Company Stage

I analyzed layoffs based on the company's stage.

```sql
SELECT stage,
       SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY stage
ORDER BY 2 DESC;
```

This helps compare layoffs across different company stages.

---

# 📆 Monthly Analysis

## 11. Monthly Layoff Analysis

I calculated total layoffs for each month.

```sql
SELECT SUBSTRING(date,1,7) AS MONTH,
       SUM(total_laid_off)
FROM layoffs_staging3
WHERE SUBSTRING(date,1,7) IS NOT NULL
GROUP BY MONTH
ORDER BY 1 ASC;
```

This allows the dataset to be analyzed at a monthly level and helps identify periods with higher or lower layoffs.

---

# 📈 Rolling Total Analysis

## 12. Monthly Rolling Total

A rolling total was calculated to understand the cumulative number of layoffs over time.

First, monthly layoffs were calculated using a CTE:

```sql
WITH Rolling_Total AS
(
    SELECT SUBSTRING(date,1,7) AS MONTH,
           SUM(total_laid_off) AS total_off
    FROM layoffs_staging3
    WHERE SUBSTRING(date,1,7) IS NOT NULL
    GROUP BY MONTH
)
```

Then a window function was used to calculate the cumulative total:

```sql
SUM(total_off) OVER (
    ORDER BY MONTH
) AS rolling_total
```

This provides a cumulative view of layoffs over the selected time period.

### SQL concepts demonstrated:

* CTE
* `SUM()`
* Window Functions
* `OVER()`
* `ORDER BY`
* Monthly aggregation

---

# 🏆 Company Ranking

## 13. Company Layoffs by Year

I analyzed total layoffs for each company for each year.

```sql
SELECT company,
       YEAR(date),
       SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company,
         YEAR(date)
ORDER BY 3 DESC;
```

This helps identify companies with high layoffs during individual years.

---

## 14. Ranking Top 5 Companies Each Year

I used a CTE and the `DENSE_RANK()` window function to rank companies based on their yearly layoffs.

```sql
DENSE_RANK() OVER (
    PARTITION BY years
    ORDER BY total_laid_off DESC
) AS RANKING
```

Then I filtered the results to show companies ranked in the top five:

```sql
WHERE RANKING <= 5;
```

This produces a yearly ranking of the top five companies based on total layoffs.

---

# 🧠 SQL Concepts Used

This project demonstrates several important SQL concepts:

### Basic SQL

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `MIN()`
* `MAX()`
* `SUM()`

### Data Aggregation

* Aggregating layoffs by company
* Aggregating layoffs by industry
* Aggregating layoffs by country
* Aggregating layoffs by year
* Aggregating layoffs by month
* Aggregating layoffs by company stage

### Advanced SQL

* Common Table Expressions (CTEs)
* Window Functions
* `DENSE_RANK()`
* `SUM() OVER()`
* `PARTITION BY`
* Date functions
* String functions

---

# 🔄 Analysis Workflow

```text
Cleaned Layoffs Dataset
          ↓
   Explore Dataset
          ↓
    Calculate Maximums
          ↓
Analyze 100% Layoff Companies
          ↓
Analyze Companies by Total Layoffs
          ↓
     Industry Analysis
          ↓
      Country Analysis
          ↓
      Yearly Analysis
          ↓
    Stage Analysis
          ↓
    Monthly Analysis
          ↓
 Monthly Rolling Total
          ↓
   Company Year Ranking
          ↓
 Top 5 Companies Per Year
```

---

# 💡 Key Questions Explored

This project uses SQL to answer questions such as:

* What is the maximum number of employees laid off?
* Which companies laid off 100% of their workforce?
* Which fully-laying-off companies had raised the most funding?
* Which companies had the highest total layoffs?
* What is the time period covered by the dataset?
* Which industries experienced the most layoffs?
* Which countries experienced the most layoffs?
* How did layoffs vary by year?
* Which company stages experienced the most layoffs?
* How did layoffs change month by month?
* What is the cumulative number of layoffs over time?
* Which companies ranked in the top five for layoffs each year?

---

# 📊 Project Insights

The SQL queries in this project are designed to generate insights from the dataset rather than simply retrieve individual records.

The analysis provides different perspectives:

**Company Perspective**
Identifies companies with high total layoffs and yearly rankings.

**Industry Perspective**
Compares total layoffs across industries.

**Geographical Perspective**
Compares layoffs across countries.

**Time Perspective**
Examines layoffs by year and month and calculates a rolling total.

**Company Stage Perspective**
Analyzes layoffs according to company stage.

---

# 🚀 Future Improvements

This SQL-based EDA project can be extended further by creating visualizations using:

* Power BI
* Tableau
* Excel
* Python
* Looker Studio

Possible future analysis could include:

* Interactive dashboards
* Industry-wise trend visualization
* Country-wise visualization
* Year-over-year growth calculations
* Percentage contribution by industry
* Top companies visualization
* Monthly trend charts
* Interactive filters

---

# 📁 Project Structure

```text
layoffs-exploratory-data-analysis/
│
├── 📄 Exploratory data analysis project.sql
│
└── 📄 README.md
```

If you combine this with your previous data-cleaning project:

```text
layoffs-sql-analysis/
│
├── 📄 data cleaning.sql
├── 📄 Exploratory data analysis project.sql
└── 📄 README.md
```

---

# 🎓 What I Learned

Through this project, I strengthened my practical SQL and data-analysis skills.

I learned how to:

* Explore a cleaned dataset
* Aggregate data using `GROUP BY`
* Analyze trends over time
* Use date and string functions
* Create CTEs
* Use window functions
* Calculate rolling totals
* Rank companies using `DENSE_RANK()`
* Analyze data from multiple perspectives
* Convert raw query results into analytical questions

---

# 👨‍💻 Project Purpose

This project is part of my **Data Analyst learning journey** and demonstrates my practical experience with SQL and exploratory data analysis.

The project focuses on using SQL to explore a real-world dataset and identify patterns across companies, industries, countries, time periods, and company stages.

---

## ⭐ Skills Demonstrated

`SQL` `MySQL` `Exploratory Data Analysis` `Data Analysis` `Data Aggregation` `CTE` `Window Functions` `DENSE_RANK` `Data Visualization Preparation` `MySQL Workbench`

---

## 📌 Related Project

This EDA project is based on a dataset that was first cleaned and prepared using SQL.

**Previous Project:**
👉 **Layoffs Data Cleaning Using SQL**

The data-cleaning process prepared the dataset for this exploratory analysis.

## 📂 Dataset

The dataset used in this project is the Layoffs dataset.

👉 [Layoffs Dataset – layoffs.csv](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)

**Dataset Source:** Alex The Analyst – MySQL YouTube Series
