USE southern_europe_economy;

CREATE TABLE inflation_raw (
    country_name VARCHAR(150),
    country_code VARCHAR(10),
    indicator_name VARCHAR(150),
    indicator_code VARCHAR(50),
    year SMALLINT,
    inflation VARCHAR(50)
);

SELECT *
FROM inflation_raw
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM inflation_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM inflation_raw  ;

CREATE TABLE inflation_clean AS
SELECT *
FROM inflation_raw
WHERE country_code IN ('GRC', 'ITA', 'ESP', 'PRT')
  AND year BETWEEN 2000 AND 2024;

SELECT * FROM inflation_clean
WHERE inflation IS NULL
OR TRIM(inflation) = ''
OR UPPER(TRIM(inflation)) = 'NA';

DELETE FROM inflation_clean 
WHERE inflation IS NULL
   OR TRIM(inflation) = ''
   OR UPPER(TRIM(inflation)) = 'NA';

ALTER TABLE inflation_clean
MODIFY COLUMN inflation DECIMAL(10, 4);

DESCRIBE inflation_clean;

ALTER TABLE inflation_clean
DROP COLUMN indicator_name,
DROP COLUMN indicator_code;

SELECT
    country_code,
    year,
    COUNT(*) AS row_count
FROM inflation_clean
GROUP BY country_code, year
HAVING COUNT(*) > 1;

ALTER TABLE inflation_clean
ADD PRIMARY KEY (country_code, year);

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM inflation_clean;