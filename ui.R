library(shiny)
library(plotly)

shinyUI(navbarPage('Final Project',
                   
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
                                    img(src = "./Stephanie.jpg", height = 100, width = 100), h4("Stephanie Burd")),
                             column(2,
                                    img(src = "./Kathy.gif", height = 100, width = 100), h4("Kathy Chiu")),
                             column(2,
                                    img(src = "./Megha.jpg", height = 100, width = 100), h4("Megha Goel"))
                             ),
                           
                           fluidRow(
                             column(2, offset = 4,
                                    img(src = "./Cee.jpg", height = 100, width = 100), h4("Cindy Nguyen")),
                             column(2,
                                    img(src = "./Zoheb.jpg", height = 100, width = 100), h4("Zoheb Sidiqui"))
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
                                 "Talk about some sort of analysis",
                                 plotOutput('familyBreakdown'),
                                 plotOutput('disorder')
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
