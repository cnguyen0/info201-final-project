library(dplyr)
library(rsconnect)
library(shiny)
library(ggplot2)

data <- read.csv('./Data/mental-heath-in-tech-2016.csv')

shinyServer(function(input, output) { 
  
  #Steph
  output$ComfortLevel <- renderPlot({
<<<<<<< HEAD
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

=======

>>>>>>> 5919bad38c44fd0367f8c9276f58bb8e75588d50
    
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