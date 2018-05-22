# Define server logic required to draw a histogram ----
server <- function(input, output) {
  require(jsonlite)
  require(tools)
  library(roomba)
  require(ggplot2)

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
  
  output$plot <- eventReactive(input$makePlot, 
                  {
                    dataset <- datasetInput()
                    thedata <-roomba::roomba(dataset, input$Variables)
                    thedata$created_at <- 
                      as.POSIXct(thedata$created_at, format="%a %b %d %H:%M:%S %z %Y")
                    
                    output$plot <- renderPlot(
                       ggplot(thedata) + geom_point(aes(x=name, y=created_at))
                      )})
}
