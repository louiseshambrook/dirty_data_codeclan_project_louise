# dirty_data project task 4 louise

This is a project developed for module 1 of CodeClan.

### Brief Introduction to the dataset
This dataset is based on data from David Ng and Ben Cohen. They have previously ranked candy based on their location
in geological strata, for trick or treating purposes. As of 2019, this has 
become a way of measuring "net feelies" when trick or treating, for a wide range
of candies, which critically includes items such as hugs, glow sticks and bread.
Source: https://boingboing.net/author/davidng2

### Brief introductions to assumptions
- I intially assumed the dataset was complete, i.e. that the columns were correct
(should be there).
- I later assummed some columns could/should be dropped, and then attempted to delete too many.
- I assumed that the columns should remain intact with their data, across the 3 years.
- I assumed that respondents will generally only be from the US and Canada.
- I assumed that age will only be given in whole numbers.
- I assumed that the joined table did not / could not be pivoted, due to the large amount of data collected. 

### Steps to clean the data
For all 3 datasets:
- Using janitor to clean the column names.
- Renaming select variables to ensure that their data could be identified
- Relocating columns
- Changing the timestamp to the year.
- Changing inaccurate age responses to either the given answer (e.g. "40, deal" to 40, or dropping). 
- Transforming the age column to numeric.
- Adding missing columns, e.g. gender, or missing candy columns
- Dropping columns, e.g. the columns which surveyed character, as that would not be examined in this analysis
- Renaming columns to align the names across the years
- Setting the order to align the order across the years
- Joining the 3 years together by using bind_rows
- Saving to csv.

- For some of the analysis questions, the dataframe has been manipulated to change JOY, DESPAIR, and MEH to +1, -1 and 0 respectively.

## Analysis answers
- What is the total number of candy ratings given across the three years.
(Number of candy ratings, not the number of raters. Don’t count missing values)
- What was the average age of people who are going out trick or treating?
- What was the average age of people who are not going trick or treating?
- How many people rated Starburst as despair?
- What was the most popular candy bar by this rating system for each gender in
the dataset ?
- What was the most popular candy bar by this rating for people in US, Canada,
UK, and all other countries?
- For each of joy, despair and meh, which candy bar received the most of these ratings?
- What was the most popular candy bar in each year?

## Other observations
- The research that the original researchers have done on whether a measure of character has an impact on their candy rating is interesting.
- It is interesting to note that the same candy came out on top in my results, for several countries. 
