# Nashville Housing Data Cleanup

This project involves cleaning and standardizing the Nashville Housing dataset to improve data quality for further analysis. The steps performed in this process include standardizing date formats, splitting address data, populating missing values, and removing duplicate records.

## Steps

1. **Date Standardization**:
   - Converted the `SaleDate` from a text format to a `DATE` format.
   - Dropped the old `SaleDate` column and renamed the new date field.

2. **Address Cleanup**:
   - Populated missing `PropertyAddress` fields by matching rows with the same `ParcelID`.
   - Split the `PropertyAddress` into three separate columns: `Address`, `City`, and `State`.

3. **Standardizing "Sold As Vacant" Field**:
   - Converted 'Y' and 'N' values in the `SoldAsVacant` column to 'Yes' and 'No'.

4. **Duplicate Removal**:
   - Identified and removed duplicate rows based on `ParcelID`, `Address`, `SalePrice`, `SaleDate`, and `LegalReference`.

5. **Dropping Unused Columns**:
   - Removed obsolete columns like `OwnerAddress`, `PropertyAddress`, and `SaleDate` after data cleanup.

## Usage
This SQL script can be executed in MySQL Workbench or any SQL editor that supports MySQL syntax. It cleans and prepares the Nashville housing dataset for analysis.
