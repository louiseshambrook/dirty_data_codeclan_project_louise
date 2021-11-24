# Data Cleaning Script ---------------------------

# Calling libraries

library(readr)
library(readxl)
library(dplyr)
library(here)

# Loading datasets ---------------------------

candy_2015 <- read_xlsx(here::here("raw_data/boing-boing-candy-2015.xlsx"))
candy_2016 <- read_xlsx(here::here("raw_data/boing-boing-candy-2016.xlsx"))
candy_2017 <- read_xlsx(here::here("raw_data/boing-boing-candy-2017.xlsx"))



# Initial thoughts -----------------------------
# The columns are a bit troublesome, and don't really align with the data posted
# on the official site.
# The data in the country column will require cleaning.
# The type of the country column is character.

# DRAFT PLAN -----------------------------
# Clean each dataset individually and then join them.
# For each dataset

# MVP
# Step 1. Clean column names using tidyr / cleanr.
# Step 2. Change column names to remove the [].
# Step 3. Change column names to confirm to best practice, e.g. "how old are you"
# will become "age".
# Find all string answers and consider if there's a better method? Dropped a
# Step 4. Clean age column to change string answers to NA.
# Step 5. Change age column type to numeric.
# Step 6. Necco wafers - move to after york peppermints.
# - 2015 doesn't have gender, and 2016/2017 does

# For 2015:
# Change timestamp to year - 2015.

# For 2016 and 2017. 
# Clean country names; ensure all countries are capitalised.
# Change all versions of USA to USA, and similar for other countries.
# Remove incorrect strings. 
# Clean state column, i.e. ensure all strings are correct.
# Change all USA and canadian states to same format, e.g. TN, USA

# 2017 - remove the column after dress question (blank title)

# To join the datasets together.
# To make joining easier, should I drop the columns at the end? 
# Pivot each table to have the year in the column heading, and values in rows.
# Join them from there.

# 2015 CLEANING  --------------------------------------------------------------
clean_2015 <- clean_names(candy_2015)
# cleaning column names using clean_names from janitor package

clean_2015 <- clean_2015 %>%
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         hersheys_kissables= hershey_s_kissables,
         hersheys_milk_chocolate = hershey_s_milk_chocolate,
         remarks_or_comments = please_leave_any_remarks_or_comments_regarding_your_choices,
         items_not_included_joy = please_list_any_items_not_included_above_that_give_you_joy,
         items_not_included_despair = please_list_any_items_not_included_above_that_give_you_despair
  )
# cleaning column names

# the columns at the end, i.e "please estimate" etc have NOT been changed, as 
# I am not sure of the extent to which I am keeping these

clean_2015 <- clean_2015 %>%
  relocate(necco_wafers, .after = york_peppermint_patties)
# moving the necco wafers column to after york peppermint

clean_2015$year <- 2015
# reassigning the year column to 2015

# Cleaning the age column
# There are 12 answers which indicate a specific answer, e.g. "40. Deal with it".
# There are multiple which reference a vague answer, e.g "50s". It is not
# reasonable to assume their answer - if there is time, I will go back and
# replace these with "vague" (or similar). Then there are the outright "invalid"
# answers, e.g. "old enough" which do not reference an age. These are NA.

