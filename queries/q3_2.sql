--3.2a Added 4 additional records to the movie ratings table where their device country is null.

-- The following two queries were run to verify that the 4 records with device_country = NULL were not included in either query results.
SELECT movie_id, user_id, rating_id, device_country
FROM ratings
WHERE device_country != 'US';

-- Above query returned 162 out of 204 possible ratings records.

SELECT movie_id, user_id, rating_id, device_country
FROM ratings
WHERE device_country = 'US';

-- Above query returned 38 out of 204 possible ratings records. The 4 records whose device_country ABORT
-- is NULL were not included in the results of either query.

--FIRST QUERY REPAIRED: repaired to include a check on device_country field for values that are null to be
-- returned in additional to values that are not US.

SELECT movie_id, user_id, rating_id, device_country
FROM ratings
WHERE device_country IS NULL OR device_country != 'US';


-- 3.2b A query that defines an alias in the SELECT and references the ALIAS in the WHERE

SELECT movie_id, user_id, rating_id, COALESCE(device_country, 'Unknown') AS user_country
FROM ratings
WHERE user_country != 'India';

-- Above query returns this error: column "user_country" does not exist
-- Below query solves the problem by repeating the same expression in the WHERE clause.
SELECT movie_id, user_id, rating_id, COALESCE(device_country, 'Unknown') AS user_country
FROM ratings
WHERE COALESCE(device_country, 'Unknown') != 'India';

-- Below query solves the problem by creating a CTE new table that defines a null device country as unknown
-- and references a new field called user_country in the where clause.
WITH ratings_with_country AS (
    SELECT movie_id, user_id, rating_id,
           COALESCE(device_country, 'Unknown') AS user_country
    FROM ratings
)
SELECT movie_id, user_id, rating_id, user_country
FROM ratings_with_country
WHERE user_country != 'India';