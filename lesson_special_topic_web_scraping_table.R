# This is about scraping tables on webpages #
rm(list=ls())

library(tidyverse)
library(rvest)

link <- "https://www.espn.com/nfl/player/stats/_/id/3139477/patrick-mahomes"

mahomes <- link %>%
  read_html() %>%
  html_table() # extract all tables on the page and put them into a list

mahomes # this is a list that contains all the tables on the page

data <- data.frame(mahomes[c(1,2)]) # take the first 2 items of the list and 
                        # combine them into a data frame

# Note: use single square brackets to extract a specific list element of a list
# THE OUTPUT IS A LIST

# If we want to extract a list element with its own data type, we can use double square brackets:
# (This output is a vector)
# For more informatio, see here:
# https://statisticsglobe.com/difference-between-bracket-and-double-brackets-in-r

#-----------------------------------------------------------------------------#
####----- Another example-----####

rm(list=ls())
URL <- "http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs"
Spurs <- URL %>%
  read_html() %>%
  html_table()

Spurs

SpursDataFrame <- data.frame(Spurs[c(1,2)])
View(SpursDataFrame)
#-----------------------------------------------------------------------------#