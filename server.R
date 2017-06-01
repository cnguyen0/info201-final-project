library(dplyr)
library(rsconnect)
library(shiny)
library(ggplot2)
library(plotly)


data <- read.csv('./Data/mental-heath-in-tech-2016.csv', stringsAsFactors = FALSE)
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
  
  # Family History plot, with several questions
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
  
  # Breaking down  
  output$familyBreakdown <- renderPlot({
    not.comfortable <- data %>% filter(Do.you.have.a.family.history.of.mental.illness. == 'Yes') %>%
      filter(What.is.your.age. < 70) %>%
      filter(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. != '' || Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. != 'Yes' )
    ggplot(data = not.comfortable, aes(What.is.your.gender.)) + geom_bar()
  })
  
  output$disorder <- renderPlot({
    has.family.history <- data %>% filter(Do.you.have.a.family.history.of.mental.illness. == 'Yes')
    ggplot(data = has.family.history, aes(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..)) + geom_bar()
    
    ggplot(data = has.family.history, aes_string(input$categories)) + geom_bar() + 
      labs(x = x.axis.lab, y = "Count") + ggtitle("Breaking Down Questions of Answers of Those Who Has a Family History of Mental Illnesses")
  })
  
  output$comfortableAnalysis <- renderText({
    not.comfortable <- data %>% filter(Do.you.have.a.family.history.of.mental.illness. == 'Yes') %>%
      filter(Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. != '' || Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. != 'Yes' )
    
    male <- not.comfortable %>% filter(!grepl("f", What.is.your.gender., ignore.case = TRUE)) %>% 
      count() %>%
      as.numeric()

    female <- not.comfortable %>% filter(grepl("f", What.is.your.gender., ignore.case = TRUE)) %>% 
      count() %>%
      as.numeric()
    
    print(paste0("It is interesting to see the results of those who do have a family history of mental illnesses.
                                 Since mental illness has some of a presence in their life, would they not be more exposed to it and have
                                 more experiences handling mental illness as a topic? In questions such as \'Would you feel comfortable
                                 discussing a mental health disorder with your direct supervisors\', there was a high response rate of
                                 I don\'t know\'s and No\'s. To break that question further, within the group of people who does have a family history
                                 of mental illnesses and did not respond Yes to the question, there was ", female, " females and ", male, " males who may or 
                                may not feel comfortable in talking about mental disorders with their supervisors. The number of males doubles the number of female.
                                If we broke down the questions by gender, would this trend continue for males having a higher number in not sharing mental disorders
                                in the workplace? For future considerations, this data breakdown can be further broken into more genders since gender identity is
                                on a spectrum. In addition, another important factor is to compare by ratio rather than numbers since there is a significant number
                                of male in the workforce rather than female, which can lead to a misleading conclusion."))
  })
  
  #Megha
  output$remoteCountryPlot <- renderPlotly({
    
    relevant <- reactive({
      megha <- data %>% select(Do.you.work.remotely., Do.you.currently.have.a.mental.health.disorder.,
                               Have.you.been.diagnosed.with.a.mental.health.condition.by.a.medical.professional., 
                               What.is.your.age., contains("country"), contains("US.state.or.territory"))
      colnames(megha) <- c("remotely", "currently_have", "diagnosed", "age", "country_live", "country_work", "state_live", "state_work")
      
      megha <- filter(megha, age < 100)
      
      return(megha)
    })
    
    p <- ggplot(data = relevant(), 
                mapping = aes(x = remotely, 
                              y = age, 
                              color= diagnosed)) +
      geom_point(position ="jitter") +
      facet_wrap(input$facet.by) +
      labs(title ="Age vs. Working Remotely, identified by diagnosis",
           x = "Working Remotely",
           y = "Age")+
      guides(fill=guide_legend(title="Diagnosed"))
    
    p <- ggplotly(p) %>% layout(height = input$plotHeight, autosize=TRUE)
    return(p)
  })
  #End Megha
  
  #Kathy
  output$DiagnosisWillingness <- renderPlotly({
    return(DiagnosisWillingness(data, input$curr.or.pro.diag, input$comfort))
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
          title = as.character(dynamic.title$descriptions[dynamic.title$titles == as.character(input$options)])
        )
    )
  })
  #End Zoheb
  
})
