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
  titlePanel("HMDA App"),
  
  fluidRow(
    column(
      3,
      h4("Applicant Info"),
      selectInput("applicant_gender", "Sex",
                  list("Male", "Female"),
                  selected = "Female"),
      br(),
      selectInput(
        "applicant_race", "Race",
        list("White",
             "American Indian or Alaska Native",
             "Asian",
             "Black or African American",
             "Native Hawaiian or Other Pacific Islander"),
        selected = "Asian"
      ),
      br(),
      selectInput(
        "applicant_age", "Age",
        list("<25",
             "25-34",
             "35-44",
             "45-54",
             "55-64"),
        selected = "35-44"
      )
    ),
    column(
      3,
      h4("Geographic Area"),
      selectInput("state", "State",
                  c(
                    "Idaho" = "ID",
                    "Oregon" = "OR",
                    "Washington" = "WA"
                  )),
      br(),
      selectInput("county", "County", 
                  # choices = "16065",
                  choices = county_list),
      br(),
      selectInput(
        "census_tract", "MSA/Census Tract",
        choices = census_tract_list
        # choices = '16065950100'
      )
    ),
    column(   # OUTPUT LENDER NAME ON ui SIDE? - lei_name 
      3,
      h4("Lender Info"),
      selectInput("lei", "LEI", 
                 # choices = '549300FGXN1K3HLB1R50'
                choices = lei_list
                )
    ),
    column(
      3,
      h4("Loan Info"),
      selectInput(
        "loan_type",
        "Loan Type",
        list("FHA:First Lien",
             "VA:First Lien",
             "Conventional:First Lien")
      ),
      br(),
      selectInput(
        "purchaser_type",
        "Purchaser Type",
        c(
          "Not Applicable" = 0,
          "Fannie Mae" = 1,
          "Ginnie Mae" = 2,
          "Freddie Mac" = 3,
          "Farmer Mac" = 4,
          "Private Securitizer" = 5
        )
      ),
      br(),
      selectInput(
        "dwelling_category_type",
        "Dwelling Category/Type",
        list(
          "Single Family (1-4 Units):Site-Built",
          "Single Family (1-4 Units):Manufactured",
          "Multifamily:Site-Built"
        )
      )
    ),
    
    br(),  # hr()?
    
    column(
      width = 12,
      fluidRow(
        column(
          12,
          h3(uiOutput("lei_name")),
          uiOutput("state"),
          uiOutput("county"),
          uiOutput("census_tract"),
          uiOutput("lei"),
          uiOutput("loan_type"),
          uiOutput("purchase_type"),
          uiOutput("dwelling_category_type"),
          uiOutput("applicant_gender"),
          uiOutput("applicant_race"),
          uiOutput("applicant_age")
        )  
      ),
      
      fluidRow(
        column(width = 12, 
               dataTableOutput("applicant_race_percentage")
        )
      ),
      
      fluidRow(
        column(width = 12,
               dataTableOutput("applicant_gender_percentage")
        )
      ),
      
      fluidRow(
        column(width = 12,
               dataTableOutput("applicant_age_percentage")
        )
      ),
    )
  )
))
