
-- 6.2 Part A: Row to row comparison. Displays the previous and next score for each rating of a specific movie (movie_id = 1), as well as the change in score from the previous rating. This is done using the LAG() and LEAD() window functions to access the previous and next rows in the partitioned data, ordered by the rated_at timestamp. The results are filtered to only include ratings for movie_id = 1 and are ordered by movie_id and rated_at.
SELECT
    movie_id,
    rated_at,
    score,
    LAG(score) OVER (PARTITION BY movie_id ORDER BY rated_at) AS prev_score,
    LEAD(score) OVER (PARTITION BY movie_id ORDER BY rated_at) AS next_score,
    score - LAG(score) OVER (PARTITION BY movie_id ORDER BY rated_at) AS score_change_from_prev
FROM ratings
WHERE movie_id = 1
ORDER BY movie_id, rated_at;

-- 6.2 Part B: Cumulative and rolling aggregates. Displays the cumulative watch minutes and the rolling 3-month average watch minutes for each month. This is done by first creating a Common Table Expression (CTE) to calculate the monthly watch minutes, and then using window functions to calculate the cumulative and rolling averages. The results are ordered by rating_month.
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', rated_at) AS rating_month,
        COUNT(*) AS ratings_count,
        SUM(watch_minutes) AS monthly_watch_minutes
    FROM ratings
    GROUP BY DATE_TRUNC('month', rated_at)
)

SELECT
    rating_month,
    monthly_watch_minutes,
    SUM(monthly_watch_minutes) OVER (
        ORDER BY rating_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_watch_minutes,
    AVG(monthly_watch_minutes) OVER (
        ORDER BY rating_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3mo_avg_watch_minutes
FROM monthly
ORDER BY rating_month;

-- 6.2 Part C: Finding gaps in the data. Displays the start and end dates of any gaps in the ratings data, as well as the number of missing days in each gap and the total number of missing days across all gaps. This is done by first creating a CTE to calculate the daily ratings totals, and then using window functions to calculate the previous date and the number of days since the previous date for each rating date. The results are filtered to only include gaps where there are missing days, and are ordered by gap_start.
WITH daily_ratings_totals AS (
    SELECT
        rated_at::date AS rated_date,
        COUNT(*)        AS daily_ratings_count
    FROM ratings
    GROUP BY rated_at::date
),
 
gaps AS (
    SELECT
        rated_date,
        LAG(rated_date) OVER (ORDER BY rated_date) AS prev_date,
        rated_date - LAG(rated_date) OVER (ORDER BY rated_date) AS days_since_prev
    FROM daily_ratings_totals
)
 
SELECT
    prev_date + 1 AS gap_start,
    rated_date - 1 AS gap_end,
    days_since_prev - 1 AS missing_days,
    SUM(days_since_prev - 1) OVER () AS total_missing_days
FROM gaps
WHERE days_since_prev > 1
ORDER BY prev_date + 1;
