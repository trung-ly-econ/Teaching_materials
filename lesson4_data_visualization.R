# This is about the basics of data visualization #

rm(list = ls())
##### Part 1: Set working directory #####
# Working directory = the place where files are saved
# Reasons to set working directory:
# 1. Know exactly where files are saved
# 2. Collaborators can put files in their own folder, change wd, & code will run
getwd()
setwd("C:/Users/trungly/Desktop/Capstone_course")

library(tidyverse)

# basic ggplot syntax #
# ggplot(data = dataset's name) +
#   Geom_function(mapping = aes(x = xvar, y = yvar, class =, shape =, color = ))
# NOTE THAT + HAS TO BE AT THE END OF A LINE, NOT THE BEGINNING
# List of Geom_function: geom_point makes scatter plot, geom_smooth makes curve
# that best fit the data (with confidence level)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# Note: including color inside aes means different categories have different
# colors. If color = "color choice" is outside of aes, it changes the color of
# the plot, e.g. changes color of pts in scatter plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "red")

# ggplot2 will only use six shapes at a time. Additional groups won't be plotted

# Including mapping details inside ggplot makes them global for all geom funcs
# that follow. For those that follow, just need geom_function()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
# can include aes details:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()