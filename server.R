# Define server logic ----
server <- function(input, output, session) {
  #ns <- session$ns
  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  
  filterStates <- reactiveValues(
    # dataset
    dataNavi = list(dataset = "Home"),
    filterButton = NULL
  )
  
  ######### Set the first active page Layout
  callModule(mainContentRouter_server, id = "mainContentRouter", dataset = "Home")
  callModule(filterStatesRouter_server, id = "filterStates", page = "Home")
  observeEvent(input$datasetNav, {
    ############ initialization of first call module for main content
    callModule(mainContentRouter_server, id = "mainContentRouter", dataset = input$datasetNav)
    callModule(filterStatesRouter_server, id = "filterStates", page = input$datasetNav)
  })
  
  ####### Call module for start tour.
  callModule(headerWalkthrough_server, id = "walkthrough", filterStates = filterStates)
  
    observeEvent(input$datasetNav,
    {
      filterStates$dataNavi$dataset <- input$datasetNav
      #message(filterStates[[paste0(filterStates$dataNavi$dataset, "_tabSetPanel")]])
    })
  
  ############## Icon selection for display modal form
  observeEvent(input$iconSelection, {
    callModule(headerFormModal_server, id = "formModal", iconSelection = input$iconSelection)
    callModule(headerFeedbackModal_server, id = "feedbackModal", iconSelection = input$iconSelection)
  })
  
  # callModule(headerMethodsModal_server, id = "methodsModal", filterStates = input$datasetNav)
  # callModule(headerDataModal_server, id = "dataModal", filterStates = input$datasetNav)
  ###Reactive value for comment
  
  # observeEvent(input$generate_report,{
  #   shinyjs::runjs("document.getElementById('generate_report').click();")
  # })
  
  #reactive input for comment
  text1 <- reactive({
    if(is.null(input$text)) {
      return(" ")
    } else {
      input$text
    }
  })
 
  #generation of the report
  output$generate_report <- downloadHandler(
    filename = function() {
      paste0("QC_Report_", Sys.Date(), ".docx", sep = "")
    },
    content = function(file) {
      tab1 <- readxl::read_excel(fichier)
      path <- paste0(getwd(),"/data")
      tab2 <- readxl::read_excel(paste0(path,"/tab2.xlsx",sep=""), col_names = FALSE)
      doc <- generate_report(tab1=tab1, tab2=tab2, text1=text1())
      writeDoc(doc, file)
    }
  )
}