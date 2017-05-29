library(dplyr)
library(stringr)
library(plotly)

#data <- read.csv('../Data/mental-heath-in-tech-2016.csv') 


DiagonosisWillingness <- function(data.frame, comfort) {

# selects observations that currently have mental health disorder
#data <- data %>% filter(Do.you.currently.have.a.mental.health.disorder. == "Yes") %>%
#                 select(If.yes..what.condition.s..have.you.been.diagnosed.with.,
#                        Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..)

#data <- data %>% filter_(condition.status[1] == "Yes") %>%
#                 select_(condition.status[2], comfort)

#colnames(data) <- c("diagonosis.status", "comfort.level")

#create list of number of diagnosis per observation
data$num.conditions <- sapply(data$diagonosis.status, NumDiagnosis) 


plot <- plot_ly(data = data, 
                x = ~num.conditions, 
                y = eval(parse(text = paste("~", comfort))), 
                color = ~diagonosis.status,
                type = "scatter", 
                mode = "markers",
                marker = list(opacity = 0.5)) %>% 
  layout(xaxis = list(title = "Number of Diagnosis"), 
         yaxis = list(title = "Comfortability talking to supervisor"))

  return(plot)
}


# Counts number of diagnosis per obersevation 
# precondition: diagonosis listed in format of "<condition 1>|<condition 2>|<condition ...>"
#               each condition is seperated by vertical bar
#SplitDiagnosis
NumDiagnosis <- function(input) {
  return(str_split_fixed(input, pattern = "\\|", n = Inf) %>% length())
}
