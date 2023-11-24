library(debrowser)
library(shiny)

sink(stdout())

startDEBrowserDocker <- function() {

    port <- 8088
    if (!is.na(Sys.getenv("DEBROWSER_PORT", unset = NA))) {
        port <- as.integer(Sys.getenv("DEBROWSER_PORT"))
    }

    options( shiny.maxRequestSize = 30 * 1024 ^ 2, warn = -1,
                shiny.sanitize.errors = TRUE,
                shiny.port = port,
                shiny.host = "0.0.0.0",
                shiny.launch.browser = FALSE)
    addResourcePath(prefix = "demo", directoryPath =
                    system.file("extdata", "demo", 
                    package = "debrowser"))
    addResourcePath(prefix = "www", directoryPath =
                    system.file("extdata", "www", 
                    package = "debrowser"))
    environment(deServer) <- environment()

    app <- shinyApp( ui = shinyUI(deUI),
                server = shinyServer(deServer))
    runApp(app)
}

startDEBrowserDocker()