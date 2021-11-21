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

# Suggested method -----------------------------
# Clean each dataset individually
# For each dataset:
# Step 1. Clean column names using tidyr / cleanr.
# Step 2. Change column names to remove the [].
# Step 3. Change column names to confirm to best practice, e.g. "how old are you"
# will become "age".
# Step 4. Clean age column to change string answers to NA.
# Step 5. Change age column type to numeric.

# For 2015:
# Change timestamp to year - 2015.

# For 2016 and 2017. 
# Clean country names; ensure all countries are capitalised.
# Change all versions of USA to USA, and similar for other countries.
# Remove incorrect strings. 
# Clean state column, i.e. ensure all strings are correct.
# Change all USA and canadian states to same format, e.g. TN, USA

# To join the datasets together.
# Pivot each table to have the year in the column heading, and values in rows.
# Join them from there.

