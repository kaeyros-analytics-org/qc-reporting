headerWalkthrough_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- actionButton(ns("helpAllgemein"), label = HTML('<i class="bi bi-geo"></i>'))
  
  return(out)
  
}


headerWalkthrough_server <- function(input,
                             output,
                             session,
                             dataset) {
  
  observeEvent(input$helpAllgemein, {
    
    if (dataset != "Home") {
      
      dataset <- dataset
      
      if (dataset == "Ressources") tabset = "global_situation"
      if (dataset == "Réemploies") tabset = filterStates$GTD_tabSetPanel
      if (dataset == "Recouvrement") tabset = filterStates$UCDP_GED_tabSetPanel
      
      if (tabset == "global_situation") {
        df <- helpText %>% 
          filter(item == "table")
        print(df)
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Weiter",
            "prevLabel" = "Zurück",
            "skipLabel" = "Schließen",
            "doneLabel" = "Schließen",
            steps = data.frame(
              element = as.vector(df$container),
              intro = as.vector(df$text)
            )
          )
        )
      } else if (tabset == "Réemploies") {
        df <- helpText %>% 
          filter(tabpanel == "network_situation")
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Weiter",
            "prevLabel" = "Zurück",
            "skipLabel" = "Schließen",
            "doneLabel" = "Schließen",
            steps = data.frame(
              element = as.vector(df$container),
              intro = as.vector(df$text)
            )
          )
        )
      }
    }
  })
}
