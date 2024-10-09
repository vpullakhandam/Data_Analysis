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

-- Populate Property Address data

-- Some of the Property Address fields are empty, so those fields which have the same ParcelID are populated with the Address of the other field which share ParcelID's. 

Select a.ParcelID, a.PropertyAddress,b.ParcelID, b.PropertyAddress
from nashville_housing a
join nashville_housing b
ON a.ParcelID = b.ParcelID
AND a.uniqueID <> b.UniqueID
WHERE a.PropertyAddress = '';

UPDATE nashville_housing a
JOIN nashville_housing b ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = IF(a.PropertyAddress = '', b.PropertyAddress,b.PropertyAddress)
WHERE a.PropertyAddress = '';


