#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel(
      h1("HMDA App", align = "center")
    ),
    
    fluidRow(
        column(
            6,
            h4("Geographic Area"),
            selectInput("state", 
                        "State",
                        choices = c("All", state_list)),
            
            br(),
            
            selectInput("county", 
                        "County", 
                        choices = c("All", county_list)),
            br(),
            
            selectInput("census_tract", 
                        "MSA/Census Tract",
                        choices = c("All", census_tract_list))
        ),
        column(
            6,
            h4("Lender Info"),
            selectInput("lei", 
                        "LEI", 
                        choices = c("All", lei_list))
        )
    ),
        
        hr(),
        
        fluidRow(
            column(
                width = 12,
                align = "center",
                h3(uiOutput("lei_name"))
            )
            
        ),
        
        fluidRow(
          column(width = 12,
            h3(uiOutput("race_label")))
        ),
        
        fluidRow(    
          column(width = 12, 
                 dataTableOutput("applicant_race_percentage")
          )
          
        ),
    
        br(),
    
        fluidRow(
          column(width = 12,
                 h3(uiOutput("gender_label")))
          ),
        
        fluidRow(
          column(width = 12,
                 dataTableOutput("applicant_gender_percentage")
          )
        ),
    
        br(),
    
        fluidRow(
          column(width = 12,
             h3(uiOutput("age_label")))
          ),
        
        fluidRow(
          column(width = 12,
                 dataTableOutput("applicant_age_percentage")
          )
        )
    )
)
