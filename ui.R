library(shiny)
library(plotly)

shinyUI(navbarPage('Final Project',
                   
                   tabPanel('Introduction',
                            titlePanel('Introduction'),
                            
                            mainPanel(
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
                                       addressing mental illness.")
                            )
                   ),
                   
                  #tab panel for Meet the team
                  tabPanel("Meet The Team",
                    mainPanel(img(src = "./Stephanie.jpg", height = 100, width = 100), h4("Stephanie Burd"),
                              br(),
                              img(src = "./Kathy.gif", height = 100, width = 100), h4("Kathy Chiu"),
                              br(),
                              img(src = "./Megha.jpg", height = 100, width = 100), h4("Megha Goel"),
                              br(),
                              img(src = "./Cee.jpg", height = 100, width = 100), h4("Cindy Nguyen"),
                              br(),
                              img(src = "./Zoheb.jpg", height = 100, width = 100), h4("Zoheb Sidiqui")
                              )
                  ),
                  
                  
                  # Create a tab panel for your map
                  tabPanel('Discussing Health with a Supervisor',
                           #titlePanel('Discussing Health with a Supervisor'),
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
                           h3("Analysis"),
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
                   
                   # tabPanel('Affect working remotely',
                   #          titlePanel('Affect on mental health while working remotely'),
                   #          # Create sidebar layout
                   #          sidebarLayout(
                   #            
                   #            # Side panel for controls
                   #            sidebarPanel(
                   #              sliderInput('age', 
                   #                          label="Age", 
                   #                          min= min(data$what.is.your.age.), max= max(data$what.is.your.age.), 
                   #                          value = data$what.is.your.age., step =1),
                   #              
                   #              selectInput('facet.by', 
                   #                          label="Facet By", 
                   #                          choices =  c("what.country.do.you.live.in.", 
                   #                                       "what.US.state.or.territory.do.you.live.in.", 
                   #                                       "what.country.do.you.work.in.", "what.US.state.or.territory.do.you.work.in."))
                   #            ),
                   #            
                   #            # Main panel: display plotly map
                   #            mainPanel("Plot",
                   #              plotOutput("remoteCountryPlot", 
                   #                         hover ="plot_hover", hoverDelay = 0,
                   #                         click = "plot_click"),
                   #              p(paste0("This plot shows mental health against different jobs and if a person works remotely or not.",
                   #                       "By clicking on each point above, the x and y values will be displayed in the box."))
                   #            )
                   #          )
                   # ),
                   
                   tabPanel('Kathy',
                            titlePanel('Number of Conditions a Worker Has and \nComfort talking to Supervisor'),
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
                                plotlyOutput("DiagnosisWillingness")  
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
                   
                   
                   tabPanel('Awareness issues/Stigmas about mental health',
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
