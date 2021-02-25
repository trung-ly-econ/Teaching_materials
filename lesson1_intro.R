# intro assignment:
# https://stats.idre.ucla.edu/stat/data/intro_r/intro_r_interactive_flat.html
# Ctrl+L to clear console
# rm(list = ls()) to clear all variables

# Lesson 1

##### Part 1: Set working directory #####
  # Working directory = the place where files are saved
  # Reasons to set working directory:
  # 1. Know exactly where files are saved
  # 2. Collaborators can put files in their folder, change wd, and code will run
  getwd()
  # setwd("C:/Users/trungly/Desktop/Capstone_course")

##### Part 2: Install and load packages #####
  # install.package("name of package")
  install.package("")
  # then load packages to be used in session library(package's name, no "")
  library(tidyverse)


##### Part 3: Why we don't use = to assign variables #####
  (P1 <- matrix(input <- c(1:10), nrow=2, ncol=5)) # this will run
  (P2 <- matrix(input = c(1:10), nrow=2, ncol=5)) # this won't run
  help(matrix)
  # why? Because the 1st argument of matrix is "data =". When we do input =, it
  # doesn't know what input is, hence the error and it won't run.
  # P1 runs because we assign a vector to input, and since "data =" can be 
  # omitted, it runs just fine.

##### Part 4: Exploratory data analysis #####
  #---- Sumamry statistics ----#
  # summary() provides summary statistics on the numeric columns
  summary(mtcars)
  # Can also use individual functions: mean(), median(), min(), max(), range(),
  # var(), sd() with the variable inside parantheses
  mean(mtcars$mpg)
  median(mtcars$mpg)
  mtcars$mpg %>% quantile(c(.25, .50, .75))
  mtcars$mpg %>% min()
  mtcars$mpg %>% max()

  # table() returns every unique value in a category and how often it appears
  table(mtcars$cyl)
  # NOTE: need to specify specific columns when using table()

  # aggregate() groups values at some higher level than they currently are 
  # (e.g. from agency to state, from day to month, from street to neighborhood) 
  # and does some mathematical operation of our choosing 
  # syntax: aggregate(numerical_column ~ category_column, FUN = math, data = )
  # - numerical column = column that we are doing the mathematical operation on
  # - category column = column we are using to group
  (aggregate(mpg~cyl, FUN = mean, mtcars))

  # Can use tapply for categorical/binary data
  # syntax: tapply(var to do math on, INDEX = var to group, FUN = math)
  tapply(mtcars$mpg, INDEX = mtcars$cyl, FUN = mean)

  #---- Missing values in R ----#
  data <- data.frame(x = c(1,2,NA,3),
                     y = c("Ben", "Alex", "Matt", "Zach"),
                     z = c(2,1,2,2))
  # To check if there's missing values, use is.na(dataset or variable)
  is.na(data$x) # returns a matrix of TRUE (1)/FALSE (0)
  is.na(data$y)
  is.na(data$z)
  # so to count the number of NA's, use sum
  sum(is.na(data$x))
  sum(is.na(data$y))
  sum(is.na(data$z))
  # To identify which obs is missing, use which:
  which(is.na(data)) # This returns 3, so the 3rd obs is missing
  
  
  # How functions deal w/ missing values
  mean(data$x)                # this returns NA
  mean(data$x, na.rm = TRUE)  # this returns 2=(1+2+3)/3
  
  # To get rid of obs with NA, use !(is.na)
  (data_clean <- data %>%
      filter(!(is.na(data))))
  # OR: To drop observations with missing values, use !is.na(variable)
  data[!is.na(data$x),] # This returns the data frame w/ 3rd obs dropped
  
  
  rm(data, data_clean)

  ##### Part 6: (Very) basic plotting #####
  # syntax: plot(x_axis_variable, y_axis_variable, 
  #               xlab = "name of x axis",
  #               ylab = "name of y axis",
  #               main = "name of graph")
# End of lecture 1