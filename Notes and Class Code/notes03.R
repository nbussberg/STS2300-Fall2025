## Notes 03 - Data Import and Wrangling

# Check where my current working directory is
getwd()

library(readr)
NC_Bridges <- read_csv("NC Bridges.csv")


# Pipe Operator

library(dplyr)

# Default, long way of coding
auto <- filter(mtcars, am == 0)
auto <- mutate(auto, wt_lbs = 1000 * wt)
mean_wt_by_cyl <- summarize(auto, mean_wt = mean(wt_lbs), .by = cyl)
mean_wt_by_cyl <- arrange(mean_wt_by_cyl, cyl)
mean_wt_by_cyl

# A little more streamlined example
mean_wt_by_cyl <- arrange(summarize(mutate(filter(mtcars,
                                                  am == 0),
                                           wt_lbs = 1000 * wt),
                                    mean_wt = mean(wt_lbs),
                                    .by = cyl),
                          cyl)
mean_wt_by_cyl

# the pipe operator way
mean_wt_by_cyl <- mtcars |> 
  filter(am == 0) |> 
  mutate(wt_lbs = 1000 * wt) |> 
  summarize(mean_wt = mean(wt_lbs), .by = cyl) |> 
  arrange(cyl)

mean_wt_by_cyl



## Subsetting data by rows and columns

# filter() function to select rows

# only bridges from Alamance County
alam_bridges <- filter(NC_Bridges, COUNTY == "ALAMANCE")

table(alam_bridges$COUNTY)

# only bridges that are structurally deficient (SD) and 
  # functionally obsolete (FO)
sd_and_fo <- filter(NC_Bridges, STRUCTURALLYDEFICIENT == "SD" &
                    FUNCTIONALLYOBSOLETE == "FO")

table(sd_and_fo$STRUCTURALLYDEFICIENT)
table(sd_and_fo$FUNCTIONALLYOBSOLETE)


# only bridges from Alamance County that are either structurally
  # deficient or functionally obsolete
problem3 <- filter(NC_Bridges, 
                   (STRUCTURALLYDEFICIENT=="SD" | 
                     FUNCTIONALLYOBSOLETE=="FO") & 
                   COUNTY == "ALAMANCE")


# Use select() to choose only certain columns

# Update alam_bridges to only include ROUTE, ACROSS, YEARBUILT, 
  # and SR

bridges4 <- select(alam_bridges, ROUTE, ACROSS, YEARBUILT, SR)


## Using mutate() to create new variables

mycars <- mutate(mtcars, wt_lbs = wt * 1000)

mycars |> 
  select(wt, wt_lbs) |> 
  head(n = 5)

# create new variable called AGE and verify
my_NCbridges <- mutate(NC_Bridges, 
                       AGE = 2025 - YEARBUILT)

# Print AGE and YEARBUILT for the last 10 bridges
my_NCbridges |> 
  select(YEARBUILT, AGE) |> 
  tail(n = 10)
  
  
## Long vs. Wide Data

# Load in datasets from Github using link
birds_wide <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2025/main/Data/nestbox_lands_wide.csv")
birds_long <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2025/main/Data/nestbox_lands_long.csv")

library(tidyr)

# Convert wide format to long format
birds_wide |> 
  pivot_longer(cols = -Species, 
               names_to = "Year",
               values_to = "Fledged") |> 
  head(n = 5)

# Convert long format to wide format
birds_long |> 
  pivot_wider(names_from = "Year",
              values_from = "Fledged")





