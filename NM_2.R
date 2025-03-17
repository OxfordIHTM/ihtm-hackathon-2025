#Explortory data analysis examples--------
# Load necessary libraries




# Check the column names in the imd dataset
print(names(imd))

## Recreate table in issue #30

table_1 <- imd |>
  filter(imd_decile == 1) |>
  mutate(
    income_decile_1 = ifelse(income_decile == 1, 1, 0),
    employment_decile_1 = ifelse(employment_decile == 1, 1, 0),
    education_decile_1 = ifelse(education_decile == 1, 1, 0),
    health_decile_1 = ifelse(health_decile == 1, 1, 0),
    crime_decile_1 = ifelse(crime_decile == 1, 1, 0),
    housing_decile_1 = ifelse(housing_decile == 1, 1, 0),
    environment_decile_1 = ifelse(environment_decile == 1, 1, 0),
    n_domain = income_decile_1 + employment_decile_1 + education_decile_1 + 
      health_decile_1 + crime_decile_1 + housing_decile_1 + environment_decile_1
  ) |>
  count(n_domain, .drop = FALSE) |>
  mutate(
    n_domain = factor(n_domain, levels = 1:7),
    prop_n_domain = n / sum(n),
    cumsum_prop_n_domain = cumsum(prop_n_domain)
  ) |>
  arrange(desc(n_domain))

#Table 2

#Calculate the Rank of Average Rank for each local authority

mean(imd$imd_rank)

imd |>
 
group_by(imd$lad_name_2019)
summarise(weighted_average_rank = weighted.mean(IMD_rank, population, na.rm = TRUE))
   mutate(rank = row_number(),
          top_ten = ifelse(rank <= 10, 1, 0))|>
  arrange(average_rank) |>
   |>
  filter(top_ten == 1) |>
  select(local_authority, average_rank, rank) |>
  arrange(rank)

