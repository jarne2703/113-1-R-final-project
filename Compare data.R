tidy_movie %>%
  ggplot(aes(x = year_released, y = length_min)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Movie Length Over Time",
    x = "Year Released",
    y = "Movie Length (minutes)"
  )

tidy_movie %>%
  separate_rows(movie_genre, sep = ", ") %>%  
  count(movie_genre, sort = TRUE) %>%
  ggplot(aes(x = reorder(movie_genre, n), y = n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Number of Movies by Genre",
    x = "Genre",
    y = "Number of Movies"
  )