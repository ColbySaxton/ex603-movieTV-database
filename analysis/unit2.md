# Unit 2 Analysis

## Key Constraints

| Constraint | `ON DELETE` choice | Reason |
| --- | --- | --- |
| `users.user_id` (`PRIMARY KEY`) | Not applicable | Uniquely identifies each user and prevents duplicate or null user IDs. |
| `movies.movie_id` (`PRIMARY KEY`) | Not applicable | Uniquely identifies each movie and prevents duplicate or null movie IDs. |
| `movies.release_year` (`chk_release_year_range`, `CHECK`) | Not applicable | Rejects release years before 1888. That is because no movie was released before that date, so any movie with a date before that time will be incorrect and must be rejected. |
| `genres.genre_id` (`PRIMARY KEY`) | Not applicable | Uniquely identifies each genre and prevents duplicate or null genre IDs. |
| `scores.movie_id` (`PRIMARY KEY`, `pk_movie_id`) | Not applicable | Allows at most one score row per movie and requires the movie ID to be non-null. |
| `scores.avg_score` (`chk_avg_score_range`, `CHECK`) | Not applicable | Restricts the average score to values from 0 through 10. If a value is either negative, or above 10, then it will throw off the calculations for the average score of a movie and the application will be expecting scores from 0 through 10. |
| `scores.movie_id` -> `movies.movie_id` (inline `FOREIGN KEY`) | `CASCADE` | A movie's score row depends on that movie and should be removed when the movie is deleted. |
| `scores.movie_id` -> `movies.movie_id` (`fk_movie_id`, `FOREIGN KEY`) | `CASCADE` | Applies the same dependent-row deletion; this duplicates the inline foreign key. |
| `movie_genres.movie_id`, `movie_genres.genre_id` (`PRIMARY KEY`, `pk_movie_genre`) | Not applicable | Makes each movie/genre pair unique and requires both IDs to be non-null. |
| `movie_genres.movie_id` -> `movies.movie_id` (inline `FOREIGN KEY`) | `CASCADE` | Deleting a movie removes its genre-link rows so they do not reference a missing movie. |
| `movie_genres.genre_id` -> `genres.genre_id` (inline `FOREIGN KEY`) | `CASCADE` | Deleting a genre removes its genre-link rows so they do not reference a missing genre. |
| `ratings.rating_id` (`PRIMARY KEY`) | Not applicable | Uniquely identifies each rating and prevents duplicate or null rating IDs. |
| `ratings.score` (`chk_score_range`, `CHECK`) | Not applicable | Restricts each rating score to values from 0 through 10. Similar to the value above, if a calculation has a score either below 0 or above 10 then the calculation is incorrect and must not be accepted as it would introduce a bug. |
| `ratings.user_id` -> `users.user_id` (`fk_user_id`, `FOREIGN KEY`) | `CASCADE` | Deleting a user also deletes the ratings associated with that user. |
| `ratings.movie_id` -> `movies.movie_id` (`fk_movie_id`, `FOREIGN KEY`) | `CASCADE` | Deleting a movie also deletes ratings that can no longer be associated with an existing movie. |

the `scores` ON DELETE choice is reflected in the real life scenario of if a movie is removed from the database. If a movie is removed, then the score will have no context and no meaning since it is direct reference of the score of that movie. If the score remained while the movie was removed, then there would be an orphaned score value that is not connected to any movie. So that score is meaningless since it will be just a number with no surrounding context. Since the movie id is the primary key as well, this record will have no value without the movie it is connected to.

The `movie_genres` ON DELETE choice is reflected in the real life scenario of if a movie is removed from the database. If a movie is removed, then the movie genre connecting record will no longer have a movie it is connected to, instead it will be orphaned since it will be a movie_genre record with only a genre which will effectively be the same as just storing the genre itself. So this can be safely deleted. If not removed, there will be an orphaned movie_genre record with no movie context.

The `ratings` ON DELETE choice is reflected in the real life scenario of if a user deletes their user account on the application. If a user is removed, then the ratings of that user will be orphaned it is will have no context. Since that user account no longer exists, we are losing the user who owns and creates this rating therefore this rating record will be meaningless without that value. Additionally, if a movie is removed from a database, then the rating will also be orphaned. Because a user will have a rating but it will no longer point to a movie. This would be an issue because then that rating will have no value so it should be removed as well.