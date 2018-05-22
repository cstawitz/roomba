# Define server logic required to draw a histogram ----
server <- function(input, output) {
  require(jsonlite)
  require(tools)

  # Allow data to change as input changes
  datasetInput <- reactive({
    #Determine if input file is .json or .rda
    if(tools::file_ext(input$data$name)=="json") {
      x <- jsonlite::fromJSON(input$data$datapath)
    } else if(tools::file_ext(input$data$name)=="rda"){
      load(input$data$datapath)
      assign("x", get(ls()))
    }
    return(x)
  })

  #Print names of first level list items
  output$varSet <- renderUI({
    dataset <- datasetInput()
    column.names <- roomba::list_names(dataset)
    checkboxGroupInput("Variables","Choose variables", column.names) 
  })

  # Show the first "n" observations ----
  #output$view <- renderTable({
  #  head(datasetInput(), n = input$obs)
  #})
}
