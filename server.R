#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(rootSolve)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  td1<-read.csv("CalDur.csv")
  td<-subset(td1,CalculationDuration<=40000 & CalculationDuration>0)
#  LowP=1
#  HiP=5
  pr<-reactive(
    {
      fun<-function(x){
        1-(1-input$pre)^(x/60)-(input$HiP-input$LowP)/input$HiP
      }
      uni<-uniroot(fun,c(0,40000))
      uni$root
    }
  )
  
  output$hist<-renderPlot(
    ggplot(td,aes(x=CalculationDuration))
    +geom_histogram(binwidth=1800,color="gray20",fill="gray75")
    +scale_x_continuous(name="runtime",limits=c(0,40000),breaks=seq(0,40000,5000))
    +geom_vline(aes(xintercept=pr()),color="blue",linetype="dashed",size=1)
    +theme(axis.title=element_text(face="italic"),title=element_text(size=18,face="bold.italic"))
    +ggtitle("Runtime Histogram"))
  output$critical<-renderText({
    paste("The critical runtime is ",round(pr(),digits=2))
  })
  
})
