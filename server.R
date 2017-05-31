library(dplyr)
library(rsconnect)
library(shiny)
library(ggplot2)
library(plotly)

data <- read.csv('./Data/mental-heath-in-tech-2016.csv')

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
      
      mental <- c(yes.mental, maybe.mental, no.mental)
      
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
      
      physical <- c(yes.physical, maybe.physical, no.physical)
      
      #Creating the dataframe
      responses <- c("Yes", "Maybe", "No")
      data.final <- data.frame(responses, mental, physical)
      return(data.final)
    }
    
    impact.level <- data[,11:12]
    impact.level.num <- count.responses(impact.level)
    
    #Creating functions for each plot
    # negative.impact <- function(data.input) {
    #   ggplot(data = data.input) + 
    #     geom_bar(mapping = aes(x=mental, y = physical, color = responses), size = 3) +
    #     ggtitle("Do you think that discussing this health issue will have negative consequences?") +
    #     labs(x = "Mental Health",
    #          y = "Physical Health", color = "Responses") +
    #     theme_classic() +
    #     xlim(0, 1000) +
    #     ylim(0, 1000)
    # }
    
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
              ggtitle("Would you bring up a health issue with a potential employer in an interview?") +
              labs(x = "Mental Health",
                   y = "Physical Health", color = "Responses") +
              theme_classic() +
              xlim(0, 1000) +
              ylim(0, 1000)
          
        }  else { #if (input$impact == "Negative Impact" && input$impact == "Comfort Level Discussing Health"){
            ggplot(data = interview.num) +
              ggtitle("Test") +
              labs(x = "Mental Health",
                   y = "Physical Health", color = "Responses") +
              theme_classic() +
              xlim(0, 1000) +
              ylim(0, 1000) +
              geom_point(mapping = aes(x=mental, y = physical, color = responses), size = 3) 
        }
    
  })
  #End Steph
  
  #Cindy
  output$familyHistory <- renderPlot({
    has.family.history <- data %>% filter(Do.you.have.a.family.history.of.mental.illness. == 'Yes') %>%
                                  filter(What.is.your.age. < 70) %>%
                                  filter(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. != '') %>%
                                  filter(Do.you.feel.that.your.employer.takes.mental.health.as.seriously.as.physical.health. != '')

    if (input$categories == 'What.is.your.age.') {
      x.axis.lab = 'What is your age?'
    } else if (input$categories == 'Do.you.work.remotely.') {
      x.axis.lab = 'Do you work remotely?'
    } else if (input$categories == 'Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..') {
      x.axis.lab = 'Would you feel comfortable discussing a mental health disorder with your direct supervisors?'
    } else {
     x.axis.lab = 'Do you feel that your employer takes mental health as seriously as physical health?'
    }
    
    ggplot(data = has.family.history, aes_string(input$categories)) + geom_bar() + 
      labs(x = x.axis.lab, y = "Count") + ggtitle("Breaking Down Questions of Answers of Those Who Has a Family History of Mental Illnesses")
  })
  
  # general plot with those 
  output$familyBreakdown <- renderPlot({
    has.family.history <- data %>% filter(Do.you.have.a.family.history.of.mental.illness. == 'Yes')
    ggplot(data = has.family.history, aes(Do.you.feel.that.your.employer.takes.mental.health.as.seriously.as.physical.health.)) + geom_bar()
  })
  
  output$disorder <- renderPlot({
    has.family.history <- data %>% filter(Do.you.have.a.family.history.of.mental.illness. == 'Yes')
    ggplot(data = has.family.history, aes(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..)) + geom_bar()
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
    #dynamic titles
    descriptions <- c('Is an employee\'s anonimity protected if they choose to take advantage of a mental helth treatment?','Do employees feel comfortable discussing a mental health disorder with their coworkers?','Do employees feel comfortable discussing a mental health disorder with their supervisor?','Do employees feel that their employer takes mental health as seriously as physical health?')
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
          x = as.character(dynamic.title$descriptions[dynamic.title$titles == as.character(input$options)]),
          y = 'Number of people'
        )
    )
  })
  #End Zoheb
  
})
