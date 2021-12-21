library(httr)
library(stringr)

###################################

# BRYAN FINLAYSON'S lei_search.R file --

# https://github.com/nss-data-science-cohort-5/hmda_shiny-crazy-eights/blob/habeeb-branch/lei_search/lei_search.R

# Usage Example:
# source(path/to/this/file)
# record <- get_lei_by_id("529900W18LQJJN6SJ336")
# record@name
# => "Société Générale Effekten GmbH"
###################################

setClass("lei_record", slots=list(
  name="character", 
  region="character", 
  jurisdiction="character",
  address_1="character",
  city="character",
  state="character",
  country="character",
  postal_code="character",
  active="character",
  managing_lou="character"
#  direct_parent="character",  # WILL GET ERRORS IF THESE ARE MISSING
#  ultimate_parent="character",
#  direct_children="character",
#  isins="character"
  ))


build_lei_record <- function(json) {
  record <- new("lei_record",
                name=json$data$attributes$entity$legalName$name,
                region=json$data$attributes$entity$legalAddress$region,
                active=json$data$attributes$entity$status,
                jurisdiction=json$data$attributes$entity$jurisdiction,
                address_1=json$data$attributes$entity$headquartersAddress$addressLines[[1]],
                city=json$data$attributes$entity$legalAddress$city,
                state=json$data$attributes$entity$legalAddress$region,
                country=json$data$attributes$entity$legalAddress$country,
                postal_code=json$data$attributes$entity$legalAddress$postalCode,
                managing_lou=json$data$relationships$`managing-lou`$links$related
               # direct_parent=json$data$relationships$`direct-parent`$links$`lei-record`,
               # ultimate_parent=json$data$relationships$`ultimate-parent`$links$`relationship-record`,
               # direct_children=json$data$relationships$`direct-children`$links$related,
               # isins=json$data$relationships$isins$links$related
               )
  return(record)
}

get_lei_by_id <- function(lei) {
  json <- GET(str_interp("https://api.gleif.org/api/v1/lei-records/${lei}")) %>% 
    content(as="parsed")
  record <- build_lei_record(json)
  return(record)
}
