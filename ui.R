library(shiny)
library(plotly)

shinyUI(navbarPage('Final Project',
                   
                   tabPanel('Introduction',
                            titlePanel('Introduction'),
                            
                            mainPanel(
                              p(paste0("The dataset we will be working with is “OSMI Mental Health in Tech Survey 2016” ",
                                       "and is sourced from Kaggle (https://www.kaggle.com/osmi/mental-health-in-tech-2016).",
                                       " This dataset includes survey results for a survey completed by Open Sourcing Mental ",
                                       "Illness addressing attitudes toward mental illnesses in the tech industry. The target ",
                                       "audience of this data is supervisors or managers at tech companies. By analyzing this ",
                                       "data, we can give supervisors and managers insight into the stigma surrounding mental ",
                                       "illness in their industry, allowing them to make positive changes. The audience ",
                                       "will get deeper insight into the perceptions of mental illness in their workplace,",
                                       " including comfort level addressing supervisors, the effect of addressing mental ",
                                       "illness on career, and if any measures taken have changed their perception on ",
                                       "addressing mental illness."))
                            )
                            ),
                   
                   # Create a tab panel for your map
                  tabPanel('Steph',
                            titlePanel('Discussing Health with a Supervisor'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                  radioButtons(inputId = "impact", label = "Impact",
                                                     choices = c("Negative Impact", "Comfort Level Discussing Health"), selected = "Negative Impact")
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotOutput("ComfortLevel")
                              )
                            ),
                           hr(),
                           p("As a supervisor, it is very important to be aware of the health of your employees.
                              However, many employees may be holding back their health issues due to fear of
                              it affecting their career. Based on data collected by Open Sourcing Mental Illness,
                              almost 250 tech employees beleive that discussing a Mental Illness with their
                              supervisor will have a negative impact, but only about 40 employees believe that 
                              dicussing a physical ailment will have a negative impact."),
                           p("The tables turn when the survey participant is asked if they would mention mental
                              health in an interview.")

                           
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
