
# Findings

## Breakdown

Overall, about 20% of all ratings were failed to be uploaded for various reasons. Some movies have failure rates that are below average such as movie id 8, 10 and 12. Some movies have failure rates that are above average such as movie id 5, 11, 9, 3, 1, 4. Overall, there is a rather even distribution of ratings by region. All main regions contribute an even amount of ratings for movies. Certain movies have an above average amount of ratings. Those movies are movie id 6, 8, 10, 7 and 5.

## Reflection

Overall, conditional aggregation can save a significant amount of time querying for data over running two separate filtered queries. The reason for this, is a conditional aggregation only needds one pass over the data. Separate filtered queries need at least 2 separate passes over the data. When data scales to high amounts, that difference may baloon in both time and computation cost. For those reasons, conditional aggregation should be used in scenarios where it is possible to reduce both the time, compute cost and the number of queries made to a database.