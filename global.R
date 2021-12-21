library(tidyverse)
library(bslib)

states_data <- read_csv("..//data/state_OR.csv")  # HABEEB'S ORIGINAL FILE PATH
# state_data <- read_csv("data/state_ID.csv") # ROSS FILE PATH

field_scrape <- read_csv("..//data/field_definitions.csv")  # HABEEB'S ORIGINAL FILE PATH
# field_scrape <- read_csv("field_definitions_scraper/field_definitions.csv")
field_scrape <- field_scrape %>%
  filter(!is.na(description))


county_list <- states_data %>%
  distinct(county_code)

census_tract_list <- states_data %>%
  distinct(census_tract)

lei_list <- states_data %>%
  distinct(lei)