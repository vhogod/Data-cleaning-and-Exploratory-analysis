-- DATA CLEANING 


SELECT *
FROM LAYOFFS;

-- 1 REMOVE DUPLICATES

CREATE TABLE layoffs_staging
lIKE layoffs;

SELECT *
FROM layoffs_staging
;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY COMPANY, INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `DATE`)AS ROW_NUM
FROM layoffs_staging;

WITH DUPLICATE_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY COMPANY, LOCATION, INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `DATE`, STAGE, country, funds_raised_millions)AS ROW_NUM
FROM layoffs_staging
)
SELECT *
FROM DUPLICATE_CTE
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company ='ÇASPER' 
;

WITH DUPLICATE_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY COMPANY, LOCATION, INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `DATE`, STAGE, country, funds_raised_millions)AS ROW_NUM
FROM layoffs_staging
)
DELETE
FROM DUPLICATE_CTE
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `ROW_NUM` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY COMPANY, LOCATION, INDUSTRY, TOTAL_LAID_OFF, PERCENTAGE_LAID_OFF, `DATE`, STAGE, country, funds_raised_millions)AS ROW_NUM
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- 2 STANDARDIZING DATA

SELECT COMPANY, TRIM(COMPANY)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET COMPANY = TRIM(COMPANY);

SELECT distinct INDUSTRY
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE INDUSTRY LIKE 'CRYPTO%';

UPDATE layoffs_staging2
SET INDUSTRY = 'CRYPTO'
WHERE INDUSTRY LIKE 'CRYPTO%';


SELECT distinct INDUSTRY
FROM layoffs_staging2;

SELECT distinct LOCATION
FROM layoffs_staging2
ORDER BY 1;

SELECT distinct COUNTRY
FROM layoffs_staging2
ORDER BY 1;

SELECT distinct COUNTRY, trim(TRAILING '.'FROM COUNTRY)
FROM layoffs_staging2
ORDER BY 1;


UPDATE layoffs_staging2
SET COUNTRY = trim(TRAILING '.'FROM COUNTRY)
WHERE COUNTRY LIKE 'UNITED STATES%';


SELECT *
FROM layoffs_staging2;

-- CHANGE DATE TEXT FORMAT

SELECT `DATE`,
STR_TO_DATE(`DATE`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `DATE` = STR_TO_DATE(`DATE`, '%m/%d/%Y');

SELECT `DATE`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `DATE`  DATE;


SELECT *
FROM layoffs_staging2;

-- -- REMOVING NULL AND BLANKS

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'AIRBNB';

-- UPDATE THE BLANK

UPDATE layoffs_staging2
SET INDUSTRY = NULL
WHERE INDUSTRY = '';

 SELECT *
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
   ON T1.company = T2.company
WHERE (T1.INDUSTRY IS NULL OR T1.INDUSTRY = '')
AND T2.INDUSTRY IS NOT NULL;    

 SELECT T1.industry, T2.industry
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
   ON T1.company = T2.company
WHERE (T1.INDUSTRY IS NULL OR T1.INDUSTRY = '')
AND T2.INDUSTRY IS NOT NULL; 

UPDATE layoffs_staging2 T1
JOIN layoffs_staging2 T2
   ON T1.company = T2.company
SET T1.INDUSTRY = T2.INDUSTRY 
WHERE T1.INDUSTRY IS NULL
AND T2.INDUSTRY IS NOT NULL; 

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'BALLY%';


SELECT *
FROM layoffs_staging2;


DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP column ROW_NUM;