CREATE TABLE layoffs_staging
LIKE layoffs_raw;

select *
from layoffs_raw;

insert into layoffs_staging
select *
from layoffs_raw;

select *
from layoffs_staging;

with duplicates as (
	select *,
    row_number()  over (
			partition by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) as row_num
	from layoffs_staging
)
select *
from duplicates
where row_num > 1;

select *
from layoffs_staging
where company = 'Casper';

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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into layoffs_staging2
select *,
row_number()  over (
			partition by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) as row_num
from layoffs_staging;

select * 
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

select * 
from layoffs_staging2;

SELECT DISTINCT company, trim(company)
from layoffs_staging2
ORDER BY 1;

update layoffs_staging2
set company = trim(company);

SELECT DISTINCT industry
from layoffs_staging2
ORDER BY 1;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT t1.company, t1.industry, t2.company, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE industry is null;

SELECT `date`, str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

update layoffs_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
MODIFY COLUMN `date` DATE;

Update layoffs_staging
SET country = 'United States'
where country like 'United States%';

Select DISTINCT country
from layoffs_staging
where country like 'United States%';

select *
from layoffs_staging2
where total_laid_off is null
	and percentage_laid_off is null;
    
DELETE
from layoffs_staging2
where total_laid_off is null
	and percentage_laid_off is null;
    
select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2;

-- drop table layoffs_staging;

ALTER TABLE layoffs_staging2
RENAME TO layoffs_staging;

select *
from layoffs_staging;

