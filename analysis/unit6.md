# Unit 5 Analysis

## 6.1

If we want to know how far each rating deviates from the average of the movie's average, we need to see each row next to its group average. A group average alone cannot answer that because it aggregates each row into one group row, instead of showing each row within each grouping.

A platform feature that would use the ranking of the number of ratings for each movie, would be to see the ranking of the most ranked or discussed movies on the list. For this ranking, we should use the RANK() function because we want to maintain the ordering of all of the movies, however we cannot rank one tied movie over another movie that is tied with it. We must show those rankings as the same as one is not inherently above the other when showing the ranking in order.

## 6.2

A large delta tells someone that the rating is significantly different than the previous rating. On its surface, there is no action that needs to be taken there since different users can have different ratings and that is ok.

A running total answer shows a snapshot of the accumulation in that moment. A standard sum does not display that since it is a static value that is the same for all rows.

I picked my moving average window size because the prompt explicitly said that we want to address thoughts on a per quarter basis, and a quarter is 3 months. Therefore, I selected a 3 month window size to effectively understand what is happening per quarter or just on a per 3 month basis.

A gap in our platform is just a combination of a real stop in activity and a side effect of how the events are recorded. Users obvious have certain times of year they are watching more movies such as in the winter or during holidays and less time during times when there are more alternatives to do such as the weather getting nicer.

## 6.3

The top-N would power a feature to understand what are the top rated movies per genre for recommendations for users. 3 is best for recommendations as only one does not offer much choice if a user does not want to watch the single movie, and 10 is too many options for a user to choose from if they just want to watch a new movie.

A large month over month change in watch minutes or score shows the shifting watching habits or feelings for users about the movies they are watching. To understand this, recommendations for users can shift based on the user's watching habits and ratings scores during different times of the year. And perhaps we recommend less when user viewing habits are lower, and recommend more movies when user viewing habits are higher.

## Reflection

Overall, window functions offer much more granular understanding of data and trends over a standard group by. Because window functions allow the grouping functionality of GROUP BY, while keeping the underlying rows, we are able to not only group the data but compare those groupings to one another. This is especially important when wanting to group into time periods such as weeks or months to understand trends of when users are creating ratings for movies or for understanding the minutes watched within a time period and how that compares to other time periods. But it also allows us to understand the breakdown by genre of movie and how rankings of movies within genres can be found. A GROUP BY would make these actions difficult as it would require multiple either additional queries or many JOIN statements to collate all of the necessary data into one place.
