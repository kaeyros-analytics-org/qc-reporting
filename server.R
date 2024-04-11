# Define server logic ----
server <- function(input, output, session) {

  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  callModule(mainContentRouter_server, id = "mainContentRouter", dataset = "Home")
  observeEvent(input$datasetNav, {
    callModule(mainContentRouter_server, id = "mainContentRouter", dataset = input$datasetNav)
  })
  
  observeEvent(input$generate_report, {
    print("Generer le rapport")
  })
}