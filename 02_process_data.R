# Process datasets -------------------------------------------------------------

## Process IMD dataset ----

### Tidy up and simplify variable names ----
names(imd) <- c(
  "lsoa_code_2011", "lsoa_name_2011", "lad_code_2019", "lad_name_2019", 
  "imd_score", "imd_rank", "imd_decile", 
  "income_score", "income_rank", "income_decile",
  "employment_score", "employment_rank", "employment_decile",
  "education_score", "education_rank", "education_decile",
  "health_score", "health_rank", "health_decile",
  "crime_score", "crime_rank", "crime_decile",
  "housing_score", "housing_rank", "housing_decile",
  "environment_score", "environment_rank", "environment_decile",
  "income_children_score", "income_children_rank", "income_children_decile",
  "income_older_score", "income_older_rank", "income_older_decile",
  "children_subdomain_score", "children_subdomain_rank", "children_subdomain_decile",
  "adult_subdomain_score", "adult_subdomain_rank", "adult_subdomain_decile",
  "geo_barriers_subdomain_score", "geo_barriers_subdomain_rank", "geo_barriers_subdomain_decile",
  "wide_barriers_subdomain_score", "wide_barriers_subdomain_rank", "wide_barriers_subdomain_decile",
  "indoors_subdomain_score", "indoors_subdomain_rank", "indoors_subdomain_decile",
  "outdoors_subdomain_score", "outdoors_subdomain_rank", "outdoors_subdomain_decile",
  "pop_2015", "pop_0_15_2015", "pop_16_59_2015", "pop_60_over_2015", "pop_18_59_2015"  
)
