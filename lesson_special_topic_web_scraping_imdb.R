# This is about the web scraping using rvest #


rm(list = ls())
##### Part 0: Set working directory #####
# Working directory = the place where files are saved
# Reasons to set working directory:
# 1. Know exactly where files are saved
# 2. Collaborators can put files in their own folder, change wd, & code will run
getwd()
# setwd("C:/Users/trungly/Desktop/Capstone_course")

# To web scrape, need the rvest package & the selectorgadget Chrome extension
# vignette("selectorgadget")
# install.packages("rvest")
library(rvest)
library(tidyverse)

##### Example: scrape directors' names for one movie #####
link <- "https://www.imdb.com/title/tt0477348/"
# Step 1: use read_html() to read the page's info into R
(movie_name <- read_html(link))
# Step 2: use html_nodes() to grab the part of the page we want
(credit_info <- html_nodes(movie_name, ".summary_text+ .credit_summary_item a"))
# Step 3: use html_text() to tell rvest that the scraped data is text
(credit_info <- html_text(credit_info))
# Step 4: write thing into one object
director <- paste(credit_info, collapse=", ")

# OR: use the pipe
(director <- link %>%
  read_html(link) %>%
  html_nodes(".summary_text+ .credit_summary_item a") %>%
  html_text() %>%
  paste(collapse=", "))


#################### Example: scrape stars for one movie ####################

(stars <- link %>%
  read_html() %>% 
  html_nodes(".credit_summary_item~ .credit_summary_item+ .credit_summary_item a+ a , .credit_summary_item~ .credit_summary_item+ .credit_summary_item .inline+ a") %>% 
  html_text() %>% 
  paste(collapse=", "))


#################### Example: scrape genres for one movie ####################

(genre <- link %>%
  read_html() %>% 
  html_nodes(".subtext a+ a , .subtext a:nth-child(4)") %>% 
  html_text() %>% 
  paste(collapse=", "))

################## Example: scrape movie name for one movie ##################

(movie_name <- link %>%
    read_html() %>% 
    html_nodes("#ratingWidget strong") %>% 
    html_text() %>% 
    paste(collapse=", "))

# Combine everything into a data frame
movie <- data.frame(movie_name, director, genre, stars, stringsAsFactors=FALSE)

###############################################################################

#################### Part 2: Do it for all 2018 movies ####################

link_movie_list_2018 <- "https://www.imdb.com/search/title/?title_type=feature&year=2018-01-01,2018-12-31&sort=num_votes,desc"

# let's look at the output of html nodes for titles
(link_movie_list_2018 %>%
  read_html() %>%
  html_nodes(".lister-item-header a"))

# Note that they seem to give you the URL to the movies, so we'll use that
(movie_links_2018 <- link_movie_list_2018 %>%
  read_html() %>%
  html_nodes(".lister-item-header a") %>%
  html_attr("href") %>%
  paste("https://www.imdb.com", ., sep=""))
# Note: piped data is the FIRST argument, here we need it in the 2nd argument,
# so the . plays that role.

get_movie_info <- function(link){
  (movie_name <- link %>%
     read_html() %>% 
     html_nodes("#ratingWidget strong") %>% 
     html_text() %>% 
     paste(collapse=", "))
  
  (director <- link %>%
     read_html(link) %>%
     html_nodes(".summary_text+ .credit_summary_item a") %>%
     html_text() %>%
     paste(collapse=", "))
  
  (stars <- link %>%
      read_html() %>% 
      html_nodes(".credit_summary_item~ .credit_summary_item+ .credit_summary_item a+ a , .credit_summary_item~ .credit_summary_item+ .credit_summary_item .inline+ a") %>%
      html_text() %>% 
      paste(collapse=", "))
  
  (genre <- link %>%
      read_html() %>% 
      html_nodes(".subtext a+ a , .subtext a:nth-child(4)") %>% 
      html_text() %>% 
      paste(collapse=", "))
  final_product <- data.frame(movie_name, director, genre, stars, stringsAsFactors=FALSE)
  return(final_product)
}

# Run a "loop" through everything
# https://stackoverflow.com/questions/32833664/how-do-i-add-rows-to-a-data-frame-using-sapply
# The popular function call do.call(rbind, <list>) combines  elements of a list.
absdf <- lapply(movie_links_2018, FUN = get_movie_info)
output <- do.call(rbind, absdf)