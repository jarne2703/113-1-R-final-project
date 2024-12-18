library(dplyr)

summary_data <- tidy_movie |>
  dplyr::mutate(
    # Clean and convert opening_weekend_box_office_sales to numeric
    opening_weekend_box_office_sales_num = as.numeric(gsub("[^0-9\\.]", "", opening_weekend_box_office_sales)) * 
      ifelse(grepl("million", opening_weekend_box_office_sales), 1e6, 
             ifelse(grepl("billion", opening_weekend_box_office_sales), 1e9, 1)),
    
    # Clean and convert total_worldwide_gross_sales to numeric
    total_worldwide_gross_sales_num = as.numeric(gsub("[^0-9\\.]", "", total_worldwide_gross_sales)) * 
      ifelse(grepl("million", total_worldwide_gross_sales), 1e6, 
             ifelse(grepl("billion", total_worldwide_gross_sales), 1e9, 1))
  ) |>
  dplyr::mutate(
    # Check for NAs introduced during conversion and replace with 0 or NA
    opening_weekend_box_office_sales_num = ifelse(is.na(opening_weekend_box_office_sales_num), NA, opening_weekend_box_office_sales_num),
    total_worldwide_gross_sales_num = ifelse(is.na(total_worldwide_gross_sales_num), NA, total_worldwide_gross_sales_num)
  ) |>
  dplyr::group_by(movie_genre) |>
  dplyr::summarize(
    avg_length_min = mean(length_min, na.rm = TRUE),
    avg_opening_weekend_sales = mean(opening_weekend_box_office_sales_num, na.rm = TRUE),
    avg_total_worldwide_sales = mean(total_worldwide_gross_sales_num, na.rm = TRUE)
  ) |>
  dplyr::ungroup()

print(summary_data)
