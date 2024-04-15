# Define server logic ----
server <- function(input, output, session) {

  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  
  ######### Set the first active page Layout
  callModule(mainContentRouter_server, id = "mainContentRouter", dataset = "Home")
  callModule(filterStatesRouter_server, id = "filterStates", page = "Home")
  ####### Call module for start tour.
  callModule(headerWalkthrough_server, id = "walkthrough", input$datasetNav, layout = input$ressources_tabs)
  
  observeEvent(input$datasetNav, {
    ############ initialization of first call module for main content
    callModule(mainContentRouter_server, id = "mainContentRouter", dataset = input$datasetNav)
    callModule(filterStatesRouter_server, id = "filterStates", page = input$datasetNav)
  })
  
  ############## Icon selection for display modal form
  observeEvent(input$iconSelection, {
    callModule(headerFormModal_server, id = "formModal", iconSelection = input$iconSelection)
    callModule(headerFeedbackModal_server, id = "feedbackModal", iconSelection = input$iconSelection)
  })
  
  # callModule(headerMethodsModal_server, id = "methodsModal", filterStates = input$datasetNav)
  # callModule(headerDataModal_server, id = "dataModal", filterStates = input$datasetNav)
  
  
  ############## this button is for generate report - Button is in filter selection Page
  observeEvent(input$generate_report, {
    print("Generer le rapport")
  })
}