CREATE VIEW economic_indicators AS
SELECT
    g.country_name,
    g.country_code,
    g.year,
    g.gdp_growth,
    i.inflation,
    u.unemployment
FROM gdp_clean AS g
JOIN inflation_clean AS i
    ON g.country_code = i.country_code
   AND g.year = i.year
JOIN unemployment_clean AS u
    ON g.country_code = u.country_code
   AND g.year = u.year;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_code) AS total_countries,
    MIN(year) AS first_year,
    MAX(year) AS last_year
FROM economic_indicators;