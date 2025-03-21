# Exploratory data analysis ----------------------------------------------------


## Map index of multiple deprviation as shown in page 6 ----

### Plot map using sf ----
plot(
  england["IMD_Decile"], 
  pal = rev(c("#FFFFFF", brewer.pal(n = 9, name = "YlGnBu"))),
  lty = 0, axes = TRUE, graticule = TRUE,
  main = "Distribution of the Index of Multiple Deprivation (IMD) 2019 by LSOA in England"
)

title(sub = "1 is most deprived and 10 is least deprived")

### Plot map using ggplot2 ----
england |>
  mutate(imd_decile_factor = factor(IMD_Decile, levels = 1:10)) |>
  ggplot(aes(fill = imd_decile_factor)) +
  geom_sf(linetype = 0) +
  scale_fill_manual(
    name = NULL,
    values = rev(c("#FFFFFF", RColorBrewer::brewer.pal(n = 9, name = "YlGnBu")))
  ) +
  annotation_scale(location = "br", width_hint = 0.5, pad_y = unit(0.5, "in")) +
  annotation_north_arrow(
    location = "tr", which_north = "true", 
    pad_x = unit(0.5, "in"), pad_y = unit(0.5, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  labs(
    title = "Distribution of the Index of Multiple Deprivation (IMD) 2019 by LSOA in England",
    subtitle = "1 is most deprived and 10 is least deprived"
  ) +
  theme_oxford()


## Table of most deprived 10% of neighbourhoods nationally based on IMD2019 ----
## by the number of domains on which they are also in the most deprived decile

imd |>
  filter(imd_decile == 1) |>
  select(
    income_decile, employment_decile, education_decile, health_decile,
    crime_decile, housing_decile, environment_decile
  ) |>
  mutate(
    across(
      .cols = income_decile:environment_decile,
      .fns = \(x) ifelse(x == 1, 1, 0),
      .names = "{.col}_most"
    ),
    n_domain = (income_decile_most + employment_decile_most + 
      education_decile_most + health_decile_most + crime_decile_most + 
      housing_decile_most + environment_decile_most) |>
      factor(levels = 1:7)
  ) |>
  count(n_domain, .drop = FALSE) |>
  arrange(desc(n_domain)) |>
  mutate(
    prop_lsoa = n / sum(n),
    cumsum_prop_lsoa = cumsum(prop_lsoa)
  )


## Rank of average rank ----

imd |>
  summarise(
    average_rank = weighted.mean(imd_rank, pop_2015), .by = lad_name_2019
  ) |>
  slice_min(average_rank, n = 10)


## Rank of average score ----

imd |>
  summarise(
    average_score = weighted.mean(imd_score, pop_2015), .by = lad_name_2019
  ) |>
  slice_max(average_score, n = 10)


## Rank based on proportion of most deprived LSOA in local authority ----

imd |>
  mutate(most_deprived = ifelse(imd_decile == 1, 1, 0)) |>
  summarise(prop_most_deprived = mean(most_deprived), .by = lad_name_2019) |>
  slice_max(prop_most_deprived, n = 10)

## Map of distribution of IMD 2019 proportion of neighbourhoods in most ----
## deprived decile in a local authority area

merge(
  x = england,
  y = imd |>
    select(lsoa_code_2011, lad_name_2019, imd_decile) |>
    mutate(most_deprived = ifelse(imd_decile == 1, 1, 0)) |>
    group_by(lad_name_2019) |>
    mutate(prop_most_deprived = mean(most_deprived)) |>
    ungroup(),
  by.x = "lsoa11cd", by.y = "lsoa_code_2011"
) |>
  ggplot(aes(fill = prop_most_deprived)) +
  geom_sf(linetype = 0) + 
  scale_fill_viridis_c(direction = -1, option = "viridis") +
  #scale_fill_gradientn(name = NULL, colours = RColorBrewer::brewer.pal(n = 9, name = "YlGnBu")) +
  annotation_scale(location = "br", width_hint = 0.5, pad_y = unit(0.5, "in")) +
  annotation_north_arrow(
    location = "tr", which_north = "true", 
    pad_x = unit(0.5, "in"), pad_y = unit(0.5, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  labs(
    title = "Distribution of the Index of Multiple Deprivation (IMD) 2019 by local authority",
    subtitle = "Based on the proportion of their neighbourhoods in the most deprived decile nationally"
  ) +
  theme_oxford()
