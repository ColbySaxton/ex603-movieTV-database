

-- Cross join on ratings and users table, which yields 6,120 rows.
SELECT
    ratings.rating_id,
    ratings.rated_at,
    users.user_name
FROM ratings
CROSS JOIN users;
-- This query has 6,120 rows because it is a cross join between the ratings and users tables. The ratings table has 204 rows and the users table has 30 rows, so the total number of rows in the result set is 204 * 30 = 6,120. Each row in the ratings table is combined with every row in the users table, resulting in a Cartesian product of the two tables.
-- A cartesian product may be useful when needing to find all combinations between two small tables. It could indicate a query error if the user intended to join the tables on a specific column, but instead used a cross join. It could also be useful for generating test data or for creating a matrix of all possible combinations between two sets of data.

EXPLAIN
SELECT
    ratings.rating_id,
    ratings.rated_at,
    users.user_name,
    movies.title
FROM ratings
INNER JOIN users ON ratings.user_id = users.user_id
INNER JOIN movies ON ratings.movie_id = movies.movie_id;

-- Nested Loop  (cost=12.40..28.43 rows=204 width=532)
--  ->  Hash Join  (cost=12.25..17.85 rows=204 width=278)
--        Hash Cond: (ratings.user_id = users.user_id)
--        ->  Seq Scan on ratings  (cost=0.00..5.04 rows=204 width=24)
--        ->  Hash  (cost=11.00..11.00 rows=100 width=262)
--              ->  Seq Scan on users  (cost=0.00..11.00 rows=100 width=262)
--  ->  Memoize  (cost=0.15..0.41 rows=1 width=262)
--        Cache Key: ratings.movie_id
--        Cache Mode: logical
--        ->  Index Scan using movies_pkey on movies  (cost=0.14..0.40 rows=1 width=262)
--              Index Cond: (movie_id = ratings.movie_id)

-- This execution used a nested loop join to combine the ratings, users, and movies tables. The hash join was used to match ratings with users based on user_id.
-- Nested loop was used to combine the tables because the outer table is small with only 100 rows.
-- The hash join was used because the inner tables are unsorted and unindexed on the join column.
-- The nested loop join may become more inneficient as the size of the outer table increases, as it will have to scan the inner tables for each row in the outer table. In this case, the outer table is small enough that the nested loop join is efficient. 