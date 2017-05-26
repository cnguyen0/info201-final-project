library(dplyr)
library(rsconnect)
library(plotly)
library(shiny)
library(HSAUR)

data <- read.csv('./Data/mental-heath-in-tech-2016.csv')

shinyServer(function(input, output) { 
  #Steph
  output$ComfortLevel <- renderPlot({
    comfort.level <- data[,11:12] 
    colnames(comfort.level) <- c("Mental", "Physical")
    ggplot(data = comfort.level) +
           geom_point(mapping = aes(x=Mental, y = Physical))
    
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
  output$plotZoheb <- renderPlotly({
    
    #columns included : is your anonimity protected, Would you feel comfortable discussing a mental health disorder with your coworkers?, 
    #Would you feel comfortable discussing a mental health disorder with your direct supervisor(s)?, Do you feel that your employer takes mental health as seriously as physical health?
    zoheb.data <- data %>% select(  Is.your.anonymity.protected.if.you.choose.to.take.advantage.of.mental.health.or.substance.abuse.treatment.resources.provided.by.your.employer.,
                                    Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.coworkers.,
                                    Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..,
                                    Do.you.feel.that.your.employer.takes.mental.health.as.seriously.as.physical.health.
    )
    zoheb.data <- zoheb.data %>% filter(Is.your.anonymity.protected.if.you.choose.to.take.advantage.of.mental.health.or.substance.abuse.treatment.resources.provided.by.your.employer. != '') %>%
      filter(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.coworkers. != '') %>%
      filter(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. != '') %>%
      filter(Do.you.feel.that.your.employer.takes.mental.health.as.seriously.as.physical.health. != '')
    colnames(zoheb.data) <- c('anonimity', 'coworker_discussion', 'supervisor_discussion', 'seriousness_comparison')
    #graph formation
    types <- as.character(unique(zoheb.data[[input$options]]))
    s1 <- as.numeric(sum(zoheb.data[[input$options]] == types[1]))
    s2 <- as.numeric(sum(zoheb.data[[input$options]] == types[2]))
    s3 <- as.numeric(sum(zoheb.data[[input$options]] == types[3]))
    #returns plot
    return(
      plot_ly(
        data = zoheb.data,
        x = unique(zoheb.data[[input$options]]),
        y = c(s1,s2,s3),
        type = 'bar'
      ) %>%
        layout(
          title = list(title = ),
          x = 'Options',
          y = 'Number of people'
        )
    )
  })
  #End Zoheb
  
})