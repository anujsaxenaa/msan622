setwd("/MSAN/MSANSpring/MSAN622/DataViz/project")
library(shiny)
shinyUI(fluidPage(
#   fluidRow(column(1,offset=1,h4("testing"),sliderInput("test","testing man:",min=0,max=100,
#                                                        value=50,step=1))),
  tags$head(
    tags$style("body {background-color: grey; }")
  ),
  title = "Visualization",
  plotOutput('visuals'),
  #hr(),
  
  fluidRow(
    column(3,offset=0,
           h4("timeline",align="center"),
           sliderInput(
             "start", 
             "Starting Point:",
             min = 1600, 
             max = 2013,
             value = 1600, 
             step = 1,
             round = FALSE, 
             ticks = TRUE,
             format = "####.##",
             animate = animationOptions(
               interval = 800, 
               loop = FALSE
                                        )
                        ),
           checkboxGroupInput("type","Choose Meteor Type",choices=c("Fell","Found"))
            ),
    column(3,offset=0,
           h4("Choose",align="center"),
           selectInput("continents","Pick by Continent",choices=c()),
           selectInput("nations","Pick by Country",choices=c())
           ),
    column(3,offset=0,
           h4("Orientation",align="center"),
           selectInput("orientation","Select Orientation",choices=c()
                       )
           )
            )
                  )
        )

