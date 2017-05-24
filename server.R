library(dplyr)
library(rsconnect)

data <- read.csv('./Data/mental-heath-in-tech-2016.csv')

shinyServer(function(input, output) { 
  #Steph
  output$ComfortLevel <- renderPlot({
    
    
  })
  #End Steph
  
  #Cindy
  output$PlotName <- renderPlot({
    
  })
  #End Cindy
  
  #Megha
  output$plotname <- renderPlot({
    
  })
  #End Megha
  
  #Kathy
  output$plotname <- renderPlot({
    
  })
  #End Kathy
  
  #Zoheb
  output$plotname <- renderPlot({
    
  })
  #End Zoheb
  
})