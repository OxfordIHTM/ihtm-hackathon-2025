library(sf)

# Index of Multiple Deprivation ------------------------------------------------

## Read shapefile of England ----
library(sf)

## download and read data ----
source("01_read_data.R")

## process data ----
source("02_process_data.R")
imd

colnames(imd)

#Creating tables
summary(imd $imd_decile)
library(dplyr)

#Filter for selected variables with values less than 3
imd_filtered <- imd %>%
  filter(employment_decile == 1,
         income_decile == 1,
         education_decile == 1) %>%
  select(employment_decile, income_decile, education_decile)

#Print the table
print(imd_filtered)
