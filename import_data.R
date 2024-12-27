library(tidyverse)

pixar_movies <- read_csv("/cloud/project/pixar_movies.csv")

glimpse(pixar_movies)

tidy_movie <- pixar_movies %>%
  rename(
    movie_name = `movie`,
    director_name = `director`,
    writer_name = `writer`,
  )

glimpse(tidy_movie)

tidy_movie <- tidy_movie %>%
  mutate(movie_rating = factor(movie_rating, levels = c("G", "PG"), ordered = TRUE))

tidy_movie <- tidy_movie %>%
  select(-year_released)

glimpse(tidy_movie)
