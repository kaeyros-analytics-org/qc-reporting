# Define server logic ----
server <- function(input, output, session) {

  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  callModule(mainContentRouter_server, id = "mainContentRouter", dataset = "Home")
  callModule(filterStatesRouter_server, id = "filterStates", page = "Home")
  observeEvent(input$datasetNav, {
    callModule(mainContentRouter_server, id = "mainContentRouter", dataset = input$datasetNav)
    callModule(filterStatesRouter_server, id = "filterStates", page = input$datasetNav)
  })
  
  ############## this button is for generate report - Button is in filter selection Page
  observeEvent(input$generate_report, {
    print("Generer le rapport")
  })
}