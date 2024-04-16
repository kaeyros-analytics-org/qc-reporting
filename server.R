# Define server logic ----
server <- function(input, output, session) {
  #ns <- session$ns
  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  
  ############ initialization of first call module for main content
  callModule(mainContentRouter_server, id = "mainContentRouter", dataset = "Home")
  callModule(filterStatesRouter_server, id = "filterStates", page = "Home")
  
  observeEvent(input$datasetNav, {
    callModule(mainContentRouter_server, id = "mainContentRouter", dataset = input$datasetNav)
    callModule(filterStatesRouter_server, id = "filterStates", page = input$datasetNav)
    callModule(headerWalkthrough_server, id = "walkthrough", dataset = input$datasetNav)
  })
  ############## Icon selection for display modal form
  observeEvent(input$iconSelection, {
    callModule(headerFormModal_server, id = "formModal", iconSelection = input$iconSelection)
    callModule(headerFeedbackModal_server, id = "feedbackModal", iconSelection = input$iconSelection)
  })
  
  # callModule(headerMethodsModal_server, id = "methodsModal", filterStates = input$datasetNav)
  # callModule(headerDataModal_server, id = "dataModal", filterStates = input$datasetNav)
  ###Reactive value for comment
  
  #reactive input for comment
  text1 <- reactive({
    if(is.null(input$text)) {
      return(" ")
    } else {
      input$text
    }
  })
  
  tab1 <- readxl::read_excel(fichier)
  tab2 <- readxl::read_excel(paste0(path,"/tab2.xlsx",sep=""), col_names = FALSE)
  
  #generation of the report
  output$generate_report <- downloadHandler(
    filename = function() {
      paste0("QC_Report_", Sys.Date(), ".docx", sep = "")
    },
    content = function(file) {
      doc <- generate_report(tab1,tab2,text1())
      print(doc, target = file)
    }
  )
}