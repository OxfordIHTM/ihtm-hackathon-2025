library(ggplot2)
library(dplyr)
library(ggpubr)
library(tidyverse)
#imd_map_data <- england %>%
  #left_join(imd, by = "lsoa11cd")

# create a table of most deprived 10% of neighbourhoods nationally based 
# on IMD2019 by the number of domains on which they are also in the most deprived decile

imd_30 <- imd %>% select("imd_score", "imd_decile", "employment_decile", "education_decile", "health_decile", "housing_decile", "environment_decile","income_older_decile", "income_children_decile") %>% 
  filter(imd_decile == 1) %>% 
  add_count(employment_decile == 1))

imd_30 <- imd |>
  filter(imd_decile == 1) |>
  mutate(
    income_decile_1 = ifelse(income_decile == 1, 1, 0),
    employment_decile_1 = ifelse(employment_decile == 1, 1, 0),
    education_decile_1 = ifelse(education_decile == 1, 1, 0),
    health_decile_1 = ifelse(health_decile == 1, 1, 0),
    housing_decile_1 = ifelse(housing_decile == 1, 1, 0),
    environment_decile_1 = ifelse(environment_decile == 1, 1, 0),
    crime_decile_1 = ifelse(crime_decile == 1, 1, 0),
    n_domain = (income_decile_1 + employment_decile_1 + education_decile_1 + health_decile_1 + housing_decile_1 + environment_decile_1 + crime_decile_1
  ) |>
  factor(levels = 1:7)
) |>
count(n_domain, .drop = FALSE)|>
  mutate(prop_n_domain = n/sum(n),
         cumsum_prop_n_domain = cumsum(prop_n_domain))|>
  arrange(desc(n_domain))


# re-create the table on the 20 local authority districts with the highest proportion of neighbourhoods 
# in the most deprived 10 per cent of neighbourhoods nationally on the IMD 2019
imd_35 <- imd  %>% 
  filter(imd_decile == 1)  %>% group_by(lad_name_2019) %>% 
  count(lad_name_2019) %>% 
    
  
  
  
  
    ) |>
      factor(levels = 1:20)
  ) |>
  count(n_domain, .drop = FALSE)|>
  mutate(prop_n_domain = n/sum(n),
         cumsum_prop_n_domain = cumsum(prop_n_domain))|>
  arrange(desc(n_domain))

  
  

devtools::install_github("r-lib/conflicted")



  imd_summary <- imd %>% group_by(lad_name_2019) %>% 
    summarise(imd_score = mean(imd_score),
              imd_decile = mean(imd_decile),
              income_score = mean(income_score)) %>% 
    arrange(desc(imd_score))