#setwd("/MSAN/MSANSpring/MSAN622/DataViz/testing")
library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("IMDB Movie Ratings"),
    sidebarPanel(
      selectInput("whichbk","Select Book",
                  choices=c("Harry Potter & the Philosopher's Stone"="Harry_Potter1",
                            "Harry Potter & the Chamber of Secrets"="Harry_Potter2",
                            "Harry Potter & the Prisoner of Azkaban"="Harry_Potter3",
                            "Harry Potter & the Goblet of Fire"="Harry_Potter4",
                            "Harry Potter & the Order of the Phoenix"="Harry_Potter5",
                            "Harry Potter & the Half Blood Prince"="Harry_Potter6",
                            "Harry Potter & the Deathly Hallows"="Harry_Potter7")
                  )),
      mainPanel(
        tabsetPanel(tabPanel("Bar Plot",
                             plotOutput("wordCloud"))
                    )
                )
                )
                  )
