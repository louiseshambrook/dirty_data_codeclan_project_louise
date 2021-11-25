# Data Cleaning Script - Candy -------------------------------------------------

# Calling libraries
library(readr)
library(readxl)
library(dplyr)
library(here)
library(janitor)
library(stringr)
library(tidyverse)
library(assertr)
library(Hmisc)

# Loading datasets ---------------------------
candy_2015 <- read_xlsx(here::here("raw_data/boing-boing-candy-2015.xlsx"))
candy_2016 <- read_xlsx(here::here("raw_data/boing-boing-candy-2016.xlsx"))
candy_2017 <- read_xlsx(here::here("raw_data/boing-boing-candy-2017.xlsx"))

# 2015 Dataset Cleaning --------------------------------------------------------
clean_2015 <- clean_names(candy_2015)
# Cleaning names with janitor to better conform to tidy standard

clean_2015 <- clean_2015 %>%
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         hersheys_kissables = hershey_s_kissables)
# Renaming select variables to better identify their content

clean_2015 <- clean_2015 %>%
  relocate(necco_wafers, .after = york_peppermint_patties)
# moving the necco_wafers variable to ensure it is located with other sweets

clean_2015$year <- 2015
# adding the year data into the year column to identify the dataframe as belonging
# to 2015.

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
# There are 12 entries under "age" where the age can be identified.
# these have been corrected above.
# There are XX further entries where it is not possible to identify an age,
# e.g. "50's" - these have been dropped as the amount is too low to have an
# impact on the overall mean.
# There are also XX entries where it is outright impossible to identify an age,
# e.g. "too old to care". These have been dropped, as there are too few to
# impact the results.

clean_2015 <- clean_2015 %>%
  transform(age = as.numeric(age))
# The age column has been changed to numeric, which also changes invalid
# responses to NA.

clean_2015 <- clean_2015 %>%
  mutate(age = na_if(age, 1.23000e+02)) %>%
  mutate(age = na_if(age, 9.00000e+22)) %>%
  mutate(age = na_if(age, 1.88000e+03)) %>%
  mutate(age = na_if(age, 2.00587e+05)) %>%
  mutate(age = na_if(age, 9.90000e+01)) %>%
  mutate(age = na_if(age, 1.00000e+02)) %>%
  mutate(age = na_if(age, 1.15000e+02)) %>%
  mutate(age = na_if(age, 3.88000e+02)) %>%
  mutate(age = na_if(age, 1.20000e+02)) %>%
  mutate(age = na_if(age, 1.08000e+02)) %>%
  mutate(age = na_if(age, Inf)) %>%
  mutate(age = na_if(age, 9.90000e+01)) %>%
  mutate(age = na_if(age, 2.00000e+03)) %>%
  mutate(age = na_if(age, 3.50000e+02)) %>%
  mutate(age = na_if(age, 4.00000e+02)) %>%
  mutate(age = na_if(age, 8.50000e+01)) %>%
  mutate(age = na_if(age, 9.70000e+01)) %>%
  mutate(age = na_if(age, 4.90000e+02)) %>%
  mutate(age = na_if(age, 350))
# There are the above repsonses identified by assertive programming, which are 
# valid numbers, but invalid (logical) responses. These have been changed to NA.

clean_2015 <- clean_2015 %>%
  add_column(gender = NA, .after = "going_out") %>%
  add_column(country = NA, .after = "gender") %>%
  add_column(state = NA, .after = "country")
# The columns "gender", "country", and "state" have been added, to ensure
# the data aligns for joining the data together.

clean_2015 <- clean_2015 %>%
  select(-101, -102, -103, -104, -105, -106, -107, -108, -109, -110, -111, 
         -112, -113, -114, -115, -116, -117, -118, -119, -120, -121, -122,
         -123, -124, -125, -126, -127)
# The columns 101-127 have been dropped, as these will not be used in this
# analysis. 

clean_2015 <- clean_2015 %>%
  rename(hundred_grand_bar = x100_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = 
           anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         bonkers_the_candy = bonkers,
         boxo_raisins = box_o_raisins,
         hersheys_dark_chocolate = dark_chocolate_hershey,
         licorice_yes_black = licorice,
         sweetums_a_friend_to_diabetes = sweetums)
# The above columns have been renamed to ensure they align with the 2017
# dataset for joining. 

