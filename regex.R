#Movies filtered zith regex to only have movies containing an I in their title and the movies are all released after 2000
library(stringr)

glimpse(tidy_movie)

movies_filtered <- tidy_movie %>%
  filter(str_detect(year_released, "^2")) %>%
  filter(str_detect(movie_name, "i|I"))
 

glimpse(movies_filtered)


