# Database Constraints

| Schema | Attribute | Constraints | Description |
| :--- | :--- | :--- |
| `users` | `UserId` | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` `ON DELETE CASCADE` | Unique identifier for the account owner and primary key of user. |
| `users` | `Username` | `UNIQUE`, `NOT NULL` | Unique user name for a user, must be unique so each user can be referred to by their username and they must have it present. |
| `movies` | `MovieId` | `PRIMARY KEY`, `ON DELETE CASCADE` | Unique id for the movie. |
| `movies` | `Name` | `NOT NULL` | Name for the movie, it must be present. |
| `movies` | `ActivityFlag` | None specified | unclear what this flag's behavior is yet. |
| `genres` | `GenreId` | `PRIMARY KEY`, `ON DELETE RESTRICT` | Unique id and primary key for a genre. |
| `genres` | `Name` | `NOT NULL`, `UNIQUE` | Unique name for a genre, cannot have duplicate names. |
| `scores` | `MovieId` | `PRIMARY KEY`, `FOREIGN KEY`, `ON DELETE CASCADE` | Foreign key for movie id and primary key because of one to one relationship. |
| `scores` | `AvgScore` | None Specified | The average score of all ratings for a movie. Can be null if no ratings for a movie exist. |
| `movie_genres` | `GenreId` | `PRIMARY KEY`, `FOREIGN KEY`, `ON DELETE RESTRICT` | Foreign key for genre id and one half of aggregate primary key. |
| `movie_genres` | `MovieId` | `PRIMARY KEY`, `FOREIGN KEY` | Foreign key for movie id and one half of aggregate primary key. |
| `ratings` | `UserId` | `PRIMARY KEY`, `FOREIGN KEY`, `ON DELETE RESTRICT` | Foreign key for user id and one half of aggregate primary key. |
| `ratings` | `MovieId` | `PRIMARY KEY`, `FOREIGN KEY` | Foreign key for movie id and one half of aggregate primary key. |
| `ratings` | `CreatedDate` | `NOT NULL` | Date the rating was created. |
| `ratings` | `Rating` | `NOT NULL`, `BETWEEN 1 & 10` | Rating for a movie, a rating tuple must include an integer value between 1 and 10. |