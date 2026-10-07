getwd()
library(tidyverse)

gdp_raw<- read_csv("data_raw/raw_gdp_growth.csv",skip=4)
gdp_long<- pivot_longer(
  gdp_raw,cols='1960':'2025',names_to = "year",
  values_to = "gdp_growth")
gdp_long<- select(gdp_long,-`...71`)

inflation_raw<-read_csv("data_raw/raw_inflation.csv",skip=4)
inflation_long<- pivot_longer(
  inflation_raw,cols='1960':'2025',names_to = "year",
  values_to = "inflation")
inflation_long<- select(inflation_long,-`...71`)

unemployment_raw<-read_csv("data_raw/raw_unemployment.csv",skip=4)
unemployment_long<- pivot_longer(
  unemployment_raw,cols='1960':'2025',names_to = "year",
  values_to = "unemployment")
unemployment_long<- select(unemployment_long,-`...71`)

dir.create("data_processed", showWarnings = FALSE)
write_csv(gdp_long, "data_processed/gdp_long.csv")
write_csv(inflation_long, "data_processed/inflation_long.csv")
write_csv(unemployment_long, "data_processed/unemployment_long.csv")