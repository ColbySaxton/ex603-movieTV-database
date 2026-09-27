# ex603-movieTV-database
Colby Saxton

This is a Database for ex603 class for Movies/TV Shows.

This is a platform for a user to go into and create ratings for movies and view the aggregate scores for movies based on all ratings for that particular movie. This will also show a user the genre of a movie.

This will do that by creating a database schema with 5 different objects. First is a user which contains information about a user. Second is a movie. Third is a genre. Fourth is a movie genre connecting object. Fifth is a ratings object that allows a user to create a rating for a movie. See the ERD diagram below:

![ERD Diagram](schema/erd.png)

# Database Schema

This document describes the Schema Design for a Movie/TV user score management application.

## Tables

### `users`

Stores core user account credentials.

### `movies`

Stores information about movies.

### `genres`

Stores movie genres.

### `scores`

Stores an average score for a movie. Its primary key allows at most one score row per movie.

### `movie_genres`

Sotres the relationship between movies and genres. The composite primary key `pk_movie_genre` uses (`movie_id`, `genre_id`), preventing duplicate links between the same movie and genre.

### `ratings`

Stores individual user ratings for movies.

## Relationships

- A user can have many ratings; each rating references one user. Deleting a user cascades to their ratings.
- A movie can have many ratings; each rating references one movie. Deleting a movie cascades to its ratings.
- Movies and genres have a many-to-many relationship through `movie_genres`. Deleting a movie or genre removes the corresponding link rows.
- A movie can have at most one `scores` row because `scores.movie_id` is its primary key. Deleting the movie cascades to its score row.