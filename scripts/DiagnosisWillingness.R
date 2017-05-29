library(dplyr)
library(stringr)

data <- read.csv('../Data/mental-heath-in-tech-2016.csv') #will remove later


#DiagonosisWillingness <- function(data, diagonosis.status) {
#}
# selects observations that currently have mental health disorder
data <- data %>% filter(Do.you.currently.have.a.mental.health.disorder. == "Yes") %>%
                 select(If.yes..what.condition.s..have.you.been.diagnosed.with.,
                        Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..)

colnames(data) <- c("diagonosis.status", "comfort")

#create list of dataframes of diagnosis per observation
temp <- NumDiagnosis(data$diagonosis.status)
diagnosis.list <- sapply(data$diagonosis.status, NumDiagnosis)  



# Creates a vector of diagonosis 
# precondition: diagonosis listed in format of "<condition 1>|<condition 2>|<condition ...>"
#               each condition is seperated by vertical bar
#SplitDiagnosis
NumDiagnosis <- function(input) {
  return(stringr::str_split_fixed(input, pattern = "\\|", n = Inf) %>% length())
}
