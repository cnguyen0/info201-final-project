library(shiny)
library(shinythemes)
library(plotly)

data <- read.csv('./Data/mental-heath-in-tech-2016.csv', stringsAsFactors = FALSE)
source("./scripts/DiagnosisWillingness.R")

shinyUI(navbarPage('Final Project',
                   theme = shinytheme("superhero"),
            
                   tabPanel('Introduction',
                            
                            h3("Introduction", align = "center"),
                            
                            p("The dataset we will be working with is “OSMI Mental Health in Tech Survey 2016”
                                       and is sourced from Kaggle, (https://www.kaggle.com/osmi/mental-health-in-tech-2016).
                              This dataset includes survey results for a survey completed by Open Sourcing Mental 
                              Illness addressing attitudes toward mental illnesses in the tech industry. The target 
                              audience of this data is supervisors or managers at tech companies. By analyzing this 
                              data, we can give supervisors and managers insight into the stigma surrounding mental 
                              illness in their industry, allowing them to make positive changes. The audience 
                              will get deeper insight into the perceptions of mental illness in their workplace,
                              including comfort level addressing supervisors, the effect of addressing mental 
                              illness on career, and if any measures taken have changed their perception on
                              addressing mental illness.", align = "center"),
                            
                           hr(),
                           
                           #Meet the Team
                           h3("Meet the Team", align = "center"),
                           h4(a("Our Github", href = "https://github.com/cnguyen0/info201-final-project"), align = "center"),

                           fluidRow(
                             column(2, offset = 3,
                                    img(src = "./Stephanie.gif", height = 100, width = 100), h4("Stephanie Burd")),
                             column(2,
                                    img(src = "./Kathy.gif", height = 100, width = 100), h4("Kathy Chiu")),
                             column(2,
                                    img(src = "./Megha.gif", height = 100, width = 100), h4("Megha Goel"))
                             ),
                           
                           fluidRow(
                             column(2, offset = 4,
                                    img(src = "./Cee.gif", height = 100, width = 100), h4("Cindy Nguyen")),
                             column(2,
                                    img(src = "./Zoheb.gif", height = 100, width = 100), h4("Zoheb Sidiqui"))
                             )
                   ),
                  
                  # Create a tab panel
                  tabPanel('Discussing Health with a Supervisor',
                           h3('Discussing Health with a Supervisor', align = "center"),
                           p("The data that is represented on this page are responses to two questions regarding
                             employee mental and physical health. The first question asked if employees feel there
                             might be negative consequences for mentioning mental or physical health in the workplace. The
                             second question focuses on if an employee would bring up mental or physical health in an
                             interview with a potential employer."),
                           br(),
                           
                           # Create sidebar layout
                           sidebarLayout(
                             
                              # Side panel for controls
                              sidebarPanel(
                                  p("Please select a factor to toggle between comfort level discussing health and perceived negative impact.",
                                    align = "center"),
                                  radioButtons(inputId = "impact", label = "Select a Factor",
                                                     choices = c("Negative Impact", "Comfort Level Discussing Health"), selected = "Negative Impact")
                              ),
                              # Main panel: display plotly map
                              mainPanel(
                                plotOutput("ComfortLevel")
                              )
                            ),
                           hr(),
                           h3("Analysis", align = "center"),
                           p("As a supervisor, it is very important to be aware of the health of your employees.
                              However, many employees may be holding back their health issues due to fear of
                              it affecting their career. Based on data collected by Open Sourcing Mental Illness,
                              almost 250 tech employees believe that discussing a mental illness with their
                              supervisor will have a negative impact, but only about 40 employees believe that 
                              dicussing a physical ailment will have a negative impact."),
                           p("The tables turn when the survey participant is asked if they would mention mental
                              health in an interview. Over 650 employees would mention a mental illness in an 
                              interview, while only about 100 employees would mention a physical illness in an 
                              interview."),
                           p("Although it is impossible to draw conclusions from self-reported surveys, it still
                              gives us insight into the respresentation and stigma of mental illness in the workplace.
                              Human resources and project managers can use this information when considering new employees
                              for hire, or for creating a workplace environment that will be conducive and welcoming for
                              all employees to feel comfortable discussing mental health in the workplace.")

                           
                   ),
                   
                   tabPanel('Affect working remotely',
                            titlePanel('Affect on mental health while working remotely'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                sliderInput('age', 
                                            label="Age", 
                                            min= min(data$what.is.your.age.), max= max(data$what.is.your.age.), 
                                            value = data$what.is.your.age., step =1),
                                
                                selectInput('facet.by', 
                                            label="Facet By", 
                                            choices =  c("what.country.do.you.live.in.", 
                                                         "what.US.state.or.territory.do.you.live.in.", 
                                                         "what.country.do.you.work.in.", "what.US.state.or.territory.do.you.work.in."))
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotOutput("remoteCountryPlot"),
                                p(paste0("This plot shows mental health against different jobs and if a person works remotely or not.",
                                         "By clicking on each point above, the x and y values will be displayed in the box."))
                              )
                            )
                   ),
                   
                   tabPanel('Diagnoses and Comfort Speaking',
                            titlePanel('Diagnoses and Comfort Speaking'),
                              
                              p("In this dataset, we'll be looking at people who have been diagnosed or currently diagnosed with a 
                                mental health disorder and how comfortable they are discussing about mental health with their supervisors.
                                We'll also focus on whether the number of mental health conditions a person is diagnosed, and whether the 
                                topic of discussion is on mental health disorders or mental health issues, has any effects on this comfort."),
                              br(),
                            
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                selectInput("curr.or.pro.diag", label = "Condition Status", 
                                            choices = list("Currently Have Mental Health Disorder" = "curr",
                                                           "Diagnosed by Medical Professional" = "pro")),
                                selectInput("comfort", label = "Comfort Level Discussing with Supervisor about", 
                                            choices = list("Mental Health Disorder" = "disorder",
                                                           "Mental Health Issues" = "issue"))
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotlyOutput("DiagnosisWillingness"),
                                hr(),
                                p("From this dataset of about 1400 people, almost 600 people reported be currently
                                  diagnosed with at least one mental health disorder, and about half of the people 
                                  surveyed were diagnosed with at least one mental health disorder by a medical professional.
                                  However, there is generally a higher number of people with 1 to 3 diagnoses as opposed to people
                                  with 3 or more diagnoses. Therefore it cannot be concluded that there is a relationship between 
                                  the number of diagnoses and a person's comfort speaking to a supervisor about mental health disorders
                                  and issues."),
                                br(),
                                p("In the case of whether someone is comfortable with discussing based on the topic of either mental health disorders
                                   or mental health issues, the dataset did not give a definition for what is a mental health disorder and issue.
                                   However: "),
                                br(),
                                p("When asked, \"Would you feel comfortable discussing a mental health disorder with your direct supervisor(s)?\", 
                                  a majority felt they were comfortable discussing with either \"some of their previous employers\" 
                                  or \"none of their previous employers.\""),
                                p("When asked, \"Would you have been willing to discuss a mental health issue with your direct supervisor(s)?\",
                                   there's is generally a mixed distribution between the \"Yes,\" \"No,\" and \"Maybe's,\" but slight lean towards \"Yes\" and \"Maybe.\""),
                                br(),
                                p("Since much of the data used is qualitative data, it's difficult to judge its accuracy. However, the data still allows
                                   for employers to have some insight on how employees feel about discussing mental health with supervisors, and how to
                                   make the workplace a safer environment for such discussion.")
                              )
                            )
                   ),
                   
                   tabPanel('Family History of Mental Illnesses',
                            titlePanel('Family History of Mental Illnesses'),
                            h4('A closer look at those in the tech industry who has a family history of mental illnesses'),
                            p('In this dataset, we will be asking and analyzing some interesting questions about those who has
                              a family history of mental illnesses. The dataset has been filtered out so there are no empty answers. 
                              Note: This does not necessarily mean they themselves have a form of a disorder, but rather
                              has had a relative with a mental disorder.'),
                            fluidRow(
                              column(12,
                                 sidebarLayout(
                                   
                                   # Side panel for controls
                                   sidebarPanel(
                                     p("Please select one of the questions in the drop down menu below to find about how the
                                       questions break down within the group of those who has a family history of mental illnesses."),
                                     selectInput(
                                       inputId = 'categories',
                                       label = 'Select a factor',
                                       choices = list('Age' = 'What.is.your.age.',
                                                      'Working Remotely' = 'Do.you.work.remotely.', 
                                                      'Discussing mental illness' = 'Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..',
                                                      'Employers and mental illnesses' = 'Do.you.feel.that.your.employer.takes.mental.health.as.seriously.as.physical.health.')
                                     )
                                   ),
                                   
                                   # Main panel: display plotly map
                                   mainPanel(
                                     plotOutput('familyHistory')
                                   )
                                 )
                              )
                            ),
                            fluidRow(
                              column(12,
                                 textOutput('comfortableAnalysis')
                              )
                            )
                   ),
                   
                   
                   tabPanel('Awareness issues/Stigmas about mental health',
                            titlePanel('Graph options'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                selectInput(
                                  inputId = 'options',
                                  label = 'Select information that you want to view',
                                  choices = c('anonimity', 'coworker_discussion', 'supervisor_discussion', 'seriousness_comparison'),
                                  selected = 'anonimity'
                                )
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(plotlyOutput('plotZoheb'))
                            ),
                            hr(),
                            h3('Analysis'),
                            p('test para 1'),
                            p('test para 2')
                   )
                   
))
