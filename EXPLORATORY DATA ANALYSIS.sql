-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging2;


SELECT max(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY TOTAL_LAID_OFF DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY TOTAL_LAID_OFF DESC;

SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT min(`DATE`), max(`DATE`)
FROM layoffs_staging2;

SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT COUNTRY, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY COUNTRY
ORDER BY 2 DESC;

SELECT year(`DATE`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`DATE`)
ORDER BY 2 DESC;

SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;


SELECT company, avg(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- ROLLING TOTAL LAYOFF

SELECT substring(`DATE`, 1,7) AS `MONTH`, sum(TOTAL_LAID_OFF)
FROM layoffs_staging2
WHERE substring(`DATE`, 1,7) IS NOT NULL
group by  `MONTH`
ORDER BY 1 ASC;

-- CREATE A CTE

WITH ROLLING_TOTAL AS
(
SELECT substring(`DATE`, 1,7) AS `MONTH`, sum(TOTAL_LAID_OFF) AS TOTAL_OFF
FROM layoffs_staging2
WHERE substring(`DATE`, 1,7) IS NOT NULL
group by  `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, TOTAL_OFF 
,sum(TOTAL_OFF) OVER(ORDER BY `MONTH`) AS ROLLING_TOTAL
FROM ROLLING_TOTAL;

SELECT company, avg(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`DATE`), SUM(TOTAL_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`DATE`)
ORDER BY 3 DESC;


WITH COMPANY_YEAR (COMPANY, YEARS, TOTAL_LAID_OFF) AS
(
SELECT company, YEAR(`DATE`), SUM(TOTAL_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`DATE`)
),COMPANY_YEAR_RANK AS
(
SELECT *, 
dense_rank() OVER(partition by YEARS ORDER BY TOTAL_LAID_OFF DESC) AS RANKING
FROM COMPANY_YEAR
WHERE YEARS IS NOT NULL
)
SELECT *
FROM COMPANY_YEAR_RANK
WHERE RANKING <= 5
;