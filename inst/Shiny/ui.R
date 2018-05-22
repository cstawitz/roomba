require(shiny)
require(roomba)
require(purrr)
ui <- fluidPage(

    titlePanel("roomba"),
    sidebarLayout(
      sidebarPanel(
        p("An R package that allows for easy parsing of nested lists."),
        # Input: Slider to select JSON file ----
        fileInput(inputId = "data",
                  label = "Select a data file to import:",
                  accept = c('.json', '.rda'), multiple=FALSE),
        
        # Output: Names of first level list objects----
                  actionButton("makePlot", "Plot"),
                  checkboxGroupInput("Variables", "Select variables to plot:")
                            
          ),
          mainPanel(plotOutput("plot"))
    )
)
