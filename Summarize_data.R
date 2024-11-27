summary_tidy_movie <- tidy_movie %>%
  group_by(movie_genre) %>%       # Group by genre
  summarize(
    movie_count = n(),      
    avg_rating = mean(imdb_rating, na.rm = TRUE), 
    .groups = "drop"        
  )


print(summary_tidy_movie)

glimpse(tidy_movie)