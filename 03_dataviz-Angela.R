# Create a table of most deprived 10% of neighbourhoods nationally by the number of domains ----
# on which they are also in the most deprived decile ----

most_deprived <- imd %>%
  filter(imd_decile == 1) %>%
  mutate(
    income_decile_1 = ifelse(income_decile == 1, 1, 0),
    employment_decile_1 = ifelse(employment_decile == 1, 1, 0),
    education_decile_1 = ifelse(education_decile == 1, 1, 0),
    health_decile_1 = ifelse(health_decile == 1, 1, 0),
    crime_decile_1 = ifelse(crime_decile == 1, 1, 0),
    housing_decile_1 = ifelse(housing_decile == 1, 1, 0),
    environment_decile_1 = ifelse(environment_decile == 1, 1, 0),
  n_domain = (income_decile_1 + employment_decile_1 + education_decile_1 + health_decile_1 +
    crime_decile_1 + housing_decile_1 + environment_decile_1
  ) %>%
  factor(levels = 1:7)
) %>%
  count(n_domain, .drop = FALSE) %>%
  arrange(desc(n_domain)) %>%
  mutate(
    prop_n_domain = n / sum(n),
  cumsum_prop_n_domain = cumsum(prop_n_domain)
  )
most_deprived
#most_deprived_table <- as.data.frame(most_deprived)

#for filter() <- put the inclusion criteria inside of the ()
#mutate() can help create a new variable or change its name/value 

# Deprivation by local authority 
imd_35 <- imd %>%
filter(imd_decile == 1) %>%
  group_by(lad_name_2019) %>%
  mutate(sum = sum(n)) %>%
    arrange(desc(n_domain))
View(imd_35)

  mutate(
    Total_Neighbourhoods = n(),
    Most_Deprived_Neighbourhoods = sum(imd_decile == 1, na.rm = TRUE),  # Count deprived neighborhoods
    Proportion_Deprived = Most_Deprived_Neighbourhoods / Total_Neighbourhoods  # Compute proportion
  ) %>%
  ungroup() %>%
  distinct(lad_name_2019, .keep_all = TRUE) %>%  # Keep one row per LAD
  arrange(desc(Proportion_Deprived)) %>%
  slice(1:20)  # Select top 20 LADs

deprived_lad
