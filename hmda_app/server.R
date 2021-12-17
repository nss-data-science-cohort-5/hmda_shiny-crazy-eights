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
    output$lei_name <- renderText({
        if (input$lei != "") {
            record <- get_lei_by_id(input$lei)
            record@name
        } else {
            ""
        }
    })
    
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
