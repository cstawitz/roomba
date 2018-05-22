# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
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
  observe({
    if(!is.null(input$data)){
    dataset <- datasetInput()
    column.names <- roomba::list_names(dataset)
    updateCheckboxGroupInput(session, "Variables", 
                             choices=sort(column.names))
    }
  })
  
  output$plot <- eventReactive(input$makePlot, 
                  {
                    dataset <- datasetInput()
                    thedata <-roomba::roomba(dataset, input$Variables)
                    thedata$created_at <- 
                      as.POSIXct(thedata$created_at, format="%a %b %d %H:%M:%S %z %Y")
                    
                    output$plot <- renderPlot(
                       ggplot(thedata) + 
                         geom_point(aes(x=name, y=created_at)) +
                                      theme(axis.text.x = element_text(angle = 90, hjust = 1),
                                            text = element_text(size=16))
                      )})
}
