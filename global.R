library(tidyverse)
library(bslib)

states_data <- read_csv("..//data/state_ID-OR-WA.csv")

field_scrape <- read_csv("..//data/field_definitions.csv")
field_scrape <- field_scrape %>%
  filter(!is.na(description))

state_list <- states_data %>%
  distinct(state_code) %>%
  arrange(state_code)

county_list <- states_data %>%
  distinct(county_code) %>%
  arrange(county_code)

census_tract_list <- states_data %>%
  distinct(census_tract) %>%
  arrange(census_tract)

lei_list <- states_data %>%
  distinct(lei) %>%
  arrange(lei)