clean_2015 <- clean_2015 %>%
  add_column(bonkers_the_board_game = NA) %>%
  add_column(chardonnay = NA) %>%
  add_column(coffee_crisp = NA) %>%
  add_column(hersheys_kisses = NA) %>%
  add_column(mike_and_ike = NA) %>%
  add_column(blue_m_ms = NA) %>%
  add_column(red_m_ms = NA) %>%
  add_column(green_party_m_ms = NA) %>%
  add_column(independent_m_ms = NA) %>%
  add_column(abstained_from_m_ming = NA) %>%
  add_column(mr_goodbar = NA) %>%
  add_column(peeps = NA) %>%
  add_column(real_housewives_of_orange_county_season_9_blue_ray = NA) %>%
  add_column(reeses_pieces = NA) %>%
  add_column(sandwich_sized_bags_filled_with_boo_berry_crunch = NA) %>%
  add_column(sourpatch_kids_i_e_abominations_of_nature = NA) %>%
  add_column(sweet_tarts = NA) %>%
  add_column(take_5 = NA) %>%
  add_column(tic_tacs = NA) %>%
  add_column(whatchamacallit_bars = NA) %>%
  add_column(dove_bars = NA) %>%
  add_column(mary_janes = NA) %>%
  add_column(third_party_m_ms = NA) %>%
  add_column(person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes = NA)
# The above columns have been added to ensure the dataframe aligns with
# the 2016 and 2017 datasets for joining.

clean_2015 <- clean_2015 %>%
  select(year, age, going_out, gender, country, state, hundred_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes,
         any_full_sized_candy_bar, black_jacks ,bonkers_the_candy,
         bonkers_the_board_game, bottle_caps, boxo_raisins, broken_glow_stick,
         butterfinger, cadbury_creme_eggs, candy_corn,
         candy_that_is_clearly_just_the_stuff_given_out_for_free_at_restaurants,
         caramellos, cash_or_other_forms_of_legal_tender, chardonnay, 
         chick_o_sticks_we_don_t_know_what_that_is, chiclets, coffee_crisp,
         creepy_religious_comics_chick_tracts, dental_paraphenalia, dots, 
         dove_bars, fuzzy_peaches, generic_brand_acetaminophen, glow_sticks,
         goo_goo_clusters, good_n_plenty, gum_from_baseball_cards,
         gummy_bears_straight_up, hard_candy, healthy_fruit, heath_bar,
         hersheys_dark_chocolate, hershey_s_milk_chocolate, hersheys_kisses,
         hugs_actual_physical_hugs, jolly_rancher_bad_flavor,
         jolly_ranchers_good_flavor, joy_joy_mit_iodine, junior_mints,
         senior_mints, kale_smoothie, kinder_happy_hippo, kit_kat, laffy_taffy,
         lemon_heads, licorice_not_black, licorice_yes_black, lindt_truffle,
         lollipops, mars, maynards, mike_and_ike, milk_duds, milky_way,
         regular_m_ms, peanut_m_m_s, blue_m_ms, red_m_ms, green_party_m_ms,
         independent_m_ms, abstained_from_m_ming, minibags_of_chips, mint_kisses,
         mint_juleps, mr_goodbar, necco_wafers, nerds, nestle_crunch, nown_laters,
         peeps, pencils, pixy_stix, real_housewives_of_orange_county_season_9_blue_ray,
         reese_s_peanut_butter_cups, reeses_pieces, reggie_jackson_bar, rolos,
         sandwich_sized_bags_filled_with_boo_berry_crunch, skittles,
         smarties_american, smarties_commonwealth, snickers,
         sourpatch_kids_i_e_abominations_of_nature, spotted_dick, starburst,
         sweet_tarts, swedish_fish, sweetums_a_friend_to_diabetes, take_5, tic_tacs,
         those_odd_marshmallow_circus_peanut_things, three_musketeers,
         tolberone_something_or_other, trail_mix, twix,
         vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
         vicodin, whatchamacallit_bars, white_bread, whole_wheat_anything,
         york_peppermint_patties, brach_products_not_including_candy_corn,
         bubble_gum, hersheys_kissables, lapel_pins, runts, mint_leaves,
         mint_m_ms, ribbon_candy, peanut_butter_jars, peanut_butter_bars,
         peterson_brand_sidewalk_chalk, mary_janes, third_party_m_ms,
         person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes)
