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

## Analysis answers
All the set questions were completed.
- What is the total number of candy ratings given across the three years. 
(Number of candy ratings, not the number of raters. Don’t count missing values)
- What was the average age of people who are going out trick or treating? (34.8465)
- What was the average age of people who are not going trick or treating? (39.06105)
- For each of joy, despair and meh, which candy bar received the most of these ratings? (JOY, any_full_sized_candy_bar; MEH, lollipops; DESPAIR, broken_glow_stick)
- How many people rated Starburst as despair? (1990)

For the following questions, a dataframe was ceated where JOY, DESPAIR, and MEH to +1, -1 and 0 were rated as respectively.
- What was the most popular candy bar by this rating system for each gender in
the dataset ? (Female, any_full_sized_candy_bar; Male, hundred_grand_bar)
- What was the most popular candy bar in each year? (2015, any_full_sized_candy_bar; 2016, any_full_sized_candy_bar; 2017, any_full_sized_candy_bar)
- What was the most popular candy bar by this rating for people in US, Canada,
UK, and all other countries? (USA, any_full_sized_candy_bar; Canada, any_full_sized_candy_bar; UK, cash_or_other_forms_of_legal_tender; Other countries, any_full_sized_candy_bar)


## Other observations
- The research that the original researchers have done on whether a measure of character has an impact on their candy rating is interesting.
- I find it curious (concering?) that the same result comes out nearly always on top, i.e. "any full sized any candy", however, given the measure of how I assume this data has been captured, people could be ticking this option, whilst also specifying their chosen candy bar, or not.

- Side-note; I was concerned whether my analysis was correct. Therefore I checked the source material. Indeed, any full-sized candy bar ranks on top as of 2019 which aligns with my results.
