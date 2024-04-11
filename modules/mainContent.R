mainContentRouter_ui <- function(id) {
  
  ns <- NS(id)

  out <- withSpinner(uiOutput(ns("mainContent")),
                     type = 8,
                     color = 'grey', size = 0.7)
  
  return(out)
  
}

mainContentRouter_server <- function(input, output, session, dataset) {
  ############# This UI is for ressources Layout Page
  ui_ressouces = Pivot(linkFormat = "tabs", 
                       PivotItem(headerText = "Situation Globale", global_situation_ui(session$ns("situation"))),
                       PivotItem(headerText = "Situation Par réseau", network_situation_ui(session$ns("network"))),
                       PivotItem(headerText = "Entrées en relation", enter_relation_ui(session$ns("relation"))),
                       PivotItem(headerText = "CPIO", cpio_ui(session$ns("cpio")))
  )
  ############# This UI is for Réemploies Layout Page
  ui_reemploie = Pivot(linkFormat = "tabs", 
                       PivotItem(headerText = "Layout 1", Label("Hello 1")),
                       PivotItem(headerText = "Layout 2", Label("Hello 2"))
  )
  
  
  ############# This UI is for recouvrement Layout Page
  ui_recouvrement = Pivot(linkFormat = "tabs", 
                          PivotItem(headerText = "Layout 1", Label("Hello 1")),
                          PivotItem(headerText = "Layout 2", Label("Hello 2"))
  )
  ############# This UI is for Production Layout Page
  ui_production = Pivot(linkFormat = "tabs", 
                        PivotItem(headerText = "Layout 1", Label("Hello 1")),
                        PivotItem(headerText = "Layout 2", Label("Hello 2"))
  )
  
  observeEvent(dataset, 
    { print(paste("mon dataset: ", dataset))
      # generate Ressources content ####
      if(dataset == "Ressources") {
        output$mainContent <- renderUI({
          ui_ressouces
        })
      # generate Réemploies content ####
      } else if(dataset == "Réemploies") {
        output$mainContent <- renderUI({
          ui_reemploie
        })
        # generate Recouvrement content ####
      } else if(dataset == "Recouvrement") {
        output$mainContent <- renderUI({
          ui_recouvrement
        })
        # generate Production content ####
      } else if(dataset == "Production") {
        output$mainContent <- renderUI({
          ui_production
        })
        # generate Home content ####
      } else { # Home
        output$mainContent <- renderUI({
          tagList(
            h2("Welcome to QC Reporting")
          )
        })
      }
      
  })

  observeEvent(input$ressources_tabs, {
    print("ok")
    cat("Vous avez cliqué sur le tabPanel avec l'ID :", input$ressources_tabs, "\n")
  })
  
  callModule(global_situation_server, id = "situation")
  callModule(network_situation_server, id = "network")
  callModule(enter_relation_server, id = "relation")
  callModule(cpio_server, id = "cpio")
}










