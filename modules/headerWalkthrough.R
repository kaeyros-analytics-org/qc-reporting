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
    print("Start Tour")
    if (dataset != "Home") {
      
      dataset <- dataset
      
      if (dataset == "Ressources") tabset = "global_situation"
      if (dataset == "Réemploies") tabset = "network_situation"
      if (dataset == "Recouvrement") tabset = "network_situation"
      
      if (tabset == "global_situation") {
        df <- helpText %>% 
          filter(tabpanel == "global_situation")
        print(df)
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Suivant",
            "prevLabel" = "Précédent",
            "skipLabel" = "Schließen",
            "doneLabel" = "Schließen",
            steps = data.frame(
              element = as.vector(df$container),
              intro = as.vector(df$text)
            )
          )
        )
      } else if (tabset == "network_situation") {
        df <- helpText %>% 
          filter(tabpanel == "network_situation")
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Suivant",
            "prevLabel" = "Précédent",
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
