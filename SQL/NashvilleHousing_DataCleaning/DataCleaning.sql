-- Disabling safe updates to allow updates without requiring a WHERE clause (use with caution).
SET SQL_SAFE_UPDATES = 0;

-- Task 1: Standardize Date Format
-- Select current SaleDate values for reference before making changes.
SELECT SaleDate 
FROM nashville_housing;

-- The SaleDate column is currently stored as a string/text type, so we need to convert it into a proper DATE format.
-- Step 1: Add a new column called SaleDateConverted of DATE type to hold the converted date values.
ALTER TABLE nashville_housing
ADD SaleDateConverted DATE;

-- Step 2: Update the SaleDateConverted column by converting the existing SaleDate (in text format) using STR_TO_DATE function.
-- The date format used is '%M %d, %Y', which matches the format of SaleDate (e.g., 'January 15, 2020').
UPDATE nashville_housing
SET SaleDateConverted = STR_TO_DATE(SaleDate, '%M %d, %Y');

-- Step 3: Remove the old SaleDate column since it's no longer needed after the conversion.
ALTER TABLE nashville_housing
DROP COLUMN SaleDate;

-- Step 4: Rename the SaleDateConverted column to SaleDate for consistency with the original column name.
ALTER TABLE nashville_housing
CHANGE SaleDateConverted SaleDate DATE;

-- Verify the updated SaleDate column.
SELECT SaleDate
FROM nashville_housing;

-- Task 2: Populate Property Address Data
-- Some PropertyAddress fields are empty. We will populate those fields based on matching ParcelID values.
-- First, we display ParcelID and PropertyAddress pairs where one row has a blank PropertyAddress, and the other with the same ParcelID has a valid address.
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM nashville_housing a
JOIN nashville_housing b
ON a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress = '';

-- Step 5: Update the rows with empty PropertyAddress fields by copying the address from other rows with the same ParcelID.
UPDATE nashville_housing a
JOIN nashville_housing b ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = IF(a.PropertyAddress = '', b.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress = '';

-- Task 3: Break Address into Individual Columns (Address, City, State)
-- To better organize the address data, we'll split the PropertyAddress column into separate columns: Address, City, and State.

-- Step 6: Preview how the addresses will be split.
SELECT SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress)) AS City
FROM nashville_housing;

-- Step 7: Add three new columns to store the split address parts: Address, City, and State.
ALTER TABLE nashville_housing
ADD Address VARCHAR(255);

ALTER TABLE nashville_housing
ADD City VARCHAR(255);

ALTER TABLE nashville_housing
ADD State VARCHAR(255);

-- Step 8: Populate the Address column with the part of PropertyAddress before the first comma.
UPDATE nashville_housing
SET Address = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);

-- Step 9: Populate the City column with the part of PropertyAddress after the first comma.
UPDATE nashville_housing
SET City = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress));

-- Step 10: Populate the State column using the OwnerAddress by extracting the last part after the last comma.
UPDATE nashville_housing
SET State = SUBSTRING_INDEX(OwnerAddress, ',', -1);

-- Verify the updated table with the new Address, City, and State columns.
SELECT * FROM nashville_housing;

-- Task 4: Standardize Values in "Sold As Vacant" Field
-- The SoldAsVacant field contains 'Y' for Yes and 'N' for No. We want to standardize these values by converting 'Y' to 'Yes' and 'N' to 'No'.
UPDATE nashville_housing
SET SoldAsVacant = 
(CASE 
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END);

-- Task 5: Remove Duplicates
-- Some rows have the same ParcelID, Address, SalePrice, SaleDate, and LegalReference but different UniqueID values, indicating duplicates.
-- We'll use a Common Table Expression (CTE) to identify and remove the duplicate rows, keeping only one unique entry for each group.

WITH RowNumCTE AS (
    -- Select all columns and assign a row number to each row based on the combination of ParcelID, Address, SalePrice, SaleDate, and LegalReference.
    -- The ROW_NUMBER function assigns a unique row number starting from 1 for each partition (group of rows with the same ParcelID, etc.).
    SELECT UniqueID,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID,
                            Address,
                            SalePrice,
                            SaleDate,
                            LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM nashville_housing
)
-- Delete the duplicate rows where the row number is greater than 1 (i.e., keeping the first instance of each duplicate).
DELETE FROM nashville_housing
WHERE UniqueID IN (
    SELECT UniqueID
    FROM RowNumCTE
    WHERE row_num > 1
);

-- Task 6: Delete Unused Columns
-- Now, we'll remove columns that are no longer needed: OwnerAddress, PropertyAddress, and SaleDate.

ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress, 
DROP COLUMN PropertyAddress, 
DROP COLUMN SaleDate;

-- Final Step: Verify the table to ensure all changes have been applied successfully.
SELECT * FROM nashville_housing;
