library(dplyr)
library(rsconnect)
library(shiny)
library(ggplot2)
library(plotly)


data <- read.csv('./Data/mental-heath-in-tech-2016.csv')
source("./scripts/DiagnosisWillingness.R")

shinyServer(function(input, output) { 

 #Steph
  output$ComfortLevel <- renderPlot({
    #Takes in a two-column dataframe and counts the number of Yes, Maybe, and No responses.
    count.responses <- function(data.input) {
      data <- data.input
      colnames(data) <- c("Mental", "Physical")
      #Removing NA Values
      data <-  data[!(is.na(data$Mental) | data$Physical==""), ]
      
      #Filtering out Mental health data and counting it
      yes.mental <- filter(data, grepl("Yes", Mental)) %>%
                    count() %>%
                    as.numeric()
      maybe.mental <- filter(data, grepl("Maybe", Mental)) %>%
                      count() %>%
                      as.numeric()
      no.mental <- filter(data, grepl("No", Mental)) %>%
        count() %>%
        as.numeric()
      
      mental.impact <- c(yes.mental, maybe.mental, no.mental)
      
      #Filtering out Physical health data and counting it.
      yes.physical <- filter(data, grepl("Yes", Physical)) %>%
        count() %>%
        as.numeric()
      maybe.physical <- filter(data, grepl("Maybe", Physical)) %>%
        count() %>%
        as.numeric()
      no.physical <- filter(data, grepl("No", Physical)) %>%
        count() %>%
        as.numeric()
      
      physical.impact <- c(yes.physical, maybe.physical, no.physical)
      
      #Creating the dataframe
      responses <- c("Yes", "Maybe", "No")
      data.final <- data.frame(responses, mental, physical)
      return(data.final)
    }
    
    impact.level <- data[,11:12]
    impact.level.num <- count.responses(impact.level)
    
    #Creating functions for each plot
    negative.impact <- function(data.input) {
      ggplot(data = data.input) + 
        geom_bar(mapping = aes(x=mental, y = physical, color = responses), size = 3) +
        ggtitle("Do you think that discussing this health issue will have negative consequences?") +
        labs(x = "Mental Health",
             y = "Physical Health", color = "Responses") +
        theme_classic() +
        xlim(0, 1000) +
        ylim(0, 1000)
    }
    
    interview <- data.frame(data[,41], data[,39])
    interview.num <- count.responses(interview)
    
    #plotting the data
        if(input$impact == "Negative Impact") {  
          ggplot(data = impact.level.num) + 
            geom_point(mapping = aes(x=mental, y = physical, color = responses), size = 3) +
            ggtitle("Do you think that discussing this health issue will have negative consequences?") +
            labs(x = "Mental Health",
                 y = "Physical Health", color = "Responses") +
            theme_classic() +
            xlim(0, 1000) +
            ylim(0, 1000)
        } else if (input$impact == "Comfort Level Discussing Health") {
          ggplot(data = interview.num) +
            geom_point(mapping = aes(x=mental, y = physical, color = responses), size = 3) +
            ggtitle("Do you think that discussing this health issue will have negative consequences?") +
            labs(x = "Mental Health",
                 y = "Physical Health", color = "Responses") +
            theme_classic() +
            xlim(0, 1000) +
            ylim(0, 1000)
          
        }  else {}

    
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
  output$DiagonosisWillingness <- renderPlotly({
    
    #comfort.df <- data %>% select("Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..",
    #                              "Would.you.have.been.willing.to.discuss.a.mental.health.issue.with.your.direct.supervisor.s..")
    #colnames(comfort.df) <- c("mh.disorder.comfort", "mh.issue.comfort")
    #
    #curr.have.disorder <- data %>% filter("Do.you.currently.have.a.mental.health.disorder." == "Yes") %>% 
    #                               select("If.yes..what.condition.s..have.you.been.diagnosed.with.")
    #colnames(curr.have.disorder) <- "diagonosis.status"
    #curr.have.disorder <- data.frame(curr.have.disorder, comfort.df)


    #been.diagonosed <- data %>% filter("Have.you.been.diagnosed.with.a.mental.health.condition.by.a.medical.professional." == "Yes") %>%
    #                                  select("If.so..what.condition.s..were.you.diagnosed.with.")
    #colnames(been.diagonosed) <- "diagonosis.status"
    #been.diagonosed <- data.frame(been.diagonosed, comfort.df)
    
    #return(DiagonosisWillingness(data, input$condition.status, input$comfort))
    #return(DiagonosisWillingness(input$dataframe, input$comfort))
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
    #
    descriptions <- c('Is an employee\'s anonimity protected if they choose to take advantage of a mental helth treatment?','Would an employee feel comfortable discussing a mental health disorder with their coworkers?','Would an employee feel comfortable discussing a mental health disorder with their supervisor?','Do employees feel that their employer takes mental health as seriously as physical health?')
    titles <- c('anonimity', 'coworker_discussion', 'supervisor_discussion', 'seriousness_comparison')
    dynamic.title <- data.frame(titles, descriptions)
    #returns plot
    return(
      plot_ly(
        data = zoheb.data,
        x = unique(zoheb.data[[input$options]]),
        y = c(s1,s2,s3),
        type = 'bar'
      ) %>%
        layout(
          title = as.character(input$options),
          x = 'Options',
          y = 'Number of people',
          text = as.character(dynamic.title$descriptions[dynamic.title$titles == as.character(input$options)])
        )
    )
  })
  #End Zoheb
  
})
