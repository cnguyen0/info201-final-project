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
                            titlePanel('Title 1'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(

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
                              mainPanel("Plot",
                                plotOutput("remoteCountryPlot", 
                                           hover ="plot_hover", hoverDelay = 0,
                                           click = "plot_click"),
                                p(paste0("This plot shows mental health against different jobs and if a person works remotely or not.",
                                         "By clicking on each point above, the x and y values will be displayed in the box."))
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
                                
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                
                              )
                            )
                   )
                   
))