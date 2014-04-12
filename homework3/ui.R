shinyUI(
  pageWithSidebar(
      titlePanel("U.S. States 1970s Statistics"),
      sidebarPanel(width=3,
        conditionalPanel(condition="input.plotType=='Bubble Plot'",
        radioButtons("volumes","Size Bubble by:",choices=c("Area","Population","Density"),
                     ),
        selectInput("XAxis","On X-Axis:",choices=c("Income",
                                                   "Illiteracy",
                                                   "LifeExpectancy",
                                                   "Murder",
                                                   "HighSchoolGraduates",
                                                   "Frost"),
                    selected="LifeExpectancy"
                    ),
        selectInput("YAxis","On Y-Axis:",choices=c("Income",
                                                   "Illiteracy",
                                                   "LifeExpectancy",
                                                   "Murder",
                                                   "HighSchoolGraduates",
                                                   "Frost"),
                    selected="Illiteracy"
                    ),
        selectInput("Color","Color By:",choices=c("Income",
                                                        "Illiteracy",
                                                        "LifeExpectancy",
                                                        "Murder",
                                                        "HighSchoolGraduates",
                                                        "Frost"),
                    selected="HighSchoolGraduates"
                    ),
        checkboxGroupInput("region","Region:",choices=c("South",
                                                        "West",
                                                        "Northeast",
                                                        "North Central")
                           )
        ),
        conditionalPanel(condition="input.plotType=='Small Multiples Plot'",
                         radioButtons("volumes2","Size Bubble by:",choices=c("Area","Population","Density"),
                         ),
                         selectInput("XAxis2","On X-Axis:",choices=c("Income",
                                                                    "Illiteracy",
                                                                    "LifeExpectancy",
                                                                    "Murder",
                                                                    "HighSchoolGraduates",
                                                                    "Frost"),
                                     selected="LifeExpectancy"
                         ),
                         selectInput("YAxis2","On Y-Axis:",choices=c("Income",
                                                                    "Illiteracy",
                                                                    "LifeExpectancy",
                                                                    "Murder",
                                                                    "HighSchoolGraduates",
                                                                    "Frost"),
                                     selected="Illiteracy"
                         ),
                         selectInput("Color2","Color By:",choices=c("Income",
                                                                   "Illiteracy",
                                                                   "LifeExpectancy",
                                                                   "Murder",
                                                                   "HighSchoolGraduates",
                                                                   "Frost"),
                                     selected="HighSchoolGraduates"
                         ),
                         checkboxGroupInput("region2","Region:",choices=c("South",
                                                                         "West",
                                                                         "Northeast",
                                                                         "North Central")
                         )
        
      ),
      conditionalPanel(condition="input.plotType=='Geospatial Mapping'",
                       selectInput("Color3","Color By:",choices=c("Income",
                                                                  "Illiteracy",
                                                                  "LifeExpectancy",
                                                                  "Murder",
                                                                  "HighSchoolGraduates",
                                                                  "Frost",
                                                                  "Population",
                                                                  "Area",
                                                                  "Density"),
                                   selected="HighSchoolGraduates"
                                  ),
                       checkboxGroupInput("region3","Region:",choices=c("South",
                                                                        "West",
                                                                        "Northeast",
                                                                        "North Central")
                                          )
                      ),
      # Condition for Parallel Coordinates Plot
      conditionalPanel(condition="input.plotType=='Parallel Coordinates'",
                       checkboxGroupInput("variab","Choose Variables:",choices=c("Income",
                                                                          "Illiteracy",
                                                                          "LifeExpectancy",
                                                                          "Murder",
                                                                          "HighSchoolGraduates",
                                                                          "Frost",
                                                                          "Population",
                                                                          "Area",
                                                                          "Density")
                                          ),
                       checkboxGroupInput("regionpc","Region:",choices=c("South",
                                                                       "West",
                                                                       "Northeast",
                                                                       "North Central")
                       )
                       )    
      ),
      mainPanel(
          tabsetPanel(
              tabPanel("Bubble Plot",plotOutput("bubbleplot")),
              tabPanel("Small Multiples Plot",plotOutput("smallmultiples")),
              tabPanel("Parallel Coordinates",plotOutput("pcgraph"),
                       helpText("Select atleast two variables")),
              tabPanel("Geospatial Mapping",plotOutput("mapgraph")),
              id="plotType"
              ),width=9
      )
      
    )
  )
