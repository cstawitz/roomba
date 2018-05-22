ui <- fluidPage(
    titlePanel("rrroomba"),
    sidebarLayout(
      sidebarPanel(
        
        # Input: Slider to select JSON file ----
        fileInput(inputId = "data",
                  label = "Select a JSON file to import:",
                  accept = c('.json', '.rda'), multiple=FALSE),
        
        # Output: Names of first level list objects----
        
           conditionalPanel(condition="is.null(input.file1)",
            fluidRow(column(4,verbatimTextOutput("names")))
          )),
      mainPanel(
       
      )
    )
  ) 


# Define server logic required to draw a histogram ----
server <- function(input, output) {
  require(jsonlite)
  # Allow data to change as input changes
  
  datasetInput <- reactive({
    jsonlite::fromJSON(input$data$datapath)
           
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
