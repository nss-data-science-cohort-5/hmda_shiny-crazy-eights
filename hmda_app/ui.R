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
                "applicant_race",
                "Race",
                list("White",
                     "American Indian or Alaska Native",
                     "Asian"),
                selected = "Asian"
            ),
            br(),
            selectInput(
                "applicant_age",
                "Age",
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
                            "Oregon" = "OR",
                            "Washington" = "WA"
                        )),
            br(),
            textInput("county", "County", value = "", placeholder = "Enter desired county"),
            br(),
            textInput(
                "census_tract",
                "MSA/Census Tract",
                value = "",
                placeholder = "Enter MSA/Census tract"
            )
        ),
        column(
            3,
            h4("Lender Info"),
            textInput("lei", "LEI", value = "", placeholder = "Enter lender LEI")
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
        
        hr(),
        
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
            
        )
    )
))
