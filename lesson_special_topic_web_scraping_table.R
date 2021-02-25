# This is about scraping tables on webpages #
rm(list=ls())

##### Part 0: Set working directory #####
# Working directory = the place where files are saved
# Reasons to set working directory:
# 1. Know exactly where files are saved
# 2. Collaborators can put files in their own folder, change wd, & code will run
getwd()
# setwd("C:/Users/trungly/Desktop/Capstone_course")

library(tidyverse)
library(rvest)

# Right click on webpage, inspect, then click on cursor and hover over table
link <- "https://www.espn.com/nfl/player/stats/_/id/3139477/patrick-mahomes"
passing_stat <- link %>%
  read_html() %>%
#  html_nodes("div.ResponsiveTable.ResponsiveTable--fixed-left.pt4") %>%
  html_nodes("div") %>%
  .[1] %>%
  html_table()

#############################################################
# orginal
rm(list=ls())
URL <- "http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs"
Spurs <- read_html(URL)
Spurs
Spurs %>%
  html_nodes(xpath = '//*[@id="my-players-table"]/div[3]/div[3]/table') %>%
  html_table(Spurs) 
Spurs <- html_table(Spurs)
Spurs
SpursDataFrame <- data.frame(Spurs)
SpursDataFrame
#############################################################


rm(list=ls())

URL <- "http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs"
Spurs <- read_html(URL)
Spurs
Spurs %>%
  html_nodes(xpath = '//*[@id="fittPageContainer"]/div[2]/div[5]/div/div/section/div/div[5]/table') %>%
  html_table() 
Spurs <- html_table(Spurs)
#Spurs
SpursDataFrame <- data.frame(Spurs)
SpursDataFrame

