
-- Users involved in disputed event where device country was null and they were not included in
-- query checking for all users whose country was not the US.
SELECT user_id, user_name
FROM users
WHERE user_id IN (SELECT user_id
              FROM ratings
              WHERE device_country IS NULL);

-- Above table returned: 
-- 15	User_15
-- 14	User_14
-- 8	User_08
-- 2	User_02

WITH users_without_country AS (
    SELECT user_id
    FROM ratings
    WHERE device_country IS NULL
)

SELECT user_id, user_name
FROM users
WHERE user_id IN (SELECT user_id FROM users_without_country);

-- Above table returned: 
-- 15	User_15
-- 14	User_14
-- 8	User_08
-- 2	User_02

WITH ratings_no_null AS (
    SELECT movie_id, user_id, rating_id,
        CASE
            WHEN device_country IS NULL THEN 'Unknown'
            ELSE device_country
        END AS user_country
    FROM ratings
)

SELECT user_id, user_name
FROM users
WHERE user_id IN (SELECT user_id FROM ratings_no_null WHERE user_country = 'Unknown');

-- Above table returned: 
-- 15	User_15
-- 14	User_14
-- 8	User_08
-- 2	User_02

-- Input condition under which the three would not be equivalent:
-- I genuinely cannot think of a scenario where the above 3 queries would not return the same results.
-- They each do an IS NULL check on the same field and that is the only real logic check being done in each.
-- Because that is the only source of logic, there is not a scenario where they would differ.