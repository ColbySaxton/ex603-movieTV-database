
# Unit 5 Analysis

## 5.1

The 3 table join can be used for a feature or report for determining when users created ratings for different movies.

The junction table in question 2 is important because it allows a movie to have more than one genre, and allows the genre to change over time. Otherwise, if movies had more than one genre, a new genre had to be created that was a composite of multiple genres, or the genre field had to be converted to a text field.

## 5.2

The movies that were excluded by the inner join were movie ids 14 and 15. The reason they were excluded was because they do not have any ratings created for them.

When a movie does not have a rating, it can mean a few things. First the movie is not out yet, or there are no ratings for the movie.

A report based only on an inner join may leave out important context to decisions. That is because it may be leaving out either reviews that are not correctly tagged to a movie, or it can ignore movies that do not have reviews from any output.

Leadership may want to identify movies that have never been active to learn about frequency of movies, or the amount of movies from different regions, or if there are any trends as to why certain movies are not active.

Leader can decide whether to exclude certain regions or time periods if there are movies that are inactive, or if a trend is noticed, then that can be incorporated into findings and thus those non-active movies can be removed or archived accordingly.

## 5.3

A cartesian platform would be useful for sharing all combinations of two separate tables. The only example for this platform I can think of would be for finding all different combinations of genres and movies. But even then, we should be careful how it should be used, as it is relatively inexpensive at small scale but becomes significantly expensive at scale.

The join algorithm PostreSQL chose was a nested loop for joining the tables, and a hash join for matching the proper records via the join on conditions.

The row count and hash condition helped explain these choices and why they were selected from the explain.

It is useful to understand the selected join algorithm to understand what the pain points may be as it scales. Therefore, you can understand how to design queries best to accomodate the scaling properly and keep the query performant.

If the amount of ratings grew from 100 to 1,000,000 then a different join algorithm would be more appropriate and additional steps should be taken to ensure the data is indexed properly and sorted.

## Reflection

There are a few changes to the data or database that might cause PostgreSQL to choose a different join algorithm. The first is changes to the data volume. PostgreSQL chose a nested loop to merge the tables together on the join. But if the colume of the table was significantly larger, then the outer row lookup to the inner tables would become more expensive. And a hash join may become a better suited alternative. But a hash join only works on an equality query. If it is a non-equi query, then it would have to use nested loop. If we decided to change the data itself to have indexes where the data is stored sorted by the index, then we would be able to use a merge jin. The reason for that is the tables can be streamed in tandem making for a more efficient query. 
