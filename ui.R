#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(
    title="Critical Runtime Explorer",
    titleWidth=250
    ),

  dashboardSidebar(
    width=250,
    sliderInput(
                          inputId="pre",
                          label="Choose the pre-emption rate",
                          min = 0,
                          max = 0.1,
                          value = 0.02,
                          step = 0.0001,
                          sep=""
                      ),
            
    numericInput(inputId="HiP",label="Price of high 
                          priority VMs",value=5),
    numericInput(inputId="LowP",label="Price of low priority VMs",value=1)
  ),
  
  dashboardBody(
    plotOutput("hist"),
    textOutput("critical")
    )
  )
)

