# Database Schema

This document describes the Schema Design for a Movie/TV user score management application.

## Tables

### `users`

Stores core user account credentials.

| Column | Definition | Description |
| :--- | :--- | :--- |
| `user_id` | `INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY` | Automatically generated unique identifier for each user. |
| `display_name` | `VARCHAR(40) NOT NULL` | User's display name. |
| `email` | `VARCHAR(50) NOT NULL UNIQUE` | User's required, unique email address. |
| `joined_at` | `TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP` | Time the user record is created; defaults to the current timestamp. |

### `movies`

Stores information about movies.

| Column | Definition | Description |
| :--- | :--- | :--- |
| `movie_id` | `INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY` | Automatically generated unique identifier for each movie. |
| `title` | `VARCHAR(100) NOT NULL` | Movie title. |
| `release_year` | `INTEGER NOT NULL` | Movie release year; constrained to be 1888 or later by `chk_release_year_range`. |

### `genres`

Stores movie genres.

| Column | Definition | Description |
| :--- | :--- | :--- |
| `genre_id` | `INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY` | Automatically generated unique identifier for each genre. |
| `genre_name` | `VARCHAR(50) NOT NULL UNIQUE` | Required genre name, unique across the table. |

### `scores`

Stores an average score for a movie. Its primary key allows at most one score row per movie.

| Column | Definition | Description |
| :--- | :--- | :--- |
| `movie_id` | `INTEGER NOT NULL PRIMARY KEY` | Movie identifier; primary key constraint is named `pk_movie_id`. It also references `movies(movie_id)` with `ON DELETE CASCADE`. |
| `avg_score` | `NUMERIC(3, 1) NOT NULL` | Average score, constrained to the range 0 through 10 by `chk_avg_score_range`. |

The SQL declares the `movie_id` foreign key twice: once inline and once as the named constraint `fk_movie_id`. Both reference `movies(movie_id)` with `ON DELETE CASCADE`; the second declaration is redundant.

### `movie_genres`

Associates movies with genres in a many-to-many relationship.

| Column | Definition | Description |
| :--- | :--- | :--- |
| `movie_id` | `INTEGER NOT NULL` | References `movies(movie_id)` with `ON DELETE CASCADE`. |
| `genre_id` | `INTEGER NOT NULL` | References `genres(genre_id)` with `ON DELETE CASCADE`. |

The composite primary key `pk_movie_genre` uses (`movie_id`, `genre_id`), preventing duplicate links between the same movie and genre.

### `ratings`

Stores individual user ratings for movies.

| Column | Definition | Description |
| :--- | :--- | :--- |
| `rating_id` | `INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY` | Automatically generated unique identifier for each rating. |
| `user_id` | `INTEGER NOT NULL` | References `users(user_id)` through `fk_user_id` with `ON DELETE CASCADE`. |
| `movie_id` | `INTEGER NOT NULL` | References `movies(movie_id)` through `fk_movie_id` with `ON DELETE CASCADE`. |
| `score` | `NUMERIC(3, 1) NOT NULL` | Rating score, constrained to the range 0 through 10 by `chk_score_range`. |

## Relationships

- A user can have many ratings; each rating references one user. Deleting a user cascades to their ratings.
- A movie can have many ratings; each rating references one movie. Deleting a movie cascades to its ratings.
- Movies and genres have a many-to-many relationship through `movie_genres`. Deleting a movie or genre removes the corresponding link rows.
- A movie can have at most one `scores` row because `scores.movie_id` is its primary key. Deleting the movie cascades to its score row.