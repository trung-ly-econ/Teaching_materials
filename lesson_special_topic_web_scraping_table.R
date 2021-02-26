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