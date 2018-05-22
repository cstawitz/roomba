require(shiny)
require(roomba)
require(purrr)
ui <- fluidPage(

    titlePanel("rrroomba"),
    sidebarLayout(
      sidebarPanel(
        
        # Input: Slider to select JSON file ----
        fileInput(inputId = "data",
                  label = "Select a JSON or Rda file to import:",
                  accept = c('.json', '.rda'), multiple=FALSE),
        
        # Output: Names of first level list objects----
        
           conditionalPanel(condition="length(input.data)>0",
            fluidRow(column(4,verbatimTextOutput("names")))),
           conditionalPanel(condition="length(output.varSet)>0",
                            uiOutput("varSet"), 
                            actionButton("makePlot", "Plot"))
          ),
          mainPanel(conditionalPanel(condition="length(output.varSet)>0",
                                 plotOutput("plot")))
    )
)
