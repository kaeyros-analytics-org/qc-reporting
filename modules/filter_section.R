filterStatesRouter_ui <- function(id) {
  
  ns <- NS(id)
  fluentPage(
    shinyjs::useShinyjs(),
    tags$style("
      #dateToEvaluate {
          width: 90%;
          margin: auto;
      }"
    ),
    div(id = "filterBox",
        uiOutput(ns("country")),
        uiOutput(ns("dateRange")),
        uiOutput(ns("dateToEvaluate")),
        uiOutput(ns("timeAggregation")),
        uiOutput(ns("eventTypeSelection")),
        ################### This button apply a filter
        uiOutput(ns("filter_button")),
        tags$br(),        
        uiOutput(ns("countryselect")),
        
        ############ This button is for generate and Download report in .docx format
        uiOutput(ns("generate"))
    )
  )
  
}

filterStatesRouter_server <- function(input, output, session, filterStates) {
  #ns <- session$ns
  observeEvent(filterStates$dataNavi$dataset, {
    if(filterStates$dataNavi$dataset == "Home"){ ########## We don't need to display filter when we are at home page.
      
      output$dateRange <- renderUI({
        "Quit home to see filter."
      })
      output$timeAggregation <- renderUI({
        ""
      })
      output$country <- renderUI({
      ""
      })
      output$filter_button <- renderUI({
        ""
      })
      
      output$generate <- renderUI({
        ""
      })
      
      output$dateToEvaluate <- renderUI({
        ""
      })
      output$eventTypeSelection <- renderUI({ 
        ""  
      })
      output$countryselect <- renderUI({
        ""
      })
    }else{
      ################## Date filter
      output$dateRange <- renderUI({
        tagList(
          div(class="sidebar-header", tags$a("Choose date range: ")),
          backendTooltip(span(`data-toggle`="tooltip", 
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Choississez l'écart de de date. Il doit être d'une semaine max.<br/>
                           <b>Comment ça fonctionne:</b><br/>
                           Crée une paire d'entrées de texte qui, lorsqu'elles sont cliquées,
                          font apparaître des calendriers sur lesquels l'utilisateur peut cliquer pour sélectionner des dates..", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          dateRangeInput("dateRangeInput", label = "",
                         start = as.Date("2024-1-18"), end = as.Date("2024-1-25"),
                         min = "2021-10-20", max = "2024-3-31"),
          tags$script(src = "./js/tooltip.js")
        )
      })
      
      ################## Time aggregation filter
      output$timeAggregation <- renderUI({
        selection <- "week"
        choices = c("Jour", "Semaine", "Mois", "Annee")
        tagList(
          div(class="sidebar-header", tags$a("Temps d'agrégation: ")),
          backendTooltip(span(`data-toggle`="tooltip", 
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Vous pouvez choisir ici la manière dont les données doivent être agrégées dans le temps. 
                            Cette sélection a un impact important sur les graphiques linéaires dans les différents domaines d'analyse.", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          selectInput("timeAggregationInput", label = NULL,
                      choices = choices, selected = selection)
        )
      })
      
      ################## Country selection filter
      output$country <- renderUI({
        selection <- "Cameroun"
        choices = c("Cameroun", "Congo", "Guinnée", "Tchad")
        tagList(
          div(class="sidebar-header", tags$a("Sélection du pays: ")),
          backendTooltip(span(`data-toggle`="tooltip",
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Vous pouvez choisir le pays. 
                            Cette sélection a un impact sur les données affichés", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          selectInput("countryInput", label = NULL,
                      choices = choices, selected = selection)
        )
      })
      ########################" dateToEvaluate filter
      output$dateToEvaluate <- renderUI({
        tagList(
          div(class="sidebar-header", tags$a("Date d'évaluation: ")),
          backendTooltip(span(`data-toggle`="tooltip", 
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Vous pouvez choisir ici la date à partir de laquelle les données seront évaluer.", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          dateInput("dateToEvaluate", "", value = "2024-01-01")
        )
      })
      
      output$filter_button <- renderUI({
        DefaultButton.shinyInput("filter_data", class = "btn-filter",
                                 text = "Appliquer le filtre",
                                 iconProps = list(iconName = "Refresh"),
                                 style = "background-color: #0093FF; color: #fff;"
        )
      })
      
      output$generate <- renderUI({
        #uiOutput("generate_report")
        downloadButton("generate_report", "Download as.docx)",
           style = "background-color: #0093FF; color: #fff; display: block; margin: auto; width: 70%;")
        #actionButton("generate_report", "Download as Word (.docx)")
        # DefaultButton.shinyInput("generate_report",
        #                          text = "Generate Report",
        #                          iconProps = list(iconName = "Download"),
        #                          style = "background-color: #D00000; color: #fff; display: block; margin: auto; top: 300px;"
        # )
      })
      
      output$eventTypeSelection <- renderUI({
        
          choices <- c(paste0("Ressouces", " - ", filterStates$whoAsPrint), "Réemploies", "Recouvrement", "Production")  
        
          tagList(
            div(tabindex="0", `aria-label` = "Ereignistyp", class="sidebar-header", tags$a("Quel élément doit être générer? ")),
            backendTooltip(span(`data-toggle`="tooltip", 
                                `data-placement`="right", 
                                `data-html` = "true",
                                title = "Choississez les éléments qui vont être generer dans le document word.", 
                                HTML('<i class="bi bi-question-circle"></i>'))),
            pickerInput("eventTypePicker",
                        label = NULL,
                        choices = choices,
                        multiple = T,
                        width = "100%",
                        options = pickerOptions(
                          actionsBox = TRUE,
                          title = "Veuillez selectionner",
                          selectAllText = '<span style="font-size: 0.8em;">Tous</span>',
                          deselectAllText = '<span style="font-size: 0.8em;">Reset</span>'
                        ),
                        selected = choices,
                        inline = F)
          )
        
      })
      output$countryselect <- renderUI({
        paste("Pays sélectionner: ",  filterStates$countrySelected, sep = "")
      })
      
      ########## End
    }
  })

}