
-- This query returns the ratings id, time rated, user name of the user rating the movie and the name of the movie they are rating.
SELECT
    ratings.rating_id,
    ratings.rated_at,
    users.user_name,
    movies.title
FROM ratings
INNER JOIN users ON ratings.user_id = users.user_id
INNER JOIN movies ON ratings.movie_id = movies.movie_id;

-- This query returns movies names as well as their genre name grouped by the genres of each movie
SELECT
    movies.title,
    genres.genre_name
FROM movies
INNER JOIN movie_genres ON movie_genres.movie_id = movies.movie_id
INNER JOIN genres ON movie_genres.genre_id = genres.genre_id
GROUP BY movies.title, genres.genre_name;

-- This query returns movie names compared to one another when they have the same genre. It also shared the number of ratings for each comparison and the average score of each compared to one another.
WITH movie_activity AS (
    SELECT
        movie_id,
        COUNT(*)            AS rating_count,
        ROUND(AVG(score), 2) AS avg_score
    FROM ratings
    GROUP BY movie_id
)


SELECT
    g.genre_name AS shared_genre,
    a.title AS movie_a,
    b.title AS movie_b,
    ma.rating_count  AS a_ratings,
    mb.rating_count  AS b_ratings,
    ma.avg_score     AS a_avg,
    mb.avg_score     AS b_avg
FROM movies a
INNER JOIN movie_genres ag ON a.movie_id = ag.movie_id
INNER JOIN genres g ON ag.genre_id = g.genre_id
INNER JOIN movies b ON a.movie_id <> b.movie_id
INNER JOIN movie_genres bg ON b.movie_id = bg.movie_id AND ag.genre_id = bg.genre_id
INNER JOIN genres g2 ON bg.genre_id = g2.genre_id
INNER JOIN movie_activity ma ON ma.movie_id = a.movie_id
INNER JOIN movie_activity mb ON mb.movie_id = b.movie_id
ORDER BY a.title, g.genre_name, mb.rating_count DESC;
