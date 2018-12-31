## Ryan Elmore
## 31 Dec 2018
## Initial look at the whiskey DB

library(tidyverse)
library(janitor)

df <- read_csv("data/Meta-Critic-Whisky Database–Selfbuilts-Whisky-Analysis.csv") %>%
  clean_names()

df <- within(df, 
             new_country <- factor(country,
                                   levels = names(sort(table(country),
                                                       decreasing = FALSE))))
p <- ggplot(data = filter(df, new_country != "NA"), 
            aes(x = new_country))

p + geom_bar() +
  coord_flip() +
  scale_y_log10() +
  labs(x = "country") +
  theme_bw()

## Average rating by country

p <- ggplot(data = df %>%
              filter(country %in% c("Scotland", "USA", "Canada", "Ireland",
                                    "Japan", "Sweden", "India", "Taiwan")), 
            aes(x = meta_critic, 
                fill = country))
p + geom_density() +
  facet_wrap(~ country, nrow = 2) +
  scale_fill_brewer("", palette = "Dark2") +
  labs(x = "country") +
  theme_bw()