# The order of the columns has been set, so that the rows will bind correctly.

# 2016 Dataset Cleaning --------------------------------------------------------

clean_2016 <- clean_names(candy_2016)
# Cleaning names with janitor to better conform to tidy standard

clean_2016 <- clean_2016 %>%
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         gender = your_gender,
         country = which_country_do_you_live_in,
         state = which_state_province_county_do_you_live_in
  )
# Renaming select variables to better identify their content

clean_2016 <- clean_2016 %>%
  select(-107, -108, -109, -110, -111, 
         -112, -113, -114, -115, -116, -117, -118, -119, -120, -121, -122,
         -123)
# The columns 107-123 have been dropped, as these will not be used in this
# analysis. 

clean_2016$year <- 2016
# adding the year data into the year column to identify the dataframe as belonging
# to 2016.

# There are no entries under "age" where the age can be identified.
# There are 34 further entries where it is not possible to identify an age,
# e.g. "50's" or "old enough" - these have been dropped as the amount is too
# low to have an impact on the overall mean.

clean_2016 <- clean_2016 %>%
  transform(age = as.numeric(age))
# The age column has been changed to numeric, which also changes invalid
# responses to NA.
  
clean_2016 <- clean_2016 %>%
  relocate(age, .after = year)
# Moving the age column to ensure it aligns with 2015 and 2017 dataset

clean_2016 <- clean_2016 %>%
  mutate(age = na_if(age, 8.10e+01)) %>%
  mutate(age = na_if(age, 1.00e+18)) %>%
  mutate(age = na_if(age, 8.20e+01)) %>%
  mutate(age = na_if(age, 1.42e+02)) %>%
  mutate(age = na_if(age, 142))
# There are the above repsonses identified by assertive programming, which are 
# valid numbers, but invalid (logical) responses. These have been changed to NA.

clean_2016 <- clean_2016 %>%
  mutate(country = na_if(country, "A tropical island south of the equator")) %>%
  mutate(country = na_if(country, "Neverland")) %>%
  mutate(country = na_if(country, "51.0")) %>%
  mutate(country = na_if(country, "47.0")) %>%
  mutate(country = na_if(country, "54.0")) %>%
  mutate(country = na_if(country, "44.0")) %>%
  mutate(country = na_if(country, "45.0")) %>%
  mutate(country = na_if(country, "30.0")) %>%
  mutate(country = na_if(country, "one of the best ones")) %>%
  mutate(country = na_if(country, "there isn't one for old men")) %>%
  mutate(country = na_if(country, "god's country")) %>%
  mutate(country = na_if(country, "see above")) %>%
  mutate(country = na_if(country, "45.0")) %>%
  mutate(country = na_if(country, "this one")) %>%
  mutate(country = na_if(country, "somewhere")) %>%
  mutate(country = na_if(country, "Somewhere")) %>%
  mutate(country = na_if(country, "EUA")) %>%
  mutate(country = na_if(country, "Cascadia")) %>%
  mutate(country = na_if(country, "Trumpistan")) %>%
  mutate(country = na_if(country, "See above")) %>%
  mutate(country = na_if(country, "Not the USA or Canada")) %>%
  mutate(country = na_if(country, "The republic of Cascadia")) %>%
  mutate(country = na_if(country, "Denial"))

