USE southern_europe_economy;
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM gdp_raw;

CREATE TABLE gdp_clean AS
SELECT *
FROM gdp_raw
WHERE country_code IN ('GRC', 'ITA', 'ESP', 'PRT')
  AND year BETWEEN 2000 AND 2024;

SELECT * FROM gdp_clean
WHERE gdp_growth IS NULL
OR TRIM(gdp_growth) = ''
OR UPPER(TRIM(gdp_growth)) = 'NA';

DELETE FROM gdp_clean
WHERE gdp_growth IS NULL
   OR TRIM(gdp_growth) = ''
   OR UPPER(TRIM(gdp_growth)) = 'NA';

ALTER TABLE gdp_clean
MODIFY COLUMN gdp_growth DECIMAL(10, 4);

DESCRIBE gdp_clean;

ALTER TABLE gdp_clean
DROP COLUMN indicator_name,
DROP COLUMN indicator_code;

SELECT
    country_code,
    year,
    COUNT(*) AS row_count
FROM gdp_clean
GROUP BY country_code, year
HAVING COUNT(*) > 1;

ALTER TABLE gdp_clean
ADD PRIMARY KEY (country_code, year);

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM gdp_clean;