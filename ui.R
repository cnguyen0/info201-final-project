library(shiny)
library(plotly)

shinyUI(navbarPage('Final Project',
                   
                   tabPanel('Introduction',
                            titlePanel('Introduction'),
                            
                            mainPanel(
                              "The dataset we will be working with is \"OSMI Mental Health in Tech Survey 2016\" and is sourced from Kaggle (https://www.kaggle.com/osmi/mental-health-in-tech-2016). This dataset includes survey results for a survey completed by Open Sourcing Mental Illness addressing attitudes toward mental illnesses in the tech industry. The target audience of this data is supervisors or managers at tech companies. By analyzing this data, we can give supervisors and managers insight into the stigma surrounding mental illness in their industry, allowing them to make positive changes. The audience will get deeper insight into the perceptions of mental illness in their workplace, including comfort level addressing supervisors, the effect of addressing mental illness on career, and if any measures taken have changed their perception on addressing mental illness."
                            )
                            ),
                   
                   # Create a tab panel for your map
                  tabPanel('Steph',
                            titlePanel('Title 1'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                  checkboxGroupInput(inputId = "impact", label = "Impact",
                                                     choices = c("Negative Consequences", "Comfort Level Discussing Health"))
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotOutput("ComfortLevel")
                              )
                            )
                   ),
                   
                   tabPanel('Megha',
                            titlePanel('Title 1'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                
                              )
                            )
                   ),
                   
                   tabPanel('Kathy',
                            titlePanel('Title 1'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                
                              )
                            )
                   ),
                   
                   tabPanel('Cindy',
                            titlePanel('Family History'),
                            fluidRow(
                              column(12,
                                 sidebarLayout(
                                   
                                   # Side panel for controls
                                   sidebarPanel(
                                     "Introduction about family history here! The data are the answers of those who said they have a family history of mental illness. We will be exploring the dataset within this scope to find something interesting that I will talk about later.",
                                     selectInput(
                                       inputId = 'categories',
                                       label = 'Select a factor',
                                       choices = c('What.is.your.age.', 'Do.you.work.remotely.', 'Would.you.feel.comfortable.discussing.a.mental.health.disorder.with.your.direct.supervisor.s..', 'Do.you.feel.that.your.employer.takes.mental.health.as.seriously.as.physical.health.')
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
                                 "Talk about some sort of analysis",
                                 plotOutput('familyBreakdown'),
                                 plotOutput('disorder')
                              )
                            )
                   ),
                   
                   
                   tabPanel('Zoheb',
                            titlePanel('Title 1'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                selectInput(
                                  inputId = 'options',
                                  label = 'select a query',
                                  choices = c('anonimity', 'coworker_discussion', 'supervisor_discussion', 'seriousness_comparison'),
                                  selected = 'anonimity'
                                )
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(plotlyOutput('plotZoheb'))
                            )
                   )
                   
))
