# Define server logic ----
server <- function(input, output, session) {
  #ns <- session$ns
  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  print("server")
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
    shinyjs::disable("text_global_situation_tab_1")
    clicked_save(TRUE)
    
  })
  
  #enable comment when we click on edit
  observeEvent(input$edit,{
    shinyjs::enable("text_global_situation_tab_1")
    clicked_save(FALSE)
  })
  
  #reactive input for comment
  text1 <- eventReactive(input$save,{
    if(is.null(input$text_global_situation_tab_1)) {
      return(" ")
    } else {
      input$text_global_situation_tab_1
    }
  })
  
  ################ Apply filter woth sidebar DATA
  observeEvent(input$filter_data, {
    print("Apply the filter")
    filterStates$first_date <- lubridate::make_date(year(filterStates$date_start)-1 , 12, 31)
    filterStates$countrySelected <- input$countryInput
    filterStates$aggregateRange <- input$timeAggregationInput
    filterStates$date_start <- input$dateRangeInput[1]
    filterStates$date_end <- input$dateRangeInput[2]
    #filterStates$whoAsPrint <- input$eventTypePicker
    filterStates$whoAsPrint <- input$eventTypePicker
    filterStates$filterButton <- TRUE
  })
  
  ############### this input verify if it's possible to download the report
  clicked_save <- reactiveVal(FALSE)
  
  ########### click to generate report
  observeEvent(input$generate_report, {
    if(clicked_save() == FALSE) {
      showModal(modalDialog(
        title = "Generate Report Alert",
        "Vous devez sauvegarder vos commentaires avant de télécharger votre rapport."
      ))
    } else if (clicked_save() == TRUE) {
      shinyjs::click("download_report")
    }
  })
  
  ################ Download report button
  output$download_report <- downloadHandler(
    filename = function() {
      paste0("QC_Report_", Sys.Date(), ".docx", sep = "")
    },
    content = function(file) {
      doc <- generate_report(global_situation_tab_1(),global_situation_tab_1(),text1())
      print(doc, target = file)
    }
  )
}