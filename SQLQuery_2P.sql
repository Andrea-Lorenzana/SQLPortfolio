SELECT * FROM [SQL Portfolio]..NashvilleHousing


-- STANDARDIZE THE FORMAT 

SELECT SaleDateConverted, CONVERT(DATE,SaleDate) As DateForm from NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(DATE,SaleDate)


ALTER TABLE NashvilleHousing
ADD SaleDateConverted DATE;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(DATE,SaleDate)


--PROPERTY ADRESS

SELECT PropertyAddress FROM NashvilleHousing WHERE PropertyAddress is NULL

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET  PropertyAddress = ISNULL(a.propertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is NULL

--BREAKING OUT ADRESS INTO  (ADDRESS, CITY, STATE)
SELECT PropertyAddress FROM NashvilleHousing

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) AS CITY
FROM NashvilleHousing  

--ADD THE COLUMNS---
-- address
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)
-- City
ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))






--OTHER WAY TO DO IT

Select OwnerAddress from NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',' , '.'),1) AS ESTATE,
PARSENAME(REPLACE(OwnerAddress, ',' , '.'),2) AS CITY,
PARSENAME(REPLACE(OwnerAddress, ',' , '.'),3) AS ADDRESS
FROM NashvilleHousing

--Note: PARSE NAME ONLY FUNCTION WITH DOTS SO FOR THAT I USE THE REPLACE FUNCTION 

-- address
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',' , '.'),3)

-- City
ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',' , '.'),2)

--STATE
ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',' , '.'),1)


-- SOLD AS VACANT
 
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant) AS YesNoCount FROM NashvilleHousing
GROUP BY SoldAsVacant

SELECT SoldAsVacant,
 CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	  WHEN SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant
	  END AS YesOrNo
 FROM NashvilleHousing

BEGIN TRAN
 UPDATE NashvilleHousing
 SET SoldAsVacant =  CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	  WHEN SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant
	  END
 ROLLBACK TRAN 


 COMMIT TRAN
 