
################ function to manage pivot item by id 
setClickedId <- function(inputId) {
  shiny.fluent::JS(glue::glue("item => Shiny.setInputValue('{inputId}', item.props.id)"))
}

mainContentRouter_ui <- function(id) {

  ns <- NS(id)
  fluentPage(withSpinner(uiOutput(ns("mainContent")),
                         type = 8,
                         color = 'grey', size = 0.7))

  # out <- withSpinner(uiOutput(ns("mainContent")),
  #                    type = 8,
  #                    color = 'grey', size = 0.7)

  #return(out)

}

mainContentRouter_server <- function(input, output, session, dataset) {
  ############# This UI is for ressources Layout Page
  ui_ressouces = Pivot(linkFormat = "tabs",
                       onLinkClick = setClickedId(session$ns("ressources_tabs")),#session$ns(
                       PivotItem(id = "global_situation", headerText = "Situation Globale", global_situation_ui(session$ns("situation"))),
                       PivotItem(id = "network_situation", headerText = "Situation Par réseau", network_situation_ui(session$ns("network"))),
                       PivotItem(id = "enter_relation", headerText = "Entrées en relation", enter_relation_ui(session$ns("relation"))),
                       PivotItem(id = "cpio", headerText = "CPIO", cpio_ui(session$ns("cpio")))
  )
  ############# This UI is for Réemploies Layout Page
  ui_reemploie = reemploie_ui(session$ns("reemploie"))
  
  
  ############# This UI is for recouvrement Layout Page
  ui_recouvrement = recouvrement_ui(session$ns("recouvrement"))
  
  
  ############# This UI is for Production Layout Page
  ui_production = production_ui(session$ns("production")) #session$ns
  
  observeEvent(dataset, 
    { print(paste("mon dataset: ", dataset))
      # generate Ressources content ####
      if(dataset == "Ressources") {
        output$mainContent <- renderUI({
          div( id = "navtabs",
               ui_ressouces
          )
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
            includeMarkdown("./www/htmlComponents/home.html"),
          )
        })
      }
      
  })

  observeEvent(input$ressources_tabs, {
    print("ok")
    cat(" dans ressources Vous avez cliqué sur le tabPanel avec l'ID :", input$ressources_tabs, "\n")
  })
  
  callModule(global_situation_server, id = "situation")
  callModule(network_situation_server, id = "network")
  callModule(enter_relation_server, id = "relation")
  callModule(cpio_server, id = "cpio")
  callModule(reemploie_server, id = "reemploie")
  callModule(recouvrement_server, id = "recouvrement")
  callModule(production_server, id = "production")
}










