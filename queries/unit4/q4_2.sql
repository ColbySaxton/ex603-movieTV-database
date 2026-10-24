-- 4.2

-- the total number of ratings and the total number of ratings classified as failures for each movie. 
-- REQ: SELECT, FROM, GROUP BY, ORDER BY
SELECT
    COUNT(*) as total_count, 
    SUM(CASE rating_status WHEN 'published' THEN 0 ELSE 1 END) as failure_count, 
    movie_id 
FROM ratings 
GROUP BY movie_id 
ORDER BY total_count DESC;


-- The subtotals of ratings per region and a platform grand total of ratings.
-- REQ: SELECT, FROM, GROUP BY, ROLLUP
SELECT 
    CASE WHEN GROUPING(device_country) = 1 THEN 'Grand Total' ELSE device_country::TEXT END AS region,
    COUNT(*) AS total_ratings
FROM ratings
GROUP BY ROLLUP(device_country);


-- Returns the total number of ratings for each movie that has more ratings than the average number 
-- of ratings per movie. The average is calculated using a subquery that counts the total number of ratings for 
-- each movie and then averages those counts. The main query then filters the results to only include movies with a 
-- total rating count greater than the average. The results are ordered by the total number of ratings in descending order.
-- REQ: SELECT, FROM, GROUP BY, ORDER BY, CROSS JOIN, SUBQUERY
WITH movie_ratings_count AS (
    SELECT
        movie_id,
        COUNT(*) AS total_ratings
    FROM ratings
    GROUP BY movie_id
),
avg_count AS (
    SELECT
        AVG(total_ratings) AS avg_ratings_per_movie
    FROM movie_ratings_count
)
SELECT
    m.movie_id,
    m.total_ratings,
    ROUND(a.avg_ratings_per_movie, 1) AS avg_ratings_per_movie
FROM movie_ratings_count m
CROSS JOIN avg_count a
WHERE m.total_ratings > a.avg_ratings_per_movie
ORDER BY m.total_ratings DESC;