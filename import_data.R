library(tidyverse)

pixar_movies <- read_csv("/cloud/project/pixar_movies.csv")

tidy_movie <- pixar_movies %>%
  rename(
    movie_name = `movie`,
    director_name = `director`,
    writer_name = `writer`,
  )


tidy_movie <- tidy_movie %>%
  mutate(movie_rating = factor(movie_rating, levels = c("G", "PG"), ordered = TRUE))