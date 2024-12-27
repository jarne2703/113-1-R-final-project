library(tidyverse)

pixar_movies <- read_csv("/cloud/project/pixar_movies.csv")
glimpse(pixar_movies)



any_missing <- any(is.na(pixar_movies))
print(any_missing) 



tidy_movie <- pixar_movies %>%
  rename(
    movie_name = `movie`,
    director_name = `director`,
    writer_name = `writer`,
  )

glimpse(tidy_movie)



distinct_values <- tidy_movie %>%
  distinct(movie_rating)

print(distinct_values)



tidy_movie <- tidy_movie %>%
  mutate(movie_rating = factor(movie_rating, levels = c("G", "PG"), ordered = TRUE))

tidy_movie <- tidy_movie %>%
  select(-year_released)

glimpse(tidy_movie)



tidy_movie <- tidy_movie %>%
  mutate(
    rotten_tomatoes_rating = as.numeric(str_remove(rotten_tomatoes_rating, "%")),
    imdb_rating = as.numeric(str_remove(imdb_rating, "/10"))
  )

glimpse(tidy_movie)



print(min(tidy_movie$length_min))
print(mean(tidy_movie$length_min))
print(max(tidy_movie$length_min))



comedy_movies <- tidy_movie %>%
  filter(str_detect(movie_genre, "Comedy")) 

result <- comedy_movies %>%
  summarise(
    mean_length = mean(length_min, na.rm = TRUE), 
    max_length = max(length_min, na.rm = TRUE), 
    min_length = min(length_min, na.rm = TRUE),
    movie_count = n()
  )

print(result)



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




ordered_comedy_movies <- comedy_movies %>%
  select(movie_name, length_min, rotten_tomatoes_rating, imdb_rating) %>% 
  mutate(
    imdb_rating = imdb_rating * 10,  
    combined_rating = (rotten_tomatoes_rating + imdb_rating) / 2  
  ) %>%
  filter(length_min <= 100) %>% 
  arrange(desc(combined_rating))  

print(ordered_comedy_movies)



pivoted_comedy_movies <- ordered_comedy_movies %>%
  pivot_longer(
    cols = c(length_min, rotten_tomatoes_rating, imdb_rating),
    names_to = "rating_type", 
    values_to = "rating_value" 
  )

print(pivoted_comedy_movies)


