
-- Left Join to return all movies and their matched ratings. Includes movies without ratings.
SELECT
    movies.title,
    movies.movie_id,
    ratings.score,
    ratings.rated_at,
    ratings.rating_id
FROM movies
LEFT JOIN ratings ON movies.movie_id = ratings.movie_id
GROUP BY movies.movie_id, ratings.score, ratings.rated_at, ratings.rating_id;

-- Inner Join to return all movies and their matched ratings. Does not include movies without ratings.
SELECT
    movies.title,
    movies.movie_id,
    ratings.score,
    ratings.rated_at,
    ratings.rating_id
FROM movies
INNER JOIN ratings ON movies.movie_id = ratings.movie_id
GROUP BY movies.movie_id, ratings.score, ratings.rated_at, ratings.rating_id;

-- Right Join to return all ratings and their matched movies. Includes ratings without movies.
SELECT
    movies.title,
    movies.movie_id,
    ratings.score,
    ratings.rated_at,
    ratings.rating_id
FROM movies
RIGHT JOIN ratings ON movies.movie_id = ratings.movie_id
GROUP BY movies.movie_id, ratings.score, ratings.rated_at, ratings.rating_id;
-- Results of the above query differs by 2 entries (204 vs 206) from the above lefty join query.

-- Full outer join to return all movies and all ratings, regardless of whether they have a match in the other table. This will include movies without ratings and ratings without movies.
SELECT
    movies.title,
    movies.movie_id,
    ratings.score,
    ratings.rated_at,
    ratings.rating_id
FROM movies
FULL OUTER JOIN ratings ON movies.movie_id = ratings.movie_id
GROUP BY movies.movie_id, ratings.score, ratings.rated_at, ratings.rating_id;
-- A Full outer join can reveal all movies that do not have a corresponding rating, all ratings that do not have a corresponding movie, and all movies that have a corresponding rating. This is useful for identifying gaps in the data and ensuring that all relevant information is captured.

-- Exclusion query to return all movies that do not have any ratings. This is done by using a NOT EXISTS clause to filter out movies that have a matching entry in the ratings table.
SELECT
    movies.title,
    movies.movie_id
FROM movies
WHERE NOT EXISTS (
    SELECT 1
    FROM ratings
    WHERE ratings.movie_id = movies.movie_id
);

-- Exclusion query to return all movies that do not have any ratings. This is done by using an EXCEPT clause to filter out movies that have a matching entry in the ratings table.
SELECT
    movies.movie_id
FROM movies
EXCEPT
SELECT
    ratings.movie_id
FROM ratings;

-- These above two approaches each return the same two movies that do not have ratings. However, the first query uses a NOT EXISTS check with is able to handle null values of the table it is comparing against. The except approach can also handle null values as it is able to match nulls between the two tables. However, it is limited in that you
-- cannot have a different amount of columns in the two tables being compared. The NOT EXISTS approach is more flexible in that it can handle different numbers of columns and can also be used with subqueries.