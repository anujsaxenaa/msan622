#setwd("/MSAN/MSANSpring/MSAN622/DataViz/project2")

shinyServer(function(input, output) {
  cat("Press \'ESC\' to exit…\n")
  localFrame <- met3
  output$visual1 <- renderPlot({
    viz <- timemapmain(input$start,
                   localFrame)
    print(viz)
  },bg="transparent")
  output$visual2 <- renderPlot({
    viz <- orthomap(input$start,
                    input$yearRange,
                    "A",
                    localFrame)
    print(viz)
  },bg="transparent")
  output$visual3 <- renderPlot({
    viz <- orthomap(input$start,
                    input$yearRange,
                    "EA",
                    localFrame)
    print(viz)
  },bg="transparent")
  output$visual4 <- renderPlot({
    viz <- orthomap(input$start,
                    input$yearRange,
                    "AN",
                    localFrame)
    print(viz)
  },bg="transparent")
  output$visual5 <- renderPlot({
    viz <- orthomap(input$start,
                    input$yearRange,
                    "AC",
                    localFrame)
    print(viz)
  },bg="transparent")
  output$histo <- renderPlot({
    viz <- movingHist(localFrame,
                      input$yearRange)
    print(viz)
  },bg="transparent")
  output$countryone <- renderPlot({
    viz <- sub_cont(localFrame,
                    input$nations)
    print(viz)
  },bg="transparent")
  output$fillCont <- renderPlot({
    viz <- fill_cont(localFrame,
                     input$nations)
    print(viz)
  },bg="transparent")
  output$bar_cont <- renderPlot({
    viz <- met_bar(localFrame,
                   input$nations)
    print(viz)
  },bg="transparent")
})


