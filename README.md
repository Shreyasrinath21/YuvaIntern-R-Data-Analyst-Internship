# YuvaIntern - R Data Analyst Internship

## Project Overview

This repository contains the work completed during my 4-week Virtual R Data Analyst Internship. The project focused on analyzing supermarket sales data using R, covering data cleaning, exploratory data analysis, visualization, statistical analysis, and predictive modeling.

## Dataset

The dataset contains 1,000 supermarket transactions and 17 variables, including branch, city, customer type, gender, product line, unit price, quantity, sales, date, time, payment method, COGS, gross income, and customer rating.

## Tools & Technologies

- R
- RStudio
- tidyverse
- dplyr
- ggplot2
- janitor
- lubridate
- scales
- corrplot

## Project Workflow

### Week 1 - Data Cleaning & Preliminary Analysis

- Explored the dataset structure and dimensions
- Checked for missing values and duplicate records
- Cleaned column names using `janitor`
- Converted date values
- Detected and investigated outliers using boxplots and the IQR method
- Normalized sales data using `scale()`
- Encoded categorical variables
- Created date and time-based features
- Analyzed correlations between numerical variables

### Week 2 - Data Visualization & Insight Communication

Created visualizations to analyze:

- Sales distribution
- Product-line performance
- Branch performance
- Day and hour sales intensity
- Monthly sales trends
- Customer satisfaction
- Customer types
- Payment and product-line patterns
- Correlations between numerical variables

### Week 3 - Statistical Analysis & Predictive Modeling

Performed:

- Descriptive statistics
- Shapiro-Wilk normality testing
- Pearson correlation
- Welch's two-sample t-test
- Chi-square tests

A Logistic Regression model was developed to predict whether a customer was a Member or Normal customer.

The modeling process included an 80/20 train-test split, probability prediction, classification thresholding, confusion matrix evaluation, and 10-fold cross-validation.

### Week 4 - Comprehensive Analysis & Reporting

Integrated the work from Weeks 1–3 into a final report covering data cleaning, visualization, statistical analysis, predictive modeling, results, challenges, learning outcomes, and future directions.

## Key Results

- Mean sales: **322.97**
- Median sales: **253.85**
- Highest monthly sales: **116,292** in January
- Lowest monthly sales: **97,216** in February
- Average transaction quantity: **5.51**
- Average customer rating: **6.97**
- Logistic Regression test accuracy: **57%**
- 10-fold cross-validation mean accuracy: **56.75%**

## Skills Developed

- Data Cleaning
- Exploratory Data Analysis
- Data Visualization
- Statistical Analysis
- Feature Engineering
- Outlier Detection
- Correlation Analysis
- Logistic Regression
- Model Evaluation
- Cross-Validation
- Data Interpretation

## Conclusion

This internship provided hands-on experience with the complete data analytics workflow using R, from raw data cleaning and exploration to visualization, statistical analysis, predictive modeling, and interpretation.
