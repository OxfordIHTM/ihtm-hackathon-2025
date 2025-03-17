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
library(ggplot2)

#Scatter plot
ggplot(imd, aes(x = crime_score, y = income_children_score)) +
  geom_point(size=3) +
  labs(title = "Income children score vs. Crime score", 
       x = "Crime score", 
       y = "Income children Score",
       color= "income_children_score")