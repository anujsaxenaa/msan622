setwd("/MSAN/MSANSpring/MSAN622/DataViz/project")
library(rgdal)
library(ggplot2)


shinyServer(function(input, output) {
  cat("Press \'ESC\' to exit…\n")
  localFrame <- met
  output$visuals <- renderPlot({
    viz <- timemap(input$start,localFrame)
    print(viz)
  },bg="transparent")
})