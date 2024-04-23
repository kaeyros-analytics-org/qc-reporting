
################ function to manage pivot item by id 
setClickedId <- function(inputId) {
  shiny.fluent::JS(glue::glue("item => Shiny.setInputValue('{inputId}', item.props.id)"))
}

# credentials <- data.frame(
#   user = c("user", "admin"),
#   password = c("user", "admin"),
#   # password will automatically be hashed
#   admin = c(FALSE, TRUE),
#   stringsAsFactors = FALSE
# )
# #
# key_set("R-shinymanager-key", "antid")
# #
# create_db(
#   credentials_data = credentials,
#   sqlite_path = "data/database.sqlite", # will be created
#   #passphrase = key_get("R-shinymanager-key", "antid")
#    passphrase = "passphrase_wihtout_keyring"
# )
# 
# css <- HTML(".btn-primary {
#                   color: #ebe8e8;
#                   background-color: #2B8049;
#                   border-color: #2B8049;
# }
#               .panel-auth {
#               background-color: #2B8049;
#               }
#               .panel-primary {
#                   border-color: #2B8049;
#                   width: 100%;
#                   z-index: 2;
#                   top: 0;
#                   left: 0;
#                   height: 100%;
#                   position: fixed;
#                   max-width: 750px;
#                   padding: 200px 90px;
#               }")
# set_labels(
#   language = "en",
#   "Please authenticate" = "",
#   "Language"=""
# )

mainContentRouter_ui <- function(id) {

  ns <- NS(id)

  out <- withSpinner(uiOutput(ns("mainContent")),
                     type = 8,
                     color = 'grey', size = 0.7)

  return(out)

}

# mainContentRouter_ui <- shinymanager::secure_app(mainContentRouter_ui,choose_language = FALSE, enable_admin = TRUE,
#                  # changing theme for the credentials
# 
#                  theme = shinythemes::shinytheme("united"),
#                  tags_top = tags$div(
#                    tags$head(tags$style(css)),
#                    tags$h3("Login", style = "text-align: left; font-weight: bold;"), #align:lnbeft
#                    tags$h5("Welcome back! Please log in to access your account ", style = "text-align: left;"),
# 
#                  )
# )

mainContentRouter_server <- function(input, output, session, dataset) {
  # res_auth <- shinymanager::secure_server(
  #   check_credentials = shinymanager::check_credentials(
  #     "data/database.sqlite",
  #     #passphrase = key_get("R-shinymanager-key", "antid")
  #      passphrase = "passphrase_wihtout_keyring"
  #   )
  # )
  ############# This UI is for ressources Layout Page
  ui_ressouces = Pivot(linkFormat = "tabs",
                       onLinkClick = setClickedId(session$ns("ressources_tabs")),
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
  ui_production = production_ui(session$ns("production"))
  
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










