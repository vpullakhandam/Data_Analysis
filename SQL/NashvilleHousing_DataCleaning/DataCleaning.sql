-- Setting the SQL Safe Updates to 0 to ensure that I will get to update without mentioning where condition. 

SET SQL_SAFE_UPDATES = 0;

-- Task 1
-- Standardize Date Format

SELECT SaleDate 
FROM nashville_housing;

-- The SalesData was in text data type format so changed it to Date format using STR_TO_DATE(SaleDate, '%M %d, %Y')
ALTER TABLE nashville_housing
ADD SaleDateConverted DATE;
UPDATE nashville_housing
SET SaleDateConverted = STR_TO_DATE(SaleDate, '%M %d, %Y');

DROP SaleDate Column
ALTER TABLE nashville_housing
DROP COLUMN SaleDate;

RENAME SaleDataConverted to SaleData
ALTER TABLE nashville_housing
CHANGE SaleDateConverted SaleDate DATE;

SELECT SaleDate
FROM nashville_housing

