-- 3.1a Active, highly rated titles — the producers whose records
--    anchor the audit. Req: SELECT, FROM, INNER JOIN, ON, GROUP BY, ORDER BY, LIMIT

SELECT ratings.movie_id, AVG(ratings.score) AS avg_score, movies.title
FROM ratings
INNER JOIN movies
ON ratings.movie_id = movies.movie_id
GROUP BY ratings.movie_id, movies.title
ORDER BY avg_score DESC
LIMIT 10;

-- 3.1b Ratings Statuses - The different statuses of the event of this schema.
-- Req: SELECT, FROM

SELECT DISTINCT rating_status 
FROM ratings;

-- 3.1c Ratings filters - Filter the ratings first by all ratings where the user's watch_minutes
-- minutes were over 10 minutes, Req: SELECT, FROM, WHERE. Second, filter the ratings by the device
-- country being within the list of countries ('US', 'UK'), Req: SELECT, FROM, WHERE
SELECT watch_minutes, score, rating_id, user_id, movie_id 
FROM ratings 
WHERE watch_minutes > 10;

SELECT device_country, score, rating_id, user_id, movie_id
FROM ratings
WHERE device_country IN ('US', 'UK');

-- 3.1d Movies pattern matching/null checking -  Find all movies whose names matches the text pattern '0'
-- Find all users and if the user is not invited by another user, set its invited by field to -1.
-- Req: SELECT, FROM, WHERE
SELECT movie_id, title
FROM movies
WHERE title LIKE '%0%';

SELECT user_id, user_name, COALESCE(invited_by, -1)
FROM users;

-- 3.1e Calculated/Compound Columns - Find all movies and assign each an era where any movie release before
-- 2000 is a classic, from 2000-2010 is 2010s, 2010-2020 is 2010s and 2020 on is 2020s. Req: SELECT, FROM
-- Find all ratings and update the scoring from a 0-5 scale to a 0-100 scale and return the new score as the
-- score out of 100. Req: SELECT, FROM
SELECT movie_id, title,
    CASE
        WHEN movies.release_year < 2000 THEN 'classics'
        WHEN movies.release_year < 2010 THEN '2000s'
        WHEN movies.release_year < 2020 THEN '2010s'
        ELSE '2020s'
    END AS era
FROM movies;

SELECT rating_id, user_id, movie_id, score * 20 AS score_out_of_100
FROM ratings;