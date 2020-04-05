# Title     : NYC retaurant
# Objective : restaurants
# Created by: Amol
# Created on: 3/31/2020
install.packages("dplyr")
library("dplyr")
install.packages("plotly")
library("plotly")
install.packages("geometry")
library("geometry")
install.packages("rgl")
library(rgl)

nyc <- read.csv("nyc.csv")

nyc

glimpse(nyc)
pairs(nyc)


lm(Price~ Food+ factor(East), nyc)


# fit model food rveiws and Service reviews.
lm(Price~ Food + Service, nyc)


#visualizing using plot_ly

# draw 3D scatterplot
p <- plot_ly(data = nyc, z = ~Price, x = ~Food, y = ~Service, opacity = 0.6) %>%
  add_markers()

# draw a plane
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane, showscale = FALSE)
