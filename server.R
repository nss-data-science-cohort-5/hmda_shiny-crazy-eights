#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("../lei_search/lei_search.R")    # HABEEB'S ORIGINAL FILE PATH
# source("lei_search/lei_search.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  states_data_geographical <- reactive({
    states_data %>% 
      filter(state_code == input$state, 
             county_code == input$county,
             census_tract == input$census_tract)
  })   
  
  states_data_lei <- reactive({
    states_data_geographical() %>% 
      filter(lei == input$lei)
  })
  
  
  
  output$lei_name <- renderText({
    if (input$lei != "") {
      record <- get_lei_by_id(input$lei)
      record@name
    } else {
      ""
    }
  })
  
  output$applicant_race_percentage <- renderDataTable(
    states_data_geographical() %>%
      count(`applicant_race-1`) %>%
      rename(categorical_value = `applicant_race-1`) %>%
      mutate(categorical_value = as.character(categorical_value),
             field_name = "applicant_race-1") %>%
      left_join(field_scrape, by = c("field_name", "categorical_value"))%>%
      mutate(percentage = (n * 100) / sum(n))  %>%
      select(description, percentage)
  )
  
  output$applicant_gender_percentage <- renderDataTable(
    states_data_geographical() %>%
      count(applicant_sex) %>%
      rename(categorical_value = applicant_sex) %>%
      mutate(categorical_value = as.character(categorical_value),
             field_name = "applicant_sex") %>%
      left_join(field_scrape, by = c("field_name", "categorical_value")) %>%
      mutate(percentage = (n * 100) / sum(n)) %>%
      select(description, percentage)
  )
  
  output$applicant_age_percentage <- renderDataTable(
    states_data_geographical() %>%
      count(applicant_age) %>%
      mutate(percentage = (n * 100) / sum(n)) %>%
      select(applicant_age, percentage)
  )
  
  output$state <- reactive(input$state)
  output$county <- reactive(input$county)
  output$census_tract <- reactive(input$census_tract)
  output$lei <- reactive(input$lei)
  output$loan_type <- reactive(input$loan_type)
  output$purchase_type <- reactive(input$purchase_type)
  output$dwelling_category_type <-
    reactive(input$dwelling_category_type)
  output$applicant_gender <- reactive(input$applicant_gender)
  output$applicant_race <- reactive(input$applicant_race)
  output$applicant_age <- reactive(input$applicant_age)
})
