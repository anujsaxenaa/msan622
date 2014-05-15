library(shiny)
shinyUI(fluidPage(theme = "http://bootswatch.com/2/cyborg/bootstrap.min.css","Meteorites",
                  title = "Visualization",
                  fluidRow(
                    column(11.5,offset=0,plotOutput('visual1')),
                    column(7,offset=2,
                           sliderInput(
                             "start", 
                             "Years 1600-2013",
                             min = 1600, 
                             max = 2013,
                             value = 1600,
                             step = 10,
                             round = FALSE, 
                             ticks = FALSE,
                             format = "####.##",
                             #playButton
                             animate = animationOptions(
                               interval = 1300, 
                               loop = FALSE
                             )
                           )),
                    column(9,offset=1,plotOutput('histo',width=970)),
                           column(7,offset=2,
                                  sliderInput(
                             "yearRange", 
                             label=NULL,#"Years 1600-2013",
                             min = 1600, 
                             max = 2013,
                             value = c(1900,1950),
                             step = 1,
                             round = FALSE, 
                             ticks = FALSE,
                             format = "####.##",
                             #playButton
                             animate = FALSE)
                    )),
                  column(3,offset=0,plotOutput('visual2')),#,plotOutput('visual3')),
                  column(3,offset=0,plotOutput('visual3')),
#                   column(10),
#                   column(10),
#                   column(10),
#                   column(10),
#                   column(10),
#                   column(10),
#                   column(10),
#                   column(10),
#                   column(10),
                  column(3,offset=0,plotOutput('visual4')),#,plotOutput('visual5'))
                  column(3,offset=0,plotOutput('visual5')),
                  #h3(textOutput"caption"))
                  #column(10,offset=2,h3(textOutput("caption")))
                  column(5,offset=0,plotOutput('countryone')),
                  column(2,offset=0,
                  selectInput("nations","Pick by Country",
                   choices=c(unique(met3$Country)[order(unique(met3$Country))]),
                   selected="Algeria"
                              #choices=c(unique(d$Country)[order(unique(d$Country))]),selected="Algeria",
                  )),
                  column(7,offset=0,plotOutput('bar_cont',height=320))#,
                  #column(8,offset=0,tableOutput('tabl'))
                  #column(3,offset=0,plotOutput('fillCont'))
))
