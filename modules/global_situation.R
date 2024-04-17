######## UI for situation global
global_situation_ui <- function(id){
  ns <- NS(id)
  fluentPage(
    tags$style("
               .fieldGroup-82{border: none;}
               "),
    div(class="container-fluid",
        div(class="row p-0 m-0", 
            div(class="col-lg-6 pr-1 pl-0", br(), reactableOutput(ns("table")),
                # TextField.shinyInput(
                #   ns("textInput"),
                #   label = "Ecrivez votre remarque",
                #   style = "border: 1px solid blue; border-radius: 10px;"
                # ),
                textAreaInput("text",label="",placeholder = "Write your comments here")
                #actionButton(ns("ok"), "save comments")
                ),
            div(class="col-lg-6 pl-1 pr-0", id = "linechart", plotlyOutput(ns("plot"), width = "100px", height = "500px"))
        ),
        div(style="display: flex; font-weight: bold;",
            div(style="margin-left:300px",
                HTML("Retail banking")),
            div(style="margin-left:500px",
                HTML("Corporate banking"))
            ),
        tags$br(),
        reactableOutput(ns("table2"))
    )
  )
  
}

wd <- getwd()
path <- paste0(wd,"/data")
fichier <- "./data/tab1.xlsx"
table <- readxl::read_excel(fichier)
#table <- as.data.frame(table)
table2 <- readxl::read_excel(paste(path,"/tab2.xlsx",sep=""))#, col_names = FALSE
table2 <- table2 %>% dplyr::rename(`18/01/2024`=`18/01/2024 ...2`) %>%
  dplyr::rename(`25/01/2024`=`25/01/2024 ...3`) %>%
  dplyr::rename(`Variation`=`Variation ...4`) %>%
  dplyr::rename(`18/01/2024 `=`18/01/2024 ...6`) %>%
  dplyr::rename(`25/01/2024 `=`25/01/2024 ...7`) %>%
  dplyr::rename(`Variation `=`Variation ...8`)
#table2 <- as.data.frame(table2)
#colnames(table2) <- as.character(table2[1, ])

########### Server for situation global
global_situation_server <- function(input, output, session){
  
  output$table <- renderReactable({
    reactable(table, resizable = TRUE, selection = "single", searchable = TRUE,
              onClick = "select", pagination = TRUE, defaultPageSize = 11,
              #searchable = TRUE,
              wrap = FALSE,
              striped = FALSE,
              highlight = FALSE,
              bordered = TRUE,
              defaultColDef = colDef(
                header = function(value) gsub(".", " ", value, fixed = TRUE),
                align = "left",
                headerStyle = list(background = "#f0f5f9")
              ),
              theme = reactableTheme(
                stripedColor = "#f6f8fa",
                highlightColor = "#5547AC",
                cellPadding = "8px 12px",
                style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI,
          Helvetica, Arial, sans-serif"),
                searchInputStyle = list(width = "100%"),
                headerStyle = list(
                  "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
                  "&[aria-sort='ascending'], &[aria-sort='descending']"
                  = list(background = "hsl(0, 0%, 96%)"),
                  borderColor = "grey"
                ),
                rowSelectedStyle = list(backgroundColor = "#E80707",
                                        boxShadow = "inset 2px 0 0 0 #ffa62d")
                
              )
              
    ) # End Reactable
  })
  
  
  # Add a regression line
  # plot_ly(x = x, y = y, type = 'scatter', mode = 'markers') %>%
  #   add_trace(
  #     x = x,
  #     y = lm(y ~ x)$fitted.values,
  #     mode = 'lines',
  #     line = list(color = 'blue'),
  #     name = 'Regression Line'
  #   )
  
  output$plot <- renderPlotly({
    stock <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/finance-charts-apple.csv')
    
    fig <- plot_ly(stock, type = 'scatter', mode = 'lines', line = list(color = "#E80707"))%>%
      add_trace(x = ~Date, y = ~AAPL.High, marker = list(color = "#A31818"))%>%
      layout(showlegend = T)
    fig <- fig %>%
      layout(
        xaxis = list(zerolinecolor = '#0083E3',
                     zerolinewidth = 1,
                     gridcolor = '#D9D9D9'),
        yaxis = list(zerolinecolor = '#0083E3',
                     zerolinewidth = 1,
                     gridcolor = '#D9D9D9'),
        plot_bgcolor='#fff', width = 650)
    
    
    fig
  })
  
  output$table2 <- renderReactable({
    reactable(table2, resizable = TRUE, selection = "single", #searchable = TRUE,
              onClick = "select", pagination = TRUE, defaultPageSize = 11,
              #searchable = TRUE,
              wrap = FALSE,
              striped = FALSE,
              highlight = FALSE,
              bordered = TRUE,
              defaultColDef = colDef(
                header = function(value) gsub(".", " ", value, fixed = TRUE),
                align = "left",
                headerStyle = list(background = "#f0f5f9")
              ),
              theme = reactableTheme(
                stripedColor = "#f6f8fa",
                highlightColor = "#5547AC",
                cellPadding = "8px 12px",
                style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI,
          Helvetica, Arial, sans-serif"),
                searchInputStyle = list(width = "100%"),
                headerStyle = list(
                  "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
                  "&[aria-sort='ascending'], &[aria-sort='descending']"
                  = list(background = "hsl(0, 0%, 96%)"),
                  borderColor = "grey"
                ),
                rowSelectedStyle = list(backgroundColor = "#E80707",
                                        boxShadow = "inset 2px 0 0 0 #ffa62d")
                
              )
              
    ) # End Reactable
  })
  
  
  output$plot <- renderPlotly({
    stock <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/finance-charts-apple.csv')
    
    fig <- plot_ly(stock, type = 'scatter', mode = 'lines', line = list(color = "#E80707"))%>%
      add_trace(x = ~Date, y = ~AAPL.High, marker = list(color = "#A31818"))%>%
      layout(showlegend = F)
    fig <- fig %>%
      layout(
        xaxis = list(zerolinecolor = '#ffff',
                     zerolinewidth = 2,
                     gridcolor = 'ffff'),
        yaxis = list(zerolinecolor = '#ffff',
                     zerolinewidth = 2,
                     gridcolor = 'ffff'),
        plot_bgcolor='#e5ecf6', width = 650)
    
    
    fig
  })
}