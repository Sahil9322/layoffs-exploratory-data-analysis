-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging3;

SELECT max(total_laid_off),max(percentage_laid_off)
FROM layoffs_staging3;


SELECT *
FROM layoffs_staging3
where percentage_laid_off =1
ORDER BY total_laid_off desc;


SELECT *
FROM layoffs_staging3
where percentage_laid_off =1
ORDER BY funds_raised_millions desc;

SELECT company,sum(total_laid_off)
FROM layoffs_staging3
group by company
order by 2 desc;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging3;

-- by industry analysis 

SELECT industry,sum(total_laid_off)
FROM layoffs_staging3
group by industry
order by 2 desc;

SELECT *
FROM layoffs_staging3;

-- by country analysis

SELECT country,sum(total_laid_off)
FROM layoffs_staging3
group by country
order by 2 desc;

-- by yearly and stage  analysis

SELECT year(`date`),sum(total_laid_off)
FROM layoffs_staging3
group by year(`date`)
order by 2 desc;

SELECT stage,sum(total_laid_off)
FROM layoffs_staging3
GROUP BY stage
order by 2 desc;

-- monthly rolling total

SELECT SUBSTRING(`date`,1,7) as `MONTH` ,sum(total_laid_off)
FROM layoffs_staging3
where SUBSTRING(`date`,1,7) is not NULL
GROUP BY MONTH
order by 1 asc;

-- ROLLING TOTAL VISUALiZATIONN

with Rolling_Total as 
(SELECT SUBSTRING(`date`,1,7) as `MONTH` ,sum(total_laid_off) as total_off
FROM layoffs_staging3
where SUBSTRING(`date`,1,7) is not NULL
GROUP BY `MONTH`
order by 1 asc

)
SELECT `MONTH`,total_off 
,sum(total_off) OVER (ORDER BY `MONTH`) as rolling_total
FROM Rolling_Total;


SELECT company,sum(total_laid_off)
FROM layoffs_staging3
group by company
order by 2 desc;

-- company ranking by year

SELECT company,YEAR (`date`),sum(total_laid_off)
FROM layoffs_staging3
GROUP BY company,year(`date`)
order by 3 desc;

-- RANKING TOP COMPANIES


with company_year (COMPANY,years,total_laid_off)as 
(SELECT company,YEAR (`date`),sum(total_laid_off)
FROM layoffs_staging3
GROUP BY company,year(`date`)
), Company_Year_Rank as 
(SELECT *,
DENSE_RANK()OVER (PARTITION BY years order by total_laid_off desc) as RANKING
FROM company_year
WHERE years is not NULL
)
SELECT *
FROM Company_Year_Rank
where RANKING <=5
;