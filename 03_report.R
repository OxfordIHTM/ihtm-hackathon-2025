library(ggplot2)
library(dplyr)
library(ggpubr)

# Distribution of IMD Scores
ggplot(imd, aes(x = imd_score)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.6) +
  labs(title = "Distribution of IMD Scores", x = "IMD Score", y = "Frequency") +
  theme_bw()

# Distribution of Income Scores
ggplot(imd, aes(x = income_score)) + 
  geom_histogram(binwidth = 0.02, fill = "tan", color = "black", alpha = 0.7) + 
  labs(title = "Distribution of Income Scores", x = "Income Score (rate)", y = "Frequency") +
  theme_bw()

# Top 10 most and top 10 least deprived local authority districts
imd_summary <- imd %>% group_by(lad_name_2019) %>% 
imd_summary <- imd %>% group_by(lad_name_2019) %>% 
  summarise(imd_score = mean(imd_score),
            imd_decile = mean(imd_decile),
            income_score = mean(income_score)) %>% 
  arrange(desc(imd_score))

top_10 <- imd_summary %>% top_n(10, imd_score)
bottom_10 <- imd_summary %>% top_n(-10, imd_score)

p1 <- ggplot(top_10, aes(x = reorder(lad_name_2019, imd_score), y = imd_score, fill = imd_score)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = round(imd_score, digits = 1)), vjust = 0.5, hjust = 1.1) +
  coord_flip() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Top 10 Most Deprived Local Authorities", x = "Local Authority District", y = "IMD Score") +
  theme_bw()
p1
p2 <- ggplot(bottom_10, aes(x = reorder(lad_name_2019, imd_score), y = imd_score, fill = imd_score)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = round(imd_score, digits = 1)), vjust = 0.5, hjust = 1.1) +
  coord_flip() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Top 10 Least Deprived Local Authorities", x = "Local Authority District", y = "IMD Score") +
  theme_bw()
p2

ggarrange(p1, p2, ncol = 2, nrow = 2)
# Correlation Plot: Income Score vs IMD Score
ggplot(imd_summary, aes(x = income_score, y = imd_score)) +
  geom_point(alpha = 0.5, color = "darkblue") + 
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  theme_bw() +
  labs(title = "Income Score vs IMD Score", x = "Income Score", y = "IMD Score")

