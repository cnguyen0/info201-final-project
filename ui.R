library(shiny)
library(plotly)

shinyUI(navbarPage('Final Project',
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