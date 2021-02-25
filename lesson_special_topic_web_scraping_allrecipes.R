rm(list=ls())
##### Part 0: Set working directory #####
# Working directory = the place where files are saved
# Reasons to set working directory:
# 1. Know exactly where files are saved
# 2. Collaborators can put files in their own folder, change wd, & code will run
getwd()
# setwd("C:/Users/trungly/Desktop/Capstone_course")

library(rvest)
library(tidyverse)

# Load brownies ingredients and directions #
link <- "https://www.allrecipes.com/recipe/25080/mmmmm-brownies/"

(ingredients <- link %>%
  read_html %>%
  html_nodes(".ingredients-item-name") %>%
  html_text())

(directions <- link %>%
    read_html %>%
    html_nodes(".instructions-section-item") %>%
    html_text())



# Clean output #
# Step 1: use gsub to remove \n
# syntax: gsub(what to replace, what to replace with, vector/dataframe of interest)
(ingredients <- gsub("\n", " ", ingredients))
(directions <- gsub("\n", " ", directions))
# Note: gsub(" {2,}", " ", data) search for anything with 2+ spaces and replace
# that with an empty space

# Step 2: use trimws to get rid of white space
# syntax: trimws(vector/dataframe of interest, which = c("both", "left", "right"))
(ingredients <- trimws(ingredients)) # default is "both"
(directions <- trimws(directions))

# Step 3: get rid of white space in directions #
(directions <- gsub(" {2,}", ": ", directions))
# Note that the %>% can't be used b/c w/ pipe data are passed as a FIRST
# argument to the next function. Here in gsub directions is the last argument,
# # so won't work

### OR CAN DO ALL OF THIS WITH ONE COMMENT ###
(ingredients <- str_squish(ingredients))
(directions <- str_squish(directions))

##### ASIDE: FUNCTIONS #####
# Syntax:
# function_name <- function(parameters) {
#   code
#   return(output)
# }
scrape_recipe <- function(URL){
  link <- URL
  
  (ingredients <- link %>%
      read_html %>%
      html_nodes(".ingredients-item-name") %>%
      html_text())
  
  (directions <- link %>%
      read_html %>%
      html_nodes(".instructions-section-item") %>%
      html_text())
  
  (ingredients <- gsub("\n", " ", ingredients))
  (directions <- gsub("\n", " ", directions))
  
  (ingredients <- trimws(ingredients)) 
  (directions <- trimws(directions))
  
  (directions <- gsub(" {2,}", ": ", directions))
  print(ingredients)
  print(directions)
}