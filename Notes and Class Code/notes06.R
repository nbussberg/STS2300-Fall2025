## Notes 06 - Simple Linear Regression

library(ggplot2)

fastfood <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2025/refs/heads/main/Data/fast_food_accuracy.csv")

ggplot(fastfood, aes(x = SecPerOrder, y = PctWithErrors)) + 
  geom_point() +
  labs(x = "Average Seconds Per Drive-Thru Order",
       y = "Percentage of Orders with Errors",
       title = "Fast Food Drive Thru Accuracy") +
  theme_classic()

# Using R for SLR

lm(PctWithErrors ~ SecPerOrder, data = fastfood)

# Aside on piping with regression

fastfood |>  
  lm(PctWithErrors ~ SecPerOrder, data = _)


## Making predictions with SLR Lines

# Manual hard-coded calculation

17.7152 - (0.0306 * 300)


# Use predict() to make predictions

fastfood.lm <- lm(PctWithErrors ~ SecPerOrder, data = fastfood)

predict(fastfood.lm, 
        newdata = data.frame(SecPerOrder = 500))


## Coefficient of determination (R^2)

summary(fastfood.lm)


# Manually calculate R^2 for the model

(18.667 - 12.224) / 18.667


  
