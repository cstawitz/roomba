#' Run the roomba app
#'
#' Run the roomba app
#' @export
#' @param browse Logical. Use browser for running Shiny app.
#' @examples
#' \dontrun{
#' if(require(shiny)){
#'    shiny_roomba()
#' }
#' }
shiny_roomba <- function(browse=TRUE){
  runApp(system.file('Shiny', package='roomba'), launch.browser = browse)
}
