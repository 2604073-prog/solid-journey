-- CHECKING WHETHER THE DATA HAS BEEN IMPORTED SUCCESSFULLY--
SELECT *
FROM layoffs;

-- CREATING A WORKING AREA TABLE TO KEEP OUR ORIGINAL DATASET AS OUR REFERENCE POINT--

 CREATE TABLE layoffs_new
 LIKE layoffs;
 
 SELECT * FROM layoffs_new;
 
 INSERT INTO layoffs_new 
 SELECT *
FROM layoffs;

SELECT * FROM layoffs_new;
-- DATA CLEANING --
-- CHECCKING AND REMOVING DUPLICATES--
-- 1st--
SELECT company,`date`,total_laid_off,location,funds_raised_millions,COUNT(*) AS num_rows FROM layoffs_new
GROUP BY company,`date`,total_laid_off,location,funds_raised_millions
HAVING COUNT(*) > 1;

-- 2nd --

WITH duplicates_cte AS
(
SELECT * ,ROW_NUMBER ()
OVER( PARTITION BY company,`date`,total_laid_off,location,funds_raised_millions) AS row_num
FROM layoffs_new
)
SELECT * FROM duplicates_cte  ;

-- REMOVING DUPLICATES AFTER FINDING THEM...ITS TRICKY IN MYSQL - CREATING A NEW TABLE TO HELP DELETE.
CREATE TABLE `layoffs_new2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_new2;

INSERT INTO layoffs_new2
WITH duplicates_cte AS
(
SELECT * ,ROW_NUMBER ()
OVER( PARTITION BY company,`date`,total_laid_off,location,funds_raised_millions) AS row_num
FROM layoffs_new
)
SELECT * FROM duplicates_cte;

SET SQL_SAFE_UPDATES = 0 ;

DELETE 
FROM layoffs_new2 
WHERE row_num > 1;

SELECT * FROM layoffs_new2;

SET SQL_SAFE_UPDATES = 1 ;

SELECT COUNT(*) FROM layoffs_new2;


-- STANDARDIZATION OF FORMATS --

-- COMPANY STANDARDIZATION--
SELECT DISTINCT(company) FROM layoffs_new2 ;
SET SQL_SAFE_UPDATES = 0;

UPDATE layoffs_new2 
SET company = TRIM(company);

SELECT company FROM layoffs_new2;
-- INDUSTRY STANDARDIZATION --

SELECT * FROM layoffs_new2
WHERE industry like 'Crypto%';

UPDATE layoffs_new2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';



SELECT DISTINCT(industry) FROM layoffs_new2 
ORDER BY 1;

-- LOCATION STANDARDIZATION--

SELECT DISTINCT (location)
FROM layoffs_new2
ORDER BY 1 ;

UPDATE layoffs_new2
SET location = CASE 
WHEN location LIKE 'DÃ¼sseldorf' THEN 'Dusseldorf'
WHEN location LIKE 'Duesseldorf' THEN 'Dusseldorf'
WHEN location LIKE 'FlorianÃ³polis' THEN 'Florianopolis'
WHEN location LIKE 'MalmÃ¶' THEN 'Malmo'
ELSE location
END;

 SELECT DISTINCT(location) FROM layoffs_new2
 ORDER BY 1;

-- COUNTRY CHECKING AND STANDARDIZATION --

SELECT DISTINCT(country) FROM layoffs_new2 
ORDER BY 1;

UPDATE layoffs_new2
SET country = 'United States'
WHERE country = 'United States.';

SELECT DISTINCT(country) FROM layoffs_new2 
ORDER BY 1;

-- STANDARDIZATION OF DATE -- TXT TO STR
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y') AS std_date
 FROM layoffs_new2;

UPDATE layoffs_new2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

SELECT `date` FROM layoffs_new2
ORDER BY 1;

ALTER TABLE layoffs_new2 
MODIFY COLUMN `date` DATE;

SELECT * FROM layoffs_new2;

DESCRIBE layoffs_new2;

-- DEALING WITH NULL OR BLANK VALUES eg NULL --
SELECT * FROM layoffs_new2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
ORDER BY company;

SELECT * FROM layoffs_new2
WHERE industry IS NULL 
OR industry = '';

SELECT * FROM layoffs_new2
WHERE company LIKE 'Áirbnb';
-- SELF JOIN --
SELECT t1.industry,t2.industry
FROM layoffs_new2 t1
JOIN layoffs_new2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
WHERE ( t1.industry IS  NULL OR t1.industry = '' )  
AND t2.industry IS NOT NULL;
-- UPDATING SPACE INTO A NULL FOR EFFICIENCY--
UPDATE layoffs_new2 
SET industry = NULL 
WHERE industry = '';

UPDATE layoffs_new2 t1 
JOIN layoffs_new2 t2
    ON t1.company = t2.company
    SET t1.industry = t2.industry
    WHERE ( t1.industry IS  NULL ) 
    AND t2.industry IS NOT NULL;
    
    

-- REMOVING ANY TRIVIAL COLUMNS --
SELECT * FROM layoffs_new2;

DELETE 
FROM layoffs_new2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_new2
DROP COLUMN row_num;

-- END OF DATA CLEANING PROJECT,,ON TO THE NEXT--