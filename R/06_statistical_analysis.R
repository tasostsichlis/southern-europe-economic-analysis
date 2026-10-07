getwd()
list.files()
library(readr)

economic_data <- read_csv(
  "data/economic_indicators.csv",
  show_col_types = FALSE
)

View(economic_data)

library(dplyr)


economic_data <- group_by(economic_data, country_name)

economic_data <- mutate(economic_data,
                        unemployment_change = unemployment - lag(unemployment)
)

economic_data <- ungroup(economic_data)

View(economic_data)

model <- lm(
  unemployment_change ~ gdp_growth,
  data = economic_data
)

summary(model)

library(ggplot2)

regression_plot <- ggplot(
  economic_data,
  aes(
    x = gdp_growth,
    y = unemployment_change
  )
) +
  geom_point(
    aes(color = country_name),
    size = 2.5,
    alpha = 0.75,
    na.rm = TRUE
  ) +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "black",
    fill = "grey80",
    na.rm = TRUE
  ) +
  labs(
    title = "GDP Growth and Annual Change in Unemployment",
    subtitle = "Southern Europe, 2001–2024",
    x = "GDP growth (%)",
    y = "Annual change in unemployment (percentage points)",
    color = "Country",
    caption = "Source: World Bank"
  ) +
  theme_minimal()

regression_plot

ggsave(
  "images/regression_plot.png",
  plot = regression_plot,
  width = 10,
  height = 6,
  dpi = 300
)
regression_plot <- ggplot(
  economic_data,
  aes(
    x = gdp_growth,
    y = unemployment_change
  )
) +
  geom_point(
    aes(color = country_name),
    size = 2.5,
    alpha = 0.75,
    na.rm = TRUE
  ) +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "black",
    fill = "grey80",
    na.rm = TRUE
  ) +
  labs(
    title = "GDP Growth and Annual Change in Unemployment",
    subtitle = "Southern Europe, 2001–2024",
    x = "GDP growth (%)",
    y = "Annual change in unemployment (percentage points)",
    color = "Country",
    caption = "Source: World Bank"
  ) +
  theme_minimal()

