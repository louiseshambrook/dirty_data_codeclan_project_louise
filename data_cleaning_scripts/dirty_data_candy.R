# Data Cleaning Script ---------------------------

# Calling libraries

library(readr)
library(readxl)
library(dplyr)
library(here)

# Loading  datasets ---------------------------

candy_2015 <- read_xlsx(here::here("raw_data/boing-boing-candy-2015.xlsx"))
candy_2016 <- read_xlsx(here::here("raw_data/boing-boing-candy-2016.xlsx"))
candy_2017 <- read_xlsx(here::here("raw_data/boing-boing-candy-2017.xlsx"))

# Initial exploration ---------------------------
names(candy_2015)
names(candy_2016)
names(candy_2017)

head(candy_2015)
head(candy_2016)
head(candy_2017)

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

# EXTENSION
# Step 7. For the "please leave"/"please List" columns, create a coding matrix,
# code the data.
# Step 8. Mints - change all non-numeric data to numeric.
# Step 9. Betty/Ver - Change all ?? to NA.
# Step 10. "Check all that apply" - split columns.
# Step 11. Add NA's to all the "random" columns in the blanks.

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
  transform(age = as.numeric(age))
# changing age column type, and at the same time, changing strings to NA 
# by coercion

clean_2015 <- clean_2015 %>%
  relocate(necco_wafers, .after = york_peppermint_patties)
# moving the necco wafers column to after york peppermint

clean_2015$year <- 2015
# reassigning the year column to 2015

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
# cleaning column names

# the columns at the end, i.e "please estimate" etc have NOT been changed, as 
# I am not sure of the extent to which I am keeping these

clean_2016 <- clean_2016 %>%
  transform(age = as.numeric(age))
# changing age column type, and at the same time, changing strings to NA 
# by coercion

clean_2016$year <- 2016
# reassigning the year column to 2015