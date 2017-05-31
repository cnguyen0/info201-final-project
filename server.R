library(dplyr)
library(rsconnect)
library(ggplot2)
library(plotly)

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
  output$remoteCountryPlot <- renderPlot({
    p <- ggplot(data = data, mapping = aes(x = Do.you.work.remotely., y = Do.you.currently.have.a.mental.health.disorder., label = name, 
                                           color=Have.you.been.diagnosed.with.a.mental.health.condition.by.a.medical.professional.)) +
      geom_point() +
      facet_wrap(input$facet.by) +
      ggtitle("Working Remotely vs. Mental Health")
    
    return(p)
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