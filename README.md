# Data Cleaning Project: World Layoffs

## Overview
This project focuses on cleaning and preparing a raw dataset of world layoffs for analysis. The goal was to transform the data from its raw state—containing duplicates, inconsistencies, and missing values—into a clean, standardized format suitable for exploration and reporting.

## Dataset
The project utilizes a `layoffs.csv` file, which contains information about company layoffs across various industries, locations, and funding stages.

## Tools Used
*   **MySQL**: Primary tool for data manipulation and cleaning.
*   **SQL Queries**: Used for staging, duplicate removal, standardization, and handling null values.

## Cleaning Steps

### 1. Data Staging
To preserve the original data, a staging table (`layoffs_staging`) was created. All cleaning operations were performed on this staging table to ensure the `layoffs_raw` data remained intact.

### 2. Duplicate Removal
Duplicates were identified using the `ROW_NUMBER()` window function, partitioning by all relevant columns (company, location, industry, etc.). Rows with a `row_num > 1` were deleted to ensure data uniqueness.

### 3. Data Standardization
*   **Trimming**: Removed leading and trailing spaces from the `company` column.
*   **Industry Consolidation**: Standardized variations of industry names (e.g., grouping all "Crypto" related entries under a single "Crypto" label).
*   **Country Names**: Fixed inconsistencies in country names (e.g., removing trailing periods like "United States.").
*   **Date Format**: Converted the `date` column from a text string to a proper `DATE` format using `STR_TO_DATE`.

### 4. Handling Nulls and Blanks
*   **Industry Imputation**: Populated missing `industry` values by joining the table with itself on the `company` name, filling nulls where other records for the same company had industry data.
*   **Irrelevant Data**: Deleted rows where both `total_laid_off` and `percentage_laid_off` were null, as these records provided insufficient information for analysis.

### 5. Final Cleanup
The auxiliary `row_num` column used for duplicate removal was dropped, and the final cleaned table was renamed or prepared for further analysis.

## How to Run
1.  Import the `layoffs.csv` into your MySQL environment as `layoffs_raw`.
2.  Execute the queries in `Data cleaning.sql` sequentially to perform the cleaning process.
