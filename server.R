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
  
  observeEvent(input$generate_report,{
    shinyjs::runjs("document.getElementById('generate_report').click();")
  })
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
      tab2 <- readxl::read_excel(paste0(path,"/tab2.xlsx",sep=""), col_names = FALSE)
      doc <- docx(template="Rapport hebdo.docx") 
      # Change the default font size and font family
      options('ReporteRs-fontsize'=11, 'ReporteRs-default-font'='Trebuchet MS')
      doc <- addParagraph(doc,"La situation hebdomadaire du réseau First Bank à travers les agrégats repris comme suit : ")
      doc <- addParagraph(doc,"   ✓  Les ressources")
      doc <- addParagraph(doc,"   ✓  Les réemplois ")
      doc <- addParagraph(doc,"   ✓  Le recouvrement ")
      doc <- addParagraph(doc,"   ✓  La production")
      doc <- addParagraph(doc, " ")
      doc <- addParagraph(doc, "I.  LES RESSOURCES") 
      doc <- addParagraph(doc, " ")
      doc <- addParagraph(doc, "  A- Situaton Globale")
      doc <- addParagraph(doc, " ")
      doc <- addParagraph(doc, text1())
      tab <- FlexTable(tab1,)
      ret_corp <- FlexTable(tab2,header.columns=FALSE)
      tab <- setColumnsColors(tab, j=1, colors = "#FFC0CB" )
      tab <- setRowsColors(tab,i=c(1,12,16), colors="#808080")
      doc <- addFlexTable(doc, tab)
      doc <- addParagraph(doc, " ") 
      doc <- addFlexTable(doc, ret_corp)
      writeDoc(doc, file)
    }
  )
}