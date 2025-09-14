## Notes 02 - Data Summaries

# check working directory
data(mtcars)

## Quantitative vs. categorical data and representation in R

# Look at structure of data and determine variable types
str(mtcars)
is.numeric(mtcars$mpg)


## Summarizing Quantitative Data

# Practice using basic functions on mtcars data frame
# mean mpg
mean(mtcars$mpg)

# minimum horsepower
min(mtcars$hp)

# 80th percentile for weight
quantile(mtcars$wt, probs = 0.8)

# standard deviation for displacement
sd(mtcars$disp)


# Practice with dplyr's summarize() function
library(dplyr)
car_sum <- summarize(mtcars, 
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))

car_sum
car_sum$avg_hp


## Summarizing Categorical Data

# Load the dataset and explore the structure
library(moderndive)

str(MA_schools)

# Use table() and prop.table() to summarize the school sizes
table(MA_schools$size)

prop.table(table(MA_schools$size))


## Summaries by Group

summarize(MA_schools,
          count = n(),
          .by = size)

summarize(mtcars, 
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp),
          .by = c(am, cyl))





