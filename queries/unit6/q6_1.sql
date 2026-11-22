
-- 6.1 Part 1: Comparing each event to its producer's average. Shows if an event is unusually good or bad. In this case, we are comparing each movie's rating to the average rating for that movie.
SELECT
    movie_id,
    score,
    AVG(score) OVER (PARTITION BY movie_id) AS avg_score
FROM
    ratings;

-- Finding the producer's average score for each event using group by. This does not show the average compared to the score of the particular record, it only shows the aggregate row.
SELECT 
    movie_id, 
    AVG(score) AS avg_score
FROM ratings
GROUP BY movie_id;

-- 6.1 Part 2: Ranking producers 3 ways by the number of ratings they have received. This is done by using the COUNT() function to count the number of ratings for each movie, and then using the ROW_NUMBER(), RANK(), and DENSE_RANK() window functions to assign a rank to each movie based on the number of ratings they have received. The results are ordered by movie_id.
SELECT
    movie_id,
    COUNT(*) AS num_ratings,
    AVG(score) AS avg_score,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_num,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS dense_rank
FROM ratings
GROUP BY movie_id
ORDER BY movie_id;

-- 6.1 Part 3: Ranking producers by the quartile of the number of ratings they have received. This is done by using the NTILE() window function to divide the movies into quartiles based on the number of ratings they have received. The results are ordered by quartile and movie_id.
SELECT
    movie_id,
    COUNT(*) as num_ratings,
    AVG(score) as avg_score,
    NTILE(4) OVER (ORDER BY COUNT(*) DESC) AS quartile
FROM ratings
GROUP BY movie_id
ORDER BY quartile, movie_id;

    