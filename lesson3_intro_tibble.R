# This is about tibbles #

rm(list = ls())
##### Part 0: Set working directory #####
  # Working directory = the place where files are saved
  # Reasons to set working directory:
  # 1. Know exactly where files are saved
  # 2. Collaborators can put files in their folder, change wd, & code will run
  getwd()
  # setwd("C:/Users/trungly/Desktop/Capstone_course")

  library(tidyverse)

#### Part 1: tibbles ####
  # To turn a data frame into a tibble, use as_tibble(name of data frame)
  tibble.mtcars <- as_tibble(mtcars)

  # to create a tibble from scratch, do the same as creat a data frame, 
  # except use tibble command
  sample.data.frame <- data.frame(col1=c(2,3,5),
                                col2=c(1,2,3),
                                col3=c("BOS","LA","NYC"))
  sample.tibble <- tibble(col1=c(2,3,5),
                                col2=c(1,2,3),
                                col3=c("BOS","LA","NYC"))
  # or can also use tribble(), i.e. transposed tibble
  tribble(
    ~x, ~y, ~z,
    #--|--|----
    "a", 2, 3.6,
    "b", 1, 8.5
  )
