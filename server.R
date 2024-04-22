# Define server logic ----
server <- function(input, output, session) {
  ns <- session$ns
  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  
  ######### Set the first active page Layout
  callModule(mainContentRouter_server, id = "mainContentRouter", dataset = "Home")
  observeEvent(input$datasetNav, {
    ############ initialization of first call module for main content
    callModule(mainContentRouter_server, id = "mainContentRouter", dataset = input$datasetNav)
  })
  
  ########## Call filter server module
  callModule(filterStatesRouter_server, id = "filterStates", filterStates = filterStates)
  
  ####### Call server module for start tour.
  callModule(headerWalkthrough_server, id = "walkthrough", filterStates = filterStates)
  
    observeEvent(input$datasetNav,
    {
      filterStates$allDataset <- input$allNav
      filterStates$whoAsPrint <- c("Situation Globale", "Situation Par réseau", "Entrées en relation", "CPIO")
      filterStates$dataNavi$dataset <- input$datasetNav
      #message(filterStates[[paste0(filterStates$dataNavi$dataset, "_tabSetPanel")]])
    })
  
  ############## Icon selection for display modal form
  observeEvent(input$iconSelection, {
    callModule(headerFormModal_server, id = "formModal", iconSelection = input$iconSelection)
    callModule(headerFeedbackModal_server, id = "feedbackModal", iconSelection = input$iconSelection)
  })
  
  #disable comment when we click on save
  observeEvent(input$save,{
    shinyjs::disable("text1")
  })
  
  #enable comment when we click on edit
  observeEvent(input$edit,{
    shinyjs::enable("text1")
  })
  
  output$text1 <- renderUI({
    textAreaInput("text",label="",placeholder = "Write your comments here",height="380px",width="600px")
  })
  #reactive input for comment
  text1 <- eventReactive(input$save,{
    if(is.null(input$text)) {
      return(" ")
    } else {
      input$text
    }
  })
    
  tab1 <- readxl::read_excel(fichier)
  tab2 <- readxl::read_excel(paste0(path,"/tab2.xlsx",sep=""))
  tab2 <- tab2 %>% dplyr::rename(`18/01/2024`=`18/01/2024 ...2`) %>%
    dplyr::rename(`25/01/2024`=`25/01/2024 ...3`) %>%
    dplyr::rename(`Variation`=`Variation ...4`) %>%
    dplyr::rename(`18/01/2024 `=`18/01/2024 ...6`) %>%
    dplyr::rename(`25/01/2024 `=`25/01/2024 ...7`) %>%
    dplyr::rename(`Variation `=`Variation ...8`)
  
  ################ Apply filter woth sidebar DATA
  observeEvent(input$filter_data, {
    print("Apply the filter")
    filterStates$first_date <- lubridate::make_date(year(filterStates$date_start)-1 , 12, 31)
    filterStates$countrySelected <- input$countryInput
    filterStates$aggregateRange <- input$timeAggregationInput
    filterStates$date_start <- input$dateRangeInput[1]
    filterStates$date_end <- input$dateRangeInput[2]
    #filterStates$whoAsPrint <- input$eventTypePicker
    filterStates$filterButton <- TRUE
  })
  
  output$generate_report <- downloadHandler(
    filename = function() {
      paste0("QC_Report_", Sys.Date(), ".docx", sep = "")
    },
    content = function(file) {
      if(is.null(input$save)) {
        showModal(modalDialog(
          title = "Alert",
          "Please you have to save your comments before downloading your report!"
        ))
      } else {
        doc <- generate_report(tab1,tab2,text1())
        print(doc, target = file)
      }
    }
  )
}