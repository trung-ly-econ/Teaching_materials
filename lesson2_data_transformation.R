rm(list = ls()) 

# Lesson 1

##### Part 0: Set working directory #####
  # Working directory = the place where files are saved
  # Reasons to set working directory:
  # 1. Know exactly where files are saved
  # 2. Collaborators can put files in their folder, change wd, & code will run
  getwd()
  setwd("C:/Users/trungly/Desktop/Capstone_course")
  library(tidyverse)
  #library(nycflights13)


##### Part 1: Three ways to subset data/pick obs #####
  data(mtcars)
  # Method 1: brute force
  new_data <- mtcars[mtcars$cyl==4 & mtcars$mpg>21 & mtcars$wt<2, ]
  # Method 2: use subset
  new_data2 <- subset(mtcars, mtcars$cyl==4 & mtcars$mpg>21 & mtcars$wt<2)
  # Method 3: use filter (need dplyr or tidyverse)
  new_data3 <- filter(mtcars, mtcars$cyl==4 & mtcars$mpg>21 & mtcars$wt<2)
  # Instead of using &, can just use comma
  new_data4 <- filter(mtcars, mtcars$cyl==4, mtcars$mpg>21, mtcars$wt<2)
  all_equal(new_data3, new_data4) # confirm new_data3 and new_data4 are the same

##### Part 2: Sorting with arrange() #####
  # syntax: arrange(dataset, col1, col2, ...), additional columns will break ties
  new_data5 <- arrange(mtcars, mpg, cyl, wt)
  # To arrange in descending order, use desc(col)
  new_data6 <- arrange(mtcars, desc(mpg))

##### Part 3: Select variables with select() #####
  new_data7 <- select(mtcars, mpg, hp)
  new_data8 <- select(mtcars, c(mpg, hp))
  all_equal(new_data7, new_data8)
# Quiz: what does select(mtcars, c(mpg, hp), everything()) do?

##### Part 4: Add new variables using existing columns with mutate() #####
  # syntax: mutate(dataset, new_var = some formula using existing vars)

##### Part 5: Grouped summaries with summarise() #####
  # Best used with group_by to provide summaries by group
  # This code calculate mean mpg by cyl
  by_cyl <- group_by(mtcars, cyl)
  summarise(by_cyl, mpg_avg = mean(mpg, na.rm = TRUE))

  # Note that this is the same as aggregate
  # aggregate() groups values at some higher level than they currently are 
  # (e.g. from agency to state, from day to month, from street to neighborhood) 
  # and does some mathematical operation of our choosing 
  # syntax: aggregate(numerical_column ~ category_column, FUN = math, data = )
  # - numerical column = column that we are doing the mathematical operation on
  # - category column = column we are using to group
  (aggregate(mpg~cyl, FUN = mean, mtcars))
  
  # Nicer if using the pipe
  mtcars %>% 
    group_by(cyl) %>% 
    summarise(
      count = n(), # helpful to include the count to know how many obs per group
      mpg_avg = mean(mpg, na.rm = TRUE)) %>%
    filter(cyl>=6)
# Functions that can go inside summarise(): mean(), median(), sd(), min(), max()

##### Part 6: Merging data #####
  # can use either merge() or dplyr::inner_join()
  # let's create some data
  dog_data <- data.frame(id = c("Duke", "Lucy", "Buddy", "Daisy", "Bear", "Stella"),
                         weight = c(25, 12, 58, 67, 33, 9),
                         sex=c("M", "F", "M", "F", "M", "F"),
                         location=c("north", "west", "north", "south", "west", "west"))
  more_dogs <- data.frame(id = c("Jack", "Luna"),
                          weight=c(38, -99),
                          sex=c("M", "F"),
                          location=c("east", "east"))
  # ensure two data frames have same columns
  names(dog_data)
  names(more_dogs)
  # append two data sets
  (all_dogs <- rbind(dog_data, more_dogs))
  
  # create another dataset 
  dog_vax <- data.frame(id = c("Luna", "Duke", "Buddy", "Stella", "Daisy", "Lucy", "Jack", "Bear", "Trung"),
                        vaccinated = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE))
  
  # merge using the "id" variable
  (dogs1 <- inner_join(all_dogs, dog_vax))
  (dogs1a <- full_join(all_dogs, dog_vax))
  # Note: full_join() shows the rows that are not matched
  
  # or can use the merge() function in base R
  (dogs2 <- merge(all_dogs, dog_vax, by.x="id", by.y="id"))
  (dogs2a <- merge(all_dogs, dog_vax, by.x="id", by.y="id", all = TRUE))
  # Note: all = TRUE shows the rows that are not matched