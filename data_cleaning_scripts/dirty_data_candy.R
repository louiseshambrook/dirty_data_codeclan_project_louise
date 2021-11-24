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

# Loading datasets ---------------------------
candy_2015 <- read_xlsx(here::here("raw_data/boing-boing-candy-2015.xlsx"))
candy_2016 <- read_xlsx(here::here("raw_data/boing-boing-candy-2016.xlsx"))
candy_2017 <- read_xlsx(here::here("raw_data/boing-boing-candy-2017.xlsx"))

# 2015 Cleaning ----------------------------------------------------------------


clean_2015 <- clean_names(candy_2015)
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
clean_2015 <- clean_2015 %>%
  relocate(necco_wafers, .after = york_peppermint_patties)
clean_2015$year <- 2015
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
clean_2015 <- clean_2015 %>%
  transform(age = as.numeric(age))
clean_2015 <- clean_2015 %>%
  add_column(gender = NA, .after = "going_out") %>%
  add_column(country = NA, .after = "gender") %>%
  add_column(state = NA, .after = "country")
clean_2015 <- clean_2015 %>%
  select(-101, -102, -103, -104, -105, -106, -107, -108, -109, -110, -111, 
         -112, -113, -114, -115, -116, -117, -118, -119, -120, -121, -122,
         -123, -124, -125, -126, -127)

## THIS IS MY ATTEMPT AT ASSERTIVE PROGRAMMING - ASK SOMEONE LATER
# clean_data_2015_age <- function(age_people) {
#   #check age
#   age_people %>%
#     verify(age >0 & age <= 80)
#   
#   #average_age
#   average_age <- 
#     age_people %>%
#     summarise(
#       mean_age = mean(age)
#     )
#   return(list(mean_age))
# }    
#assertive programming function  

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




clean_2015 <- clean_2015 %>%
  rename("100_grand_bar" = x100_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = 
           anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         bonkers_the_candy = bonkers,
         boxo_raisins = box_o_raisins,
         hersheys_dark_chocolate = dark_chocolate_hershey,
         hershey_s_milk_chocolate = hersheys_milk_chocolate,
         licorice_yes_black = licorice,
         sweetums_a_friend_to_diabetes = sweetums)

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
  add_column(dove_bars = NA)

clean_2015 <- clean_2015 %>%
  select(year, age, going_out, gender, country, state, "100_grand_bar",
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
         peterson_brand_sidewalk_chalk)



# 2016 Cleaning ----------------------------------------------------------------
clean_2016 <- clean_names(candy_2016)
clean_2016 <- clean_2016 %>%
  rename(age = how_old_are_you,
         going_out = are_you_going_actually_going_trick_or_treating_yourself,
         year = timestamp,
         gender = your_gender,
         country = which_country_do_you_live_in,
         state = which_state_province_county_do_you_live_in,
         hersheys_milk_chocolate = hershey_s_milk_chocolate,
  )
clean_2016 <- clean_2016 %>%
  transform(age = as.numeric(age))
clean_2016$year <- 2016
clean_2016 <- clean_2016 %>%
  relocate(age, .after = year)
clean_2016 <- clean_2016 %>%
  select(-107, -108, -109, -110, -111, 
         -112, -113, -114, -115, -116, -117, -118, -119, -120, -121, -122,
         -123)

clean_2016 <- clean_2016 %>%
  mutate(country = str_to_title())

# cleaning USA
clean_2016 <- clean_2016 %>%
  mutate(country = str_replace(country, "[u][sS][aA]", "USA")) %>%
  mutate(country = str_replace(country, "[uU][s]", "USA")) %>%
  mutate(country = str_replace(country, "^US$", "USA")) %>%
  mutate(country = str_replace(country, "^Usa$", "USA")) %>%
  mutate(country = str_replace(country, "^USA!", "USA")) %>%
  mutate(country = str_replace(country, "^USA USA USA$", "USA")) %>%
  mutate(country = str_replace(country, "[U][s][a]", "USA")) %>%
  mutate(country = str_replace(country, "^Usa!$", "USA")) %>%
  mutate(country = str_replace(country, "[U][.][S][.][A][.]", "USA")) %>%
  mutate(country = str_replace(country, "^United States of America$", "USA")) %>%
  mutate(country = str_replace(country, "[uU][n][i][t][e][d][ ][Ss][t][a][t][e][s]", "USA")) %>%
  mutate(country = str_replace(country, "^Murica$", "USA")) %>%
  mutate(country = str_replace(country, "^U.S.$", "USA")) %>%
  mutate(country = str_replace(country, "^USA USA! USA!", "USA"))