clean_2015$age[clean_2015$age == "45, but the 8-year-old Huntress and
                 bediapered Unicorn give me political cover and social
                 respectability.  However, I WILL eat more than they do
                 combined."] <- 45
clean_2015$age[clean_2015$age == "37 (I'm taking a child)"] <- 37
clean_2015$age[clean_2015$age == "Good Lord!  I'm 43!"] <- 43
clean_2015$age[clean_2015$age == "46:"] <- 46
clean_2015$age[clean_2015$age == "40. Deal with it. "] <- 40
clean_2015$age[clean_2015$age == "37,"] <- 37
clean_2015$age[clean_2015$age == "50 (despair)"] <- 50
clean_2015$age[clean_2015$age == "27^"] <- 27
clean_2015$age[clean_2015$age == "50, taking a 13 year old."] <- 50
clean_2015$age[clean_2015$age == "42 - I'm taking my kid"] <- 42
clean_2015$age[clean_2015$age == "42 - I'm taking my kid"] <- 42
clean_2015$age[clean_2015$age == "50t"] <- 50 


# There are also 12 column names with vague answers. If I have time, I will
# go back and correct these.
# For now, I will drop them.

clean_2015 <- clean_2015 %>%
  transform(age = as.numeric(age))
# changing age column type, and at the same time, changing strings to NA 
# by coercion

# Add a gender column??


# 2016 CLEANING ---------------------------------------------------------------

clean_2016 <- clean_names(candy_2016)
# cleaning column names using clean_names from janitor package

clean_2016 <- clean_2016 %>%
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         gender = your_gender,
         country = which_country_do_you_live_in,
         state = which_state_province_county_do_you_live_in,
         hersheys_milk_chocolate = hershey_s_milk_chocolate,
  )
# There are none further to change.
# the columns at the end, i.e "please estimate" etc have NOT been changed, as 
# I am not sure of the extent to which I am keeping these

# Cleaning the age column
# There are none which indicate a specific answer.
# There are 5 which reference a vague answer, e.g "50s". It is not
# reasonable to assume their answer - if there is time, I will go back and
# replace these with "vague" (or similar). Then there are the outright "invalid"
# answers, e.g. "old enough" which do not reference an age. These are NA.

clean_2016 <- clean_2016 %>%
  transform(age = as.numeric(age))
# changing age column type, and at the same time, changing strings to NA 
# by coercion

clean_2016$year <- 2016
# reassigning the year column to 2016

# Cleaning the country column
# Cleaning country names



# Change all versions of USA to USA, and similar for other countries.

# Remove incorrect strings. 

# Clean state column, i.e. ensure all strings are correct.

# Change all USA and canadian states to same format, e.g. TN, USA


# 2017 Cleaning --------------------------------------------------------------
clean_2017 <- clean_names(candy_2017)
# cleaning column names using clean_names from janitor package

# need to do an across or something to remove q6 from 7-109.

# Manually change these
# [2] "q1_going_out"                                                                    
# [3] "q2_gender"                                                                       
# [4] "q3_age"                                                                          
# [5] "q4_country"                                                                      
# [6] "q5_state_province_county_etc"                                                    
# [110] "q7_joy_other"                                                                    
# [111] "q8_despair_other"                                                                
# [112] "q9_other_comments"                                                               
# [113] "q10_dress"                                                                       
# [114] "x114"                                                                            
# [115] "q11_day"                                                                         
# [116] "q12_media_daily_dish"                                                            
# [117] "q12_media_science"                                                               
# [118] "q12_media_espn"                                                                  
# [119] "q12_media_yahoo"                                                                 
# [120] "click_coordinates_x_y"  

# clean_2015 <- clean_2015 %>%
#   rename(age = how_old_are_you,
#   )
# cleaning column names

# Remove column 114


clean_2017$internal_id <- 2017
# reassigning the internal_id column to 2017

# Cleaning the age column
# There are 2 answers which indicate a specific answer, e.g. "40. Deal with it".
# There are 5 which reference a vague answer, e.g. "50's". It is not
# reasonable to assume their answer - if there is time, I will go back and
# replace these with "vague" (or similar). Then there are the outright "invalid"
# answers, e.g. "old enough" which do not reference an age. These are NA.


# These are the two to be corrected
# sixty-nine
# 46 Halloweens.


#Syntax
clean_2015$age[clean_2015$age == "45, but the 8-year-old Huntress and
                 bediapered Unicorn give me political cover and social
                 respectability.  However, I WILL eat more than they do
                 combined."] <- 45

clean_2015 <- clean_2015 %>%
  transform(age = as.numeric(age))
# Changing age column type, and at the same time, changing strings to NA 
# by coercion

# Cleaning country names


country names; ensure all countries are capitalised.

# Change all versions of USA to USA, and similar for other countries.

# Remove incorrect strings. 

# Clean state column, i.e. ensure all strings are correct.

# Change all USA and canadian states to same format, e.g. TN, USA