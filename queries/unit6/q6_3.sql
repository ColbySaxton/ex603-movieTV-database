
-- 6.3 Part A: Top 3 movies per genre by average score.

WITH ranked AS (
    SELECT
        g.genre_name,
        m.title,
        AVG(r.score) AS avg_score,
        RANK() OVER (
            PARTITION BY g.genre_id
            ORDER BY AVG(r.score) DESC
        ) AS rnk,
        FIRST_VALUE(AVG(r.score)) OVER (
            PARTITION BY g.genre_id
            ORDER BY AVG(r.score) DESC
        ) AS top_score_in_genre
    FROM movies m
    JOIN ratings r ON r.movie_id = m.movie_id
    JOIN movie_genres mg ON mg.movie_id = m.movie_id
    JOIN genres g ON g.genre_id  = mg.genre_id
    GROUP BY g.genre_id, g.genre_name, m.title
)
SELECT
    genre_name,
    title,
    avg_score,
    rnk
FROM ranked
WHERE rnk <= 3
ORDER BY genre_name, rnk, title;

-- 6.3 Part B: Month over month percent change in average score and watch minutes.
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', rated_at) AS rating_month,
        COUNT(*) AS ratings_count,
        SUM(watch_minutes) AS monthly_watch_minutes,
        AVG(score) AS avg_score,
        SUM(CASE WHEN rating_status <> 'published' THEN 1 ELSE 0 END) AS failure_count
    FROM ratings
    GROUP BY DATE_TRUNC('month', rated_at)
)

SELECT
    rating_month,
    ratings_count,
    failure_count,
    ROUND(100.0 * failure_count / ratings_count, 1) AS failure_pct,
    LAG(failure_count) OVER (ORDER BY rating_month) AS prev_failure_count,
    ROUND(100.0 * (failure_count - LAG(failure_count) OVER (ORDER BY rating_month)) / NULLIF(LAG(failure_count) OVER (ORDER BY rating_month), 0), 1) AS percent_change_from_prev_failure_count,
    ROUND(avg_score, 2) AS avg_score,
    monthly_watch_minutes,
    avg_score,
    LAG(avg_score) OVER (ORDER BY rating_month) AS prev_avg_score,
    (avg_score - LAG(avg_score) OVER (ORDER BY rating_month)) / NULLIF((avg_score), 0) * 100 AS percent_change_from_prev_avg_score,
    LAG(monthly.monthly_watch_minutes) OVER (ORDER BY rating_month) AS prev_monthly_watch_minutes,
    (monthly_watch_minutes - LAG(monthly.monthly_watch_minutes) OVER (ORDER BY rating_month)) / NULLIF((monthly_watch_minutes), 0) * 100 AS percent_change_from_prev_monthly_watch_minutes
FROM monthly
ORDER BY rating_month;