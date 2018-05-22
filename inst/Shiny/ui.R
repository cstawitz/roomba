require(shiny)
ui <- fluidPage(

    titlePanel("rrroomba"),
    sidebarLayout(
      sidebarPanel(
        
        # Input: Slider to select JSON file ----
        fileInput(inputId = "data",
                  label = "Select a JSON file to import:",
                  accept = c('.json', '.rda'))
        
        # Output: Names of first level list objects----
        
           #conditionalPanel(condition="length(input.data)>0",
            #fluidRow(column(4,verbatimTextOutput("names")))
          ),
      mainPanel()
    )
    )
