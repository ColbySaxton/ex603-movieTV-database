-- ----------------------------------------------------------------
-- 1. Users - Stores core user account credentials.
-- First table created because it is a strong entity and source of all user based relationships.
-- ----------------------------------------------------------------
CREATE TABLE users (
user_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
display_name VARCHAR(40) NOT NULL,
email    VARCHAR(50) NOT NULL UNIQUE,
joined_at  TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------
-- 1. Movies - Stores information about movies.
-- Second table created because it is a strong entity and source of all movie based relationships.
-- ----------------------------------------------------------------
CREATE TABLE movies (
movie_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
title      VARCHAR(100) NOT NULL,
release_year INTEGER NOT NULL,
CONSTRAINT chk_release_year_range
CHECK (release_year >= 1888)
);

-- ----------------------------------------------------------------
-- 1. Genres - Stores information about movie genres.
-- Third table created because it is a strong entity and source of all genre based relationships.
-- ----------------------------------------------------------------
CREATE TABLE genres (
genre_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
genre_name VARCHAR(50) NOT NULL UNIQUE
);

-- ----------------------------------------------------------------
-- 1. Scores - Stores average scores for movies.
-- Fourth table created because it is a weak entity and a one to one relationship with movies..
-- ----------------------------------------------------------------
CREATE TABLE scores (
movie_id   INTEGER NOT NULL REFERENCES movies(movie_id) ON DELETE CASCADE,
avg_score  NUMERIC(3, 1) NOT NULL,
CONSTRAINT chk_avg_score_range
CHECK (avg_score >= 0 AND avg_score <= 10),
CONSTRAINT pk_movie_id
PRIMARY KEY (movie_id),
CONSTRAINT fk_movie_id
FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

-- ----------------------------------------------------------------
-- 1. Movie_Genres - Links movies to their genres.
-- Fifth table created because it is a weak entity and represents a many-to-many relationship between movies and genres.
-- ----------------------------------------------------------------
CREATE TABLE movie_genres (
movie_id INTEGER NOT NULL REFERENCES movies(movie_id) ON DELETE CASCADE,
genre_id INTEGER NOT NULL REFERENCES genres(genre_id) ON DELETE CASCADE,
CONSTRAINT pk_movie_genre
PRIMARY KEY (movie_id, genre_id)
);

-- ----------------------------------------------------------------
-- 1. Ratings - Stores individual user ratings for movies.
-- Sixth table created because it is a weak entity and represents a many-to-many relationship between users and movies.
-- ----------------------------------------------------------------
CREATE TABLE ratings (
rating_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
user_id     INTEGER NOT NULL,
movie_id    INTEGER NOT NULL,
score       NUMERIC(3, 1) NOT NULL,
CONSTRAINT chk_score_range
CHECK (score >= 0 AND score <= 10),
CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
CONSTRAINT fk_movie_id
FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);