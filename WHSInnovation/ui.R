
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Innovative Ideas and Technologies"),
  
  h5("#VisualizeChange: A World Humanitarian Summit Data Challenge"),
  
  # plotOutput("needBar"),
  
  # hr(),
  
  # plotOutput("technologyBar"),
  
  # hr(),
  
  fluidRow(
    column(6,
           fluidRow(
               column(3,
                      checkboxGroupInput("checkGroupPublicInput", 
                                         label = h5("Public Input"), 
                                         choices = list("Submission to WHS" = 1, 
                                                        "Survey Results" = 2, 
                                                        "Stakeholder Consultation Report" = 3,
                                                        "External Conference Report" = 4,
                                                        "Key document" = 5,
                                                        "Other" = 6),
                                         selected = 1:6,
                                         inline = FALSE )
               ),
               column(3,
                      checkboxGroupInput("checkGroupWHSOutput", 
                                         label = h5("WHS Output"), 
                                         choices = list("Stakeholder Analysis Report" = 1, 
                                                        "Co-Chairs Summary" = 2, 
                                                        "Thematic report" = 3,
                                                        "Online consultation report" = 4,
                                                        "Other" = 5),
                                         selected = 1:5,
                                         inline = FALSE )             
               )
   
           ),
           fluidRow(
               column(3,
                      checkboxGroupInput("checkGroupRegionalContext", 
                                         label = h5("Regional Context"), 
                                         choices = list("WCA Documents" = 1, 
                                                        "NSEA Documents" = 2, 
                                                        "EOG Documents" = 3,
                                                        "MENA Documents" = 4,
                                                        "LAC Documents" = 5,
                                                        "Pacific Region" = 6,
                                                        "Global Documents" = 7,
                                                        "Other" = 8),
                                         selected = 1:8,
                                         inline = FALSE )
                      
               ),
               
               column(3,
                      checkboxGroupInput("checkGroupNationalContext", 
                                         label = h5("National Context"), 
                                         choices = list("Bahrain" = 1, 
                                                        "Barbados" = 2, 
                                                        "Trinidad and Tobago" = 3,
                                                        "Congo" = 4,
                                                        "Japan" = 5,
                                                        "New Zealand" = 6,
                                                        "Samoa" = 7,
                                                        "Solomon Islands" = 8,
                                                        "Other" = 9),
                                         selected = 1:9,
                                         inline = FALSE )               
               )
           ),
           fluidRow(
               column(6,
                      checkboxGroupInput("checkGroupStakeholderGroup", 
                                         label = h5("Stakeholder Group"), 
                                         choices = list("Affected Communities" = 1, 
                                                        "Civil Society Groups" = 2, 
                                                        "Local NGOs" = 3,
                                                        "Member States" = 4,
                                                        "UN Agency" = 5,
                                                        "INGOs" = 6,
                                                        "Regional Bodies" = 7,
                                                        "Academia" = 8,
                                                        "Multiple Stakeholders" = 9,
                                                        "Other" = 10),
                                         selected = 1:10,
                                         inline = FALSE )
                      
               )         
           )
         
    ),
    column(6,
            fluidRow(
                plotOutput("needBar")
            ),
           fluidRow(
               plotOutput("technologyBar")
           ),
           fluidRow(
               tableOutput('table')
           )
    )
  )

))
