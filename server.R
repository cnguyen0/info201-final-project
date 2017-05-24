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