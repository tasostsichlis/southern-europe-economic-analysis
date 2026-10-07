USE southern_europe_economy;

SELECT
    country_name,
    ROUND(AVG(gdp_growth), 2) AS avg_gdp_growth,
    ROUND(AVG(inflation), 2) AS avg_inflation,
    ROUND(AVG(unemployment), 2) AS avg_unemployment
FROM economic_indicators
GROUP BY country_name
ORDER BY avg_gdp_growth DESC;

-- Average indicators by year across the four countries
SELECT
    year,
    ROUND(AVG(gdp_growth), 2) AS avg_gdp_growth,
    ROUND(AVG(inflation), 2) AS avg_inflation,
    ROUND(AVG(unemployment), 2) AS avg_unemployment
FROM economic_indicators
GROUP BY year
ORDER BY year;

-- Ten largest GDP contractions
SELECT
    country_name,
    year,
    gdp_growth
FROM economic_indicators
ORDER BY gdp_growth ASC
LIMIT 10;

-- Ten highest GDP growth observations
SELECT
    country_name,
    year,
    gdp_growth
FROM economic_indicators
ORDER BY gdp_growth DESC
LIMIT 10;

-- Ten highest inflation observations
SELECT
    country_name,
    year,
    inflation
FROM economic_indicators
ORDER BY inflation DESC
LIMIT 10;

-- Ten highest unemployment observations
SELECT
    country_name,
    year,
    unemployment
FROM economic_indicators
ORDER BY unemployment DESC
LIMIT 10;

-- Compare economic indicators across major periods
SELECT
    country_name,
    CASE
        WHEN year BETWEEN 2000 AND 2007 THEN 'Pre-crisis (2000-2007)'
        WHEN year BETWEEN 2008 AND 2013 THEN 'Financial crisis (2008-2013)'
        WHEN year BETWEEN 2014 AND 2019 THEN 'Recovery (2014-2019)'
        WHEN year = 2020 THEN 'Pandemic (2020)'
        ELSE 'Post-pandemic (2021-2024)'
    END AS economic_period,
    ROUND(AVG(gdp_growth), 2) AS avg_gdp_growth,
    ROUND(AVG(inflation), 2) AS avg_inflation,
    ROUND(AVG(unemployment), 2) AS avg_unemployment
FROM economic_indicators
GROUP BY country_name, economic_period
ORDER BY country_name, MIN(year);

-- Rank countries by GDP growth within each year
SELECT
    country_name,
    year,
    gdp_growth,
    RANK() OVER (
        PARTITION BY year
        ORDER BY gdp_growth DESC
    ) AS gdp_rank
FROM economic_indicators
ORDER BY year, gdp_rank;

-- Three-year moving average of GDP growth
SELECT
    country_name,
    year,
    gdp_growth,
    ROUND(
        AVG(gdp_growth) OVER (
            PARTITION BY country_code
            ORDER BY year
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS gdp_3_year_moving_avg
FROM economic_indicators
ORDER BY country_name, year;