clean_2016 <- clean_2016 %>%
  mutate(country = str_replace(country, "^usa$|^US$|^uSA$|^U.S.A$|^USA!$|^Us$|^Murica$|^USA! USA! USA!$|
                               ^the best one - usa$|^united states$|^United States of America$|^us$|
                               ^U.S.A.$|^America$|^The Yoo Ess of Aaayyyyyy$|
                               ^Units States$|^United states$|
                               ^USA!!!!!!$|^USSA$|^U.S.A.$|^Usa$|^U.S.A.$
                               |^Units States$|^united states of america$
                               |^Sub-Canadian North America... 'Merica$", "USA")) %>%
  mutate(country = str_replace(country, "^United States$|
                               ^USA (I think but it's an election year so who can really tell)$
                               |^USA USA USA$|^U.S.$|^u.s.$
                               |^united states of america$|^USA!!!!!!$
                               |^USA! USA!$|^United Sates$|^UNited States$
                               |^Merica$|^UNited States$|^america$
                               |^United State$", "USA"))

clean_2016 <- clean_2016 %>%
  mutate(country = str_replace(country, "^England$|^United Kingdom$|^uk$|
                               ^United Kindom$|^england$", "UK"))

clean_2016 <- clean_2016 %>%
  mutate(country = str_replace(country, "^canada$", "Canada")) %>%
  mutate(country = str_replace(country, "^france$" , "France")) %>%
  mutate(country = str_replace(country, "^belgium$", "Belgium")) %>%
  mutate(country = str_replace(country, "^croatia$", "Croatia")) %>%
  mutate(country = str_replace(country, "^españa$", "Spain")) %>%
  mutate(country = str_replace(country, "^sweden$", "Sweden")) %>%
  mutate(country = str_replace(country, "^germany$" , "Germany")) %>%
  mutate(country = str_replace(country, "^netherlands$|^The Netherlands$",
                               "Netherlands")) %>%
  mutate(country = str_replace(country, "^kenya$", "Kenya")) %>%
  mutate(country = str_replace(country, "^hungary$", "Hungary"))

# The column country has been cleaned to change incorrect values to NA so that
# accurate analysis can be completed

clean_2016 <- clean_2016 %>%
  rename(hundred_grand_bar = x100_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes =
           anonymous_brown_globs_that_come_in_black_and_orange_wrappers)
# The above columns have been renamed to ensure they align with the 2017
# dataset for joining. 

clean_2016 <- clean_2016 %>%
  add_column(green_party_m_ms = NA) %>%
  add_column(independent_m_ms = NA) %>%    
  add_column(abstained_from_m_ming = NA) %>%    
  add_column(real_housewives_of_orange_county_season_9_blue_ray = NA) %>%    
  add_column(sandwich_sized_bags_filled_with_boo_berry_crunch = NA) %>%    
  add_column(take_5 = NA) %>%
  add_column(brach_products_not_including_candy_corn = NA) %>%
  add_column(bubble_gum = NA) %>%
  add_column(hersheys_kissables = NA) %>%
  add_column(lapel_pins = NA) %>%
  add_column(runts = NA) %>%
  add_column(mint_leaves = NA) %>%
  add_column(mint_m_ms = NA) %>%
  add_column(ribbon_candy = NA) %>%
  add_column(peanut_butter_jars = NA) %>%
  add_column(peanut_butter_bars = NA) %>%
  add_column(peterson_brand_sidewalk_chalk = NA)
# The above columns have been added to ensure the dataframe aligns with
# the 2015 and 2017 datasets for joining.

clean_2016 <- clean_2016 %>%
  select(year, age, going_out, gender, country, state, hundred_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes,
         any_full_sized_candy_bar, black_jacks ,bonkers_the_candy,
         bonkers_the_board_game, bottle_caps, boxo_raisins, broken_glow_stick,
         butterfinger, cadbury_creme_eggs, candy_corn,
         candy_that_is_clearly_just_the_stuff_given_out_for_free_at_restaurants,
         caramellos, cash_or_other_forms_of_legal_tender, chardonnay, 
         chick_o_sticks_we_don_t_know_what_that_is, chiclets, coffee_crisp,
         creepy_religious_comics_chick_tracts, dental_paraphenalia, dots, 
         dove_bars, fuzzy_peaches, generic_brand_acetaminophen, glow_sticks,
         goo_goo_clusters, good_n_plenty, gum_from_baseball_cards,
         gummy_bears_straight_up, hard_candy, healthy_fruit, heath_bar,
         hersheys_dark_chocolate, hershey_s_milk_chocolate, hersheys_kisses,
         hugs_actual_physical_hugs, jolly_rancher_bad_flavor,
         jolly_ranchers_good_flavor, joy_joy_mit_iodine, junior_mints,
         senior_mints, kale_smoothie, kinder_happy_hippo, kit_kat, laffy_taffy,
         lemon_heads, licorice_not_black, licorice_yes_black, lindt_truffle,
         lollipops, mars, maynards, mike_and_ike, milk_duds, milky_way,
         regular_m_ms, peanut_m_m_s, blue_m_ms, red_m_ms, green_party_m_ms,
         independent_m_ms, abstained_from_m_ming, minibags_of_chips, mint_kisses,
         mint_juleps, mr_goodbar, necco_wafers, nerds, nestle_crunch, nown_laters,
         peeps, pencils, pixy_stix, real_housewives_of_orange_county_season_9_blue_ray,
         reese_s_peanut_butter_cups, reeses_pieces, reggie_jackson_bar, rolos,
         sandwich_sized_bags_filled_with_boo_berry_crunch, skittles,
         smarties_american, smarties_commonwealth, snickers,
         sourpatch_kids_i_e_abominations_of_nature, spotted_dick, starburst,
         sweet_tarts, swedish_fish, sweetums_a_friend_to_diabetes, take_5, tic_tacs,
         those_odd_marshmallow_circus_peanut_things, three_musketeers,
         tolberone_something_or_other, trail_mix, twix,
         vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein,
         vicodin, whatchamacallit_bars, white_bread, whole_wheat_anything,
         york_peppermint_patties, brach_products_not_including_candy_corn,
         bubble_gum, hersheys_kissables, lapel_pins, runts, mint_leaves,
         mint_m_ms, ribbon_candy, peanut_butter_jars, peanut_butter_bars,
         peterson_brand_sidewalk_chalk, mary_janes, third_party_m_ms,
         person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes)
# The order of the columns has been set, so that the rows will bind correctly.

# 2017 Cleaning ----------------------------------------------------------------

clean_2017 <- clean_names(candy_2017)
# Cleaning names with janitor to better conform to tidy standard

clean_2017 <- clean_2017 %>%
  rename(going_out = q1_going_out,
         gender = q2_gender,
         age = q3_age,
         country = q4_country,
         state = q5_state_province_county_etc,
         year = internal_id)

# Renaming select variables to better identify their content

clean_2017 <- clean_2017 %>%
  select(-110, -111, -112, -113, -114, -115, -116, -117, -118, -119, -120)
# The columns 110-120 have been dropped, as these will not be used in this
# analysis. 

clean_2017$year <- 2017
# adding the year data into the year column to identify the dataframe as belonging
# to 2016.

clean_2017$age[clean_2017$age == "sixty-nine"] <- 69
clean_2017$age[clean_2017$age == "46 Halloweens"] <- 46

# There are 2 entries under "age" where the age can be identified.
# These are corrected above.

# There are XX further entries where it is not possible to identify an age,
# e.g. "50's" - these have been dropped as the amount is too low to have an
# impact on the overall mean.

# There are also XX entries where it is outright impossible to identify an age,
# e.g. "too old to care". These have been dropped, as there are too few to
# impact the results.

clean_2017 <- clean_2017 %>%
  transform(age = as.numeric(age))
# The age column has been changed to numeric, which also changes invalid
# responses to NA.

clean_2017 <- clean_2017 %>%
  relocate(age, .after = year)
# Moving the age column to ensure it aligns with 2015 and 2017 dataset

clean_2017 <- clean_2017 %>%
  mutate(age = na_if(age, 90)) %>%
  mutate(age = na_if(age, 312)) %>%
  mutate(age = na_if(age, 99)) %>%
  mutate(age = na_if(age, 88)) %>%
  mutate(age = na_if(age, 102)) %>%
  mutate(age = na_if(age, 100)) %>%
  mutate(age = na_if(age, 1000))
# There are the above repsonses identified by assertive programming, which are 
# valid numbers, but invalid (logical) responses. These have been changed to NA.

clean_2017 <- clean_2017 %>% 
  rename_with(.cols = starts_with("q6_"), .fn = ~str_replace(.x, "q6_", ""))
# In this dataset, the survey columns start with q6-, which has been dropped
# here.

clean_2017 <- clean_2017 %>%
  rename(hundred_grand_bar = "100_grand_bar")

clean_2017 <- clean_2017 %>%
  mutate(country = na_if(country, "35")) %>%
  mutate(country = na_if(country, "Earth")) %>%
  mutate(country = na_if(country, "Europe")) %>%
  mutate(country = na_if(country, "46")) %>%
  mutate(country = na_if(country, "insanity lately")) %>%
  mutate(country = na_if(country, "45")) %>%
  mutate(country = na_if(country, "32")) %>%
  mutate(country = na_if(country, "Can")) %>%
  mutate(country = na_if(country, "Canae")) %>%
  mutate(country = na_if(country, "Trumpistan")) %>%
  mutate(country = na_if(country, "New York")) %>%
  mutate(country = na_if(country, "Endland")) %>%
  mutate(country = na_if(country, "soviet canuckistan")) %>%
  mutate(country = na_if(country, "1")) %>%
  mutate(country = na_if(country, "I don't know anymore")) %>%
  mutate(country = na_if(country, "subscribe to dm4uz3 on youtube")) %>%
  mutate(country = na_if(country, "Fear and Loathing")) %>%
  mutate(country = na_if(country, "cascadia")) %>%
  mutate(country = na_if(country, "I pretend to be from Canada, but I am really from the United States.")) %>%
  mutate(country = na_if(country, "Ahem....Amerca")) %>%
  mutate(country = na_if(country, "UD")) %>%
  mutate(country = na_if(country, "endland")) %>%
  mutate(country = na_if(country, "Atlantis")) %>%
  mutate(country = na_if(country, "N. America")) %>%
  mutate(country = na_if(country, "Narnia"))

clean_2017 <- clean_2017 %>%
  mutate(country = str_replace(country, "^us$|^usa$|^Us$|^US$|^United States of America$|
                               ^United Staes$|^u.s.a$|^Usa$|^USAUSAUSA$|^america$|
                               ^U.S.A$|^united states$|^Murica$|^United staes$|
                               ^United states$|^u.s.a$|^u.s.a.$|^U.S.A.$|
                               ^united states of america$|^US of A$|
                               ^united states of america$|^The United States$
                               |^Unites States$|^Unied States$|^U S$|
                               ^U.S.$|^North Carolina$|
                               ^The United States of America$|^USA? Hard to tell anymore..$
                               |^'merica$|^usas$|^Pittsburgh$|^United State$|^New York$", "USA")) %>%
  mutate(country = str_replace(country, "^United States$|^unhinged states$|^$
                               |^The United States of America$|^unite states$
                               |^U.S.$|^u.s.$|^A$|^United Sates$|^California$
                               |^USa$|^United Stated$|^New Jersey$
                               |^unite states$|^United ststes$|^United Statss$
                               |^murrika$|^USA! USA! USA!$|^USAA$|^Alaska$
                               |^united States$|^United Statea$|^America$
                               |^	USA USA USA!!!!$|^California$ ", "USA"))

clean_2017 <- clean_2017 %>%
  mutate(country = str_replace(country, "^canada$|^Canada`$|^CANADA$", "Canada")) %>%
  mutate(country = str_replace(country, "^france$" , "France")) %>%
  mutate(country = str_replace(country, "^germany$" , "Germany")) %>%
  mutate(country = str_replace(country, "^finland$", "Finland")) %>%
  mutate(country = str_replace(country, "^australia$", "Australia")) %>%
  mutate(country = str_replace(country, "^finland$", "Finland")) %>%
  mutate(country = str_replace(country, "^The Netherlands$", "Netherlands")) %>%
  mutate(country = str_replace(country, "^hong kong$", "Hong Kong")) %>%
  mutate(country = str_replace(country, "^spain$", "Spain"))

clean_2017 <- clean_2017 %>%
  mutate(country = str_replace(country, "^England$|^United Kingdom$|^uk$|
                               ^United Kindom$|^U.K.$|^Uk$|^Scotland$|
                               ^United kingdom$", "UK"))
# The column country has been cleaned to change incorrect values to NA so that
# accurate analysis can be completed

# No datasets were needed to be renamed, as the names were defined by the
# 2017 dataset.

clean_2017 <- clean_2017 %>%
  add_column(brach_products_not_including_candy_corn = NA) %>%
  add_column(bubble_gum = NA) %>%
  add_column(hersheys_kissables = NA) %>%
  add_column(lapel_pins = NA) %>%
  add_column(runts = NA) %>%
  add_column(mint_leaves = NA) %>%
  add_column(mint_m_ms = NA) %>%
  add_column(ribbon_candy = NA) %>%
  add_column(peanut_butter_jars = NA) %>%
  add_column(peanut_butter_bars = NA) %>%
  add_column(peterson_brand_sidewalk_chalk = NA) %>%
  add_column(mary_janes = NA) %>%
  add_column(third_party_m_ms = NA) %>%
  add_column(person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes = NA)
# The above columns have been added to ensure the dataframe aligns with
# the 2015 and 2016 datasets for joining.

# Joining ----------------------------------------------------------------------

joined_candy <- bind_rows(clean_2015, clean_2016, clean_2017)

# Saving -----------------------------------------------------------------------
  write_csv(joined_candy, file = "clean_data/joined_candy")