# removing NA/not input countries
clean_2016 <- clean_2016 %>%
  mutate(country = na_if(country, "A tropical island south of the equator")) %>%
  mutate(country = na_if(country, "Neverland")) %>%
  mutate(country = na_if(country, 51.0)) %>%
  mutate(country = na_if(country, 47.0)) %>%
  mutate(country = na_if(country, 54.0)) %>%
  mutate(country = na_if(country, 44.0)) %>%
  mutate(country = na_if(country, 45.0)) %>%
  mutate(country = na_if(country, 30.0)) %>%
  mutate(country = na_if(country, "one of the best ones")) %>%
  mutate(country = na_if(country, "there isn't one for old men")) %>%
  mutate(country = na_if(country, "god's country")) %>%
  mutate(country = na_if(country, "see above")) %>%
  mutate(country = na_if(country, 45.0)) %>%
  mutate(country = na_if(country, "this one")) %>%
  mutate(country = na_if(country, "somewhere"))

# clean_2016 %>%
#   filter(country != "USA", country != "Canada", country != "UK", country != "United Kingdom",
#          country != "Japan", country != "france")

# Note - this is incomplete.

clean_2016 <- clean_2016 %>%
  mutate(age = na_if(age, 8.10e+01)) %>%
  mutate(age = na_if(age, 1.00e+18)) %>%
  mutate(age = na_if(age, 8.20e+01)) %>%
  mutate(age = na_if(age, 1.42e+02))




clean_2016 <- clean_2016 %>%
  rename("100_grand_bar" = x100_grand_bar,
         anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes =
           anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         hershey_s_milk_chocolate = hersheys_milk_chocolate)

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

clean_2016 <- clean_2016 %>%
  select(-mary_janes) %>%
  select(-"third_party_m_ms") %>%
  select(-"person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes")

clean_2016 <- clean_2016 %>%
  select(year, age, going_out, gender, country, state, "100_grand_bar",
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
         peterson_brand_sidewalk_chalk)


# 2017 Cleaning ----------------------------------------------------------------

clean_2017 <- clean_names(candy_2017)

clean_2017 <- clean_2017 %>%
  rename(year = internal_id)
clean_2017$year <- 2017

clean_2017 <- clean_2017 %>%
  select(-110, -111, -112, -113, -114, -115, -116, -117, -118, -119, -120)

clean_2017 <- clean_2017 %>%
  rename(going_out = q1_going_out,
         gender = q2_gender,
         age = q3_age,
         country = q4_country,
         state = q5_state_province_county_etc)
clean_2017$age[clean_2017$age == "sixty-nine"] <- 69
clean_2017$age[clean_2017$age == "46 Halloweens"] <- 46
clean_2017 <- clean_2017 %>%
  relocate(age, .after = year)

clean_2017 <- clean_2017 %>%
  transform(age = as.numeric(age))

clean_2017 <- clean_2017 %>%
  mutate(age = na_if(age, 90)) %>%
  mutate(age = na_if(age, 312)) %>%
  mutate(age = na_if(age, 99)) %>%
  mutate(age = na_if(age, 88)) %>%
  mutate(age = na_if(age, 102)) %>%
  mutate(age = na_if(age, 100)) %>%
  mutate(age = na_if(age, 1000))

clean_2017 <- clean_2017 %>% 
  rename_with(.cols = starts_with("q6_"), .fn = ~str_replace(.x, "q6_", ""))

clean_2017 <- clean_2017 %>%
  mutate(country = str_replace(country, "[u][sS][aA]", "USA")) %>%
  mutate(country = str_replace(country, "[uU][s]", "USA")) %>%
  mutate(country = str_replace(country, "^US$", "USA")) %>%
  mutate(country = str_replace(country, "^Usa$", "USA")) %>%
  mutate(country = str_replace(country, "^USA!", "USA")) %>%
  mutate(country = str_replace(country, "^USA USA USA$", "USA")) %>%
  mutate(country = str_replace(country, "[U][s][a]", "USA")) %>%
  mutate(country = str_replace(country, "^Usa!$", "USA")) %>%
  mutate(country = str_replace(country, "[U][.][S][.][A][.]", "USA")) %>%
  mutate(country = str_replace(country, "^United States of America$", "USA")) %>%
  mutate(country = str_replace(country, "[uU][n][i][t][e][d][ ][Ss][t][a][t][e][s]", "USA")) %>%
  mutate(country = str_replace(country, "^Murica$", "USA")) %>%
  mutate(country = str_replace(country, "^U.S.$", "USA")) %>%
  mutate(country = str_replace(country, "^USA USA! USA!", "USA"))

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
  add_column(peterson_brand_sidewalk_chalk = NA)


# Joining ---------

joined_candy <- bind_rows(clean_2015, clean_2016, clean_2017)

# Saving ---
save to csv