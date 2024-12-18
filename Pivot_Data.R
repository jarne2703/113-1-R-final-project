library(tidyr)

pivoted_data <- tidy_movie |>
  tidyr::pivot_longer(
    cols = c(`opening_weekend_box_office_sales`, `total_worldwide_gross_sales`, 
             `rotten_tomatoes_rating`, `imdb_rating`),
    names_to = "metric",
    values_to = "value"
  )

glimpse(pivoted_data)