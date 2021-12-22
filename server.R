#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("../lei_search/lei_search.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  states_data_geographical <- reactive({
    states_data %>% 
      filter(if(input$state != 'All')  (state_code == input$state) else TRUE,
             if(input$county != 'All')  (county_code == input$county) else TRUE,
             if(input$census_tract != 'All')  (census_tract == input$census_tract) else TRUE)
  })
  
  state_list <- reactive({
    states_data_geographical() %>%
      distinct(state_code) %>%
      arrange(state_code)
  })
  
  county_list <- reactive({
    states_data_geographical() %>%
      distinct(county_code) %>%
      arrange(county_code)
  })
  
  census_tract_list <- reactive({
    states_data_geographical() %>%
      distinct(census_tract) %>%
      arrange(census_tract)
  })
  
  lei_list <- reactive({
    states_data_lei() %>%
      distinct(lei) %>%
      arrange(lei)
  })
  
  states_data_lei <- reactive({
    states_data_geographical() %>% 
      filter(if(input$lei != 'All')  (lei == input$lei) else TRUE)
  })
  
  lei_race_percentage <- reactive({
    states_data_lei() %>%
      count(`applicant_race-1`) %>%
      rename(categorical_value = `applicant_race-1`) %>%
      mutate(categorical_value = as.character(categorical_value),
             field_name = "applicant_race-1") %>%
      left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
      mutate("LEI Percentages" = round((n * 100) / sum(n), 3), description = replace_na(description, "N/A"))  %>%
      select(description, "LEI Percentages") %>%
      rename("Applicant Race" = description)
  })
  
  lei_gender_percentage <- reactive({
    states_data_lei() %>%
      count(applicant_sex) %>%
      rename(categorical_value = applicant_sex) %>%
      mutate(categorical_value = as.character(categorical_value),
             field_name = "applicant_sex") %>%
      left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
      mutate("LEI Percentages" = round((n * 100) / sum(n), 2))  %>%
      select(description, "LEI Percentages") %>%
      rename("Applicant Gender" = description)
  })
  
  lei_age_percentage <- reactive({
    states_data_lei() %>%
      count(applicant_age) %>%
      mutate("LEI Percentages" = round((n * 100) / sum(n), 2)) %>%
      select(applicant_age,  "LEI Percentages") %>%
      rename("Applicant Age" = applicant_age)
  })
  
  output$lei_name <- renderText({
    if (input$lei != "All") {
      record <- get_lei_by_id(input$lei)
      record@name
    } else {
      "All LEIs"
    }
  })
  
  output$race_label <- renderText({
    "Race Percentages"
  })
  
  output$gender_label <- renderText({
    "Gender Percentages"
  })
  
  output$age_label <- renderText({
    "Age Percentages"
  })
  
  output$applicant_race_percentage <- renderDataTable(
    if (input$lei == "All") {
      states_data_geographical() %>%
        count(`applicant_race-1`) %>%
        rename(categorical_value = `applicant_race-1`) %>%
        mutate(categorical_value = as.character(categorical_value),
               field_name = "applicant_race-1") %>%
        left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
        mutate("Geographical Percentages" = round((n * 100) / sum(n), 3), description = replace_na(description, "No Info Entered"))  %>%
        select(description, "Geographical Percentages") %>%
        rename("Applicant Race" = description)
    } else {
      states_data_geographical() %>%
        count(`applicant_race-1`) %>%
        rename(categorical_value = `applicant_race-1`) %>%
        mutate(categorical_value = as.character(categorical_value),
               field_name = "applicant_race-1") %>%
        left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
        mutate("Geographical Percentages" = round((n * 100) / sum(n), 3), description = replace_na(description, "No Info Entered"))  %>%
        select(description, "Geographical Percentages") %>%
        rename("Applicant Race" = description) %>%
        full_join(lei_race_percentage(), by = "Applicant Race")
    }
  )
  
  output$applicant_gender_percentage <- renderDataTable(
    if (input$lei == "All") {
      states_data_geographical() %>%
        count(applicant_sex) %>%
        rename(categorical_value = applicant_sex) %>%
        mutate(categorical_value = as.character(categorical_value),
               field_name = "applicant_sex") %>%
        left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
        mutate("Geographical Percentages" = round((n * 100) / sum(n), 2))  %>%
        select(description, "Geographical Percentages") %>%
        rename("Applicant Gender" = description)
    } else {
      states_data_geographical() %>%
        count(applicant_sex) %>%
        rename(categorical_value = applicant_sex) %>%
        mutate(categorical_value = as.character(categorical_value),
               field_name = "applicant_sex") %>%
        left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
        mutate("Geographical Percentages" = round((n * 100) / sum(n), 2))  %>%
        select(description, "Geographical Percentages") %>%
        rename("Applicant Gender" = description) %>%
        full_join(lei_gender_percentage(), by = "Applicant Gender")
    }
  )
  
  output$applicant_age_percentage <- renderDataTable(
    if (input$lei == "All") {
      states_data_geographical() %>%
        count(applicant_age) %>%
        mutate("Geographical_Percentages" = round((n * 100) / sum(n), 2)) %>%
        select(applicant_age,  "Geographical_Percentages") %>%
        rename("Applicant Age" = applicant_age)
    } else {
      states_data_geographical() %>%
        count(applicant_age) %>%
        mutate("Geographical Percentages" = round((n * 100) / sum(n), 2)) %>%
        select(applicant_age,  "Geographical Percentages") %>%
        rename("Applicant Age" = applicant_age) %>%
        full_join(lei_age_percentage(), by = "Applicant Age")
    }
  )
})
