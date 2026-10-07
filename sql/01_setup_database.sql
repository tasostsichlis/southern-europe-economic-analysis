CREATE DATABASE IF NOT EXISTS southern_europe_economy;
USE southern_europe_economy;
CREATE TABLE gdp_raw (
    country_name VARCHAR(150),
    country_code VARCHAR(10),
    indicator_name VARCHAR(150),
    indicator_code VARCHAR(50),
    year SMALLINT,
    gdp_growth VARCHAR(50));

LOAD DATA LOCAL INFILE 
'C:/Users/tasos/Desktop/southern europe economy/data_processed/gdp_long.csv'
INTO TABLE gdp_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;