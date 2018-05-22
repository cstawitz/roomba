ui <- fluidPage(
    titlePanel("rrroomba"),
    sidebarLayout(
      sidebarPanel(
        
        # Input: Slider to select JSON file ----
        fileInput(inputId = "data",
                  label = "Select a JSON file to import:",
                  accept = c('.json', '.rda')),
        
        # Output: Names of first level list objects----
        
           conditionalPanel(condition="length(input.file1)>0",
            fluidRow(column(4,verbatimTextOutput("names")))
          )),
      mainPanel(
       
      )
    )
  ) 


# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Allow data to change as input changes
  
  datasetInput <- reactive({
    input$data
           
  })
  
  #Print names of first level list items
  output$names <- renderPrint({
    dataset <- datasetInput()
    names(dataset)
  })
  
  # Show the first "n" observations ----
  #output$view <- renderTable({
  #  head(datasetInput(), n = input$obs)
  #})
}

require(shiny)
shinyApp(ui,server)
