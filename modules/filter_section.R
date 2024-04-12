filterStatesRouter_ui <- function(id) {
  
  ns <- NS(id)
  fluentPage(
    div(id = "filterBox",
        uiOutput(ns("country")),
        uiOutput(ns("dateRange")),
        uiOutput(ns("timeAggregation")),
        ################### This button apply a filter
        uiOutput(ns("filter_button")),
        ############ This button is for generate and Download report in .docx format
        uiOutput(ns("generate"))
    )
  )
  
}

filterStatesRouter_server <- function(input, output, session, page) {
  
  observeEvent(page, {
    if(page == "Home"){ ########## We don't need to display filter when we are at home page.
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
          dateRangeInput(session$ns("dateRangeInput"), label = "",
                         start = as.Date("2019-10-20"), end = as.Date("2019-10-20"),
                         min = "2010-10-20", max = "2024-10-30"),
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
          selectInput(session$ns("timeAggregationInput"), label = NULL,
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
          selectInput(session$ns("countryInput"), label = NULL,
                      choices = choices, selected = selection)
        )
      })
      
      output$filter_button <- renderUI({
        DefaultButton.shinyInput(session$ns("filter_data"), class = "btn-filter",
                                 text = "Appliquer le filtre",
                                 iconProps = list(iconName = "Refresh"),
                                 style = "background-color: #DD1212; color: #fff;"
        )
      })
      
      output$generate <- renderUI({
        DefaultButton.shinyInput("generate_report",
                                 text = "Generate Report",
                                 iconProps = list(iconName = "Download"),
                                 style = "background-color: #D00000; color: #fff; display: block; margin: auto; top: 300px;"
        )
      })
      
      ########## End
    }
  })

}