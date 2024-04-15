headerWalkthrough_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- actionButton(ns("startTour"), label = HTML('<i class="bi bi-geo"></i>'))
  
  return(out)
  
}


headerWalkthrough_server <- function(input,
                             output,
                             session,
                             dataset, layout) {
  
  observeEvent(input$startTour, {
    print("Start Tour")
    
    if (dataset != "Home") {
      
      print(layout)
      
      if (dataset == "Ressources") tabset = "global_situation"
      if (dataset == "Réemploies") tabset = ""
      if (dataset == "Recouvrement") tabset = ""
      if (dataset == "Production") tabset = ""
      
      if (tabset == "global_situation") {
        df <- helpText %>% 
          filter(tabpanel == "global_situation")
        print(df)
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Suivant",
            "prevLabel" = "Précédent",
            "skipLabel" = "Passer",
            "doneLabel" = "Ok",
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
            "skipLabel" = "Passer",
            "doneLabel" = "Ok",
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
