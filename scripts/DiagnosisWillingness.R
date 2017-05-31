library(dplyr)
library(stringr)
library(plotly)

# Creates heatmap of relationship between number of diagnosis and comfort with speaking to supervisor
DiagnosisWillingness <- function(data, curr.or.pro.diag, comfort) {
  
  margin.values <- list(
    l = 150
  )
  
  # selects data focusing on either "currently diagnosed with mental health disorder" or
  # "was diagnosed with mental health disorders by a professional to dataframe "data
  if (curr.or.pro.diag == "curr") {
      data <- data %>% filter(Do.you.currently.have.a.mental.health.disorder. == "Yes") %>% 
      select(If.yes..what.condition.s..have.you.been.diagnosed.with.,
             Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..,
             Would.you.have.been.willing.to.discuss.a.mental.health.issue.with.your.direct.supervisor.s..)
    } else if (curr.or.pro.diag == "pro") { 
    data <- data %>% filter(Have.you.been.diagnosed.with.a.mental.health.condition.by.a.medical.professional. == "Yes") %>%
      select(If.so..what.condition.s..were.you.diagnosed.with.,
             Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..,
             Would.you.have.been.willing.to.discuss.a.mental.health.issue.with.your.direct.supervisor.s..)
  }
  
  # removes uneeded columns from dataframe "data" depending on if asking for comfort speaking to supervisor
  # about mental health disorder vs mental health issues 
  if (comfort == "disorder") {
    data$Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s.. = NULL
    
    margin.values <- list(
      l = 300
    )
  } else if (comfort == "issue") {
    data$Would.you.have.been.willing.to.discuss.a.mental.health.issue.with.your.direct.supervisor.s.. = NULL
  }
  
  colnames(data) <- c("diagnosis.status", "comfort") 
  
  #create list of number of diagnosis per observation
  data$num.conditions <- sapply(data$diagnosis.status, NumDiagnosis) 
  data <- group_by(data, comfort, num.conditions) %>% summarise(n = n())
  data <- filter(data, comfort != "")
  

  
  plot <- plot_ly(data = data,
                  x = ~num.conditions,
                  y = ~comfort,
                  z = ~n,
                  type = "heatmap",
                  mode = "markers",
                  hoverinfo = "text",
                  text = ~paste0("Number of Conditions: ", data$num.conditions,  "\n",
                                  "Comfort Level: ", data$comfort,  "\n",
                                  "Frequency: ", data$n)) %>% 
          layout(title = "Number of diagnosed Conditions vs Comfort",
                 xaxis = list(title = "Number of Diagnosis"), 
                 yaxis = list(title = "Comfortability talking to supervisor"),
                 margin = margin.values)

  return(plot)
}


# Counts number of diagnosis per obersevation 
# precondition: diagnosis listed in format of "<condition 1>|<condition 2>|<condition ...>"
#               each condition is seperated by vertical bar
NumDiagnosis <- function(input) {
  return(str_split_fixed(input, pattern = "\\|", n = Inf) %>% length())
}


