library(dplyr)
library(rsconnect)

data <- read.csv('./Data/mental-heath-in-tech-2016.csv')

shinyServer(function(input, output) { 
  #Steph
  output$ComfortLevel <- renderPlot({
    comfort.level <- data[,11:12]
    colnames(comfort.level) <- c("Mental", "Physical")
    #Removing NA Values
    comfort.level <-  comfort.level[!(is.na(comfort.level$Mental) | comfort.level$Physical==""), ]
   
     #Filtering out Mental health data
    yes.mental <- filter(comfort.level, grepl("Yes", Mental)) %>%
                  count() %>%
                  as.numeric()
    maybe.mental <- filter(comfort.level, grepl("Maybe", Mental)) %>%
                    count() %>%
                    as.numeric()
    no.mental <- filter(comfort.level, grepl("No", Mental)) %>%
      count() %>%
      as.numeric()
    
    mental <- c(yes.mental, maybe.mental, no.mental)
    
    #Filtering out Physical health data
    yes.physical <- filter(comfort.level, grepl("Yes", Physical)) %>%
      count() %>%
      as.numeric()
    
    maybe.physical <- filter(comfort.level, grepl("Maybe", Physical)) %>%
      count() %>%
      as.numeric()
    
    no.physical <- filter(comfort.level, grepl("No", Physical)) %>%
      count() %>%
      as.numeric()
    
    physical <- c(yes.physical, maybe.physical, no.physical)
    
    #Creating the dataframe
    comfort.level.num <- data.frame(mental, physical)
    
    #plotting the data
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
  output$plotname <- renderPlot({
    
  })
  #End Zoheb
  
})