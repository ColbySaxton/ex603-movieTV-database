-- 4.1

-- the count, total, average, minimum, and maximum of ratings, and how many distinct users have rated movies. REQ: SELECT, FROM, MIN, MAX, COUNT, SUM, DISTINCT
SELECT 
    MIN(score), 
    MAX(score), 
    COUNT(rating_id), 
    SUM(score), 
    COUNT(DISTINCT(user_id)) AS distinct_users 
FROM ratings;

-- the ratings count and average metric for each movie. Results are sorted from the movie with the most events to the movie with the fewest. REQ: SELECT, FROM, GROUP BY, ORDER BY
SELECT 
    COUNT(*) AS total_ratings_for_movie, 
    AVG(score) as average_score_for_movie, 
    movie_id 
FROM ratings 
GROUP BY movie_id 
ORDER BY total_ratings_for_movie DESC;

-- This query returns the total number of ratings and the average score for each movie, but only for movies that have more than 9 ratings. The results are ordered by the total number of ratings in descending order. 9 was chosen
-- Because most of the movies had more than 9 ratings and only one has less than 9. One or two outlier reviews can significantly skew an average for a total under 10, so a 10 rating cutoff was chosen.
SELECT 
    COUNT(*) AS total_ratings_for_movie, 
    AVG(score) as average_score_for_movie, 
    movie_id 
FROM ratings 
GROUP BY movie_id 
HAVING COUNT(*) > 9 
ORDER BY total_ratings_for_movie DESC;

-- The ratings count and average metric for each movie by the country where the rating was scored from. REQ: SELECT, FROM, GROUP BY, ORDER BY
SELECT 
    COUNT(*) AS total_ratings_for_movie_by_region, 
    AVG(score) as average_score_for_movie_by_region, 
    movie_id, 
    device_country 
FROM ratings 
GROUP BY movie_id, device_country 
ORDER BY device_country DESC;


