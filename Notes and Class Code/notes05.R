## Notes 05 - Customizing R Graphs

library(ggplot2)
library(palmerpenguins)

graphA <- ggplot(penguins, aes(x = bill_length_mm, 
                               y = body_mass_g, 
                               color = species,
                               shape = island)) + 
  geom_point(size = 3, alpha = 0.5) +
  labs(title = "Comparing penguin bill lengths to body mass",
       subtitle = "Across species and island",
       caption = "Created for STS 2300 Notes 05",
       x = "Bill Length (in mm)",
       y = "Body Mass (in g)",
       shape = "Islands",
       color = "Penguin \nSpecies")

graphA                   


## Editing graph scales

graphA +
  scale_shape_manual(values = c(8, 18, 25))


# Practice: change the colors on graphA

graphA +
  scale_shape_manual(values = c(8, 18, 25)) + 
  scale_color_manual(values = c(14, 8, 7))

graphA +
  scale_shape_manual(values = c(8, 18, 25)) + 
  scale_color_manual(values = c("deeppink2",
                                "violet",
                                "darkseagreen3"))


# Changing scales further
library(patchwork)

left <- ggplot(diamonds, aes(x = price)) + 
  geom_histogram(color = "white", bins = 20, 
                 boundary = 0)
right <- left + 
  scale_x_log10() + 
  labs(x = "Price on a log scale")
left + right


# Add dollar signs and commas to the x- and y-axis labels
left + 
  scale_x_continuous(labels = scales::label_dollar()) +
  scale_y_continuous(labels = scales::label_comma(),
                     breaks = seq(0, 15000, 2500))

     
# Reorder categories

majors <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2025/refs/heads/main/Data/MTH_STS_majors_long.csv")

ggplot(majors, aes(y = Major, x = Count)) + 
  geom_boxplot(fill = "gold", color = "maroon", 
               alpha = 0.5) + 
  geom_point() + 
  scale_y_discrete(limits = c("Math", "Applied_Math",
                              "Data_Analytics", "Stats"))



## Color schemes and graph themes

# Practice: add viridis scheme to penguin scatterplot

graphA + 
  scale_color_viridis_d(option = "D") + 
  theme_classic()


# Practice: Add viridis scheme and options as needed to following graph

ggplot(penguins, aes(x = bill_length_mm, y = body_mass_g,
                     color = flipper_length_mm)) +
  geom_point(size = 3, alpha = 0.5) + 
  scale_color_viridis_C(option = "A")


# Making our own theme (Elon colors)

ggplot(majors, aes(x = Year, y = Count, color = Major)) +
  geom_line(linewidth = 2) +
  geom_point() +
  labs(title = "Elon MTH/STS Department Majors", 
       x = "Year (Fall Semester)",
       y = "Number of Majors") +
  scale_x_continuous(breaks = seq(2007, 2024, 3)) +
  theme(plot.background = element_rect(fill = "firebrick4"),
        panel.background = element_rect(fill = "white"),
        panel.grid = element_line(color = "lightgray"),
        plot.title = element_text(color = "goldenrod1", 
                                  size = 18, 
                                  face = "bold", 
                                  family = "Courier"),
        axis.title = element_text(color = "goldenrod1", 
                                  size = 14),
        axis.text = element_text(color = "goldenrod1"),
        axis.ticks = element_line(color = "goldenrod1"),
        legend.background = element_rect(fill = "darkgray"),
        plot.margin = margin(20, 20, 20, 20))


## Images with multiple graphs

library(patchwork)

A <- ggplot(penguins, aes(x = bill_length_mm)) +
  geom_histogram(binwidth = 5, color = "white")
B <- ggplot(penguins, aes(x = bill_depth_mm)) +
  geom_histogram(binwidth = 2, color = "white")
C <- ggplot(penguins, aes(x = body_mass_g, y = species)) +
  geom_boxplot(aes(fill = species), 
               show.legend = FALSE)

(A + B) / C +
  plot_annotation(title = "My Three Penguin Graphs",
                  subtitle = "Two histograms and a boxplot",
                  caption = "Made with the patchwork package")







