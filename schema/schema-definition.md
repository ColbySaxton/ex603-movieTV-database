# Database Schema:

## Table Definitions:

### `users`
**Purpose:** Stores core user account credentials.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `UserId` | `UUID` | Unique identifier for the account owner. |
| `Username` | `VARCHAR(255)` | User's user name. |

### `movies`
**Purpose:** Store movie information.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `MovieId` | `UUID` | Unique movie ID. |
| `Name` | `VARCHAR(255)` | Name of movie. |
| `ActivityFlag` | `BOOLEAN` | Activity flag for the movie. |

### `genres`
**Purpose:** Store genre information.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `GenreId` | `UUID` | Unique genre ID. |
| `Name` | `VARCHAR(255)` | Name of genre. |

### `scores`
**Purpose:** Store aggregate score of all ratings for a movie.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `MovieId` | `UUID` | Unique movie ID that also acts as primary key for this one to one relationship. |
| `AvgScore` | `DECIMAL` | Average score of all ratings for a particular movie. |

### `movie_genres`
**Purpose:** Connecting object that links a movie to a genre.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `GenreId` | `UUID` | Unique genre ID. Aggregates with movie ID to create primary key. |
| `MovieId` | `VARCHAR(255)` | Unique movie ID. Aggregates with genre ID to create primary key. |

### `ratings`
**Purpose:** Store a user's rating for a movie.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `UserId` | `UUID` | Unique user ID. Aggregates with movie ID to create primary key. |
| `MovieId` | `VARCHAR(255)` | Unique movie ID. Aggregates with user ID to create primary key. |
| `CreatedDate` | `DATETIME` | Datetime of created rating. |
| `Rating` | `INT` | Rating a user gives a movie on a scale of 0-10. |

