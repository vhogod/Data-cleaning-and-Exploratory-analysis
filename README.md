# MySQL Data Cleaning and Exploratory Data Analysis

This project uses MySQL to clean and analyze a dataset, preparing it for further analysis and reporting. It includes SQL scripts for handling missing data, duplicates, and inconsistencies, as well as queries for exploratory data analysis  to uncover insights through aggregations and visualizations.

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [EDA Highlights](#eda-highlights)


## Project Overview
This repository contains MySQL scripts to clean and explore a dataset. The cleaning process addresses issues like null values, duplicates, and inconsistent formats, while EDA queries generate summary statistics, distributions, and relationships between variables. This project is ideal for data analysts working with relational databases.

## Dataset
The dataset is layoffs . It contains records of workers laid off by companies  with columns for company, date, country, and others.

## EDA Highlights
The MySQL scripts perform:

•  Data Cleaning:

	•  Replace NULL values with defaults 
	•  Remove duplicates using DISTINCT or ROW_NUMBER().
	•  Standardize text formats ( TRIM(), or DATE_FORMAT()).
 
•  Exploratory Data Analysis:

	•  Summary statistics: COUNT, AVG, MIN, MAX for numerical columns.
	•  Group-by queries: Analyze trends by categories (layoff by country).
	•  Joins: Combine tables to explore relationships 
	•  Frequency distributions: Use GROUP BY to count occurrences.
