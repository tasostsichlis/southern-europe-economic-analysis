USE southern_europe_economy;

CREATE TABLE unemployment_raw (
    country_name VARCHAR(150),
    country_code VARCHAR(10),
    indicator_name VARCHAR(150),
    indicator_code VARCHAR(50),
    year SMALLINT,
    unemployment VARCHAR(50)
);

SELECT *
FROM unemployment_raw
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM unemployment_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM unemployment_raw  ;

CREATE TABLE unemployment_clean AS
SELECT *
FROM unemployment_raw
WHERE country_code IN ('GRC', 'ITA', 'ESP', 'PRT')
  AND year BETWEEN 2000 AND 2024;

SELECT * FROM unemployment_clean
WHERE unemployment IS NULL
OR TRIM(unemployment) = ''
OR UPPER(TRIM(unemployment)) = 'NA';

DELETE FROM unemployment_clean 
WHERE unemployment IS NULL
   OR TRIM(unemployment) = ''
   OR UPPER(TRIM(unemployment)) = 'NA';

ALTER TABLE unemployment_clean
MODIFY COLUMN unemployment DECIMAL(10, 4);

DESCRIBE unemployment_clean;

ALTER TABLE unemployment_clean
DROP COLUMN indicator_name,
DROP COLUMN indicator_code;

SELECT
    country_code,
    year,
    COUNT(*) AS row_count
FROM unemployment_clean
GROUP BY country_code, year
HAVING COUNT(*) > 1;

ALTER TABLE unemployment_clean
ADD PRIMARY KEY (country_code, year);

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM unemployment_clean;