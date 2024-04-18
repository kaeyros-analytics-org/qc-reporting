################ clean workspace
rm(list = ls())
cat("\f")

#Loading required libraries
library(rJava)
library(shiny)
library(shiny.fluent)
library(shinymanager)
library(reactable)
library(sf)
library(shinyWidgets)
library(stringr)
library(leaflet)
library(plotly)
library(DT)
library(shinycssloaders)
library(DBI)
library(RSQLite)
library(pool)
library(readxl)
library(shinyjs)
library(openxlsx)
library(glue)
library(rintrojs)
library(shinyjs)
library(dplyr)
#library(odbc)
library(RMySQL)

# load modules and function ####
eval(parse('./modules/filter_section.R', encoding="UTF-8"))
eval(parse('./modules/bs4_tooltip.R', encoding="UTF-8"))

################ Load loginc modules
eval(parse('./modules/global_situation.R', encoding="UTF-8"))
eval(parse('./modules/network_situation.R', encoding="UTF-8"))
eval(parse('./modules/enter_relation.R', encoding="UTF-8"))
eval(parse('./modules/cpio.R', encoding="UTF-8"))
eval(parse('./modules/reemploie_page.R', encoding="UTF-8"))
eval(parse('./modules/recouvrement_page.R', encoding="UTF-8"))
eval(parse('./modules/production_page.R', encoding="UTF-8"))

# visualization modules ###
eval(parse('./modules/mainContent.R', encoding="UTF-8"))
eval(parse('./modules/mainContent_landingPage.R', encoding="UTF-8"))

# header modules ###
eval(parse('./modules/headerFeedbackModal.R', encoding='UTF-8'))
eval(parse('./modules/headerMethodsModal.R', encoding='UTF-8'))
eval(parse('./modules/headerDataModal.R', encoding='UTF-8'))
eval(parse('./modules/headerWalkthrough.R', encoding='UTF-8'))
eval(parse('./modules/headerFormModal.R', encoding='UTF-8'))
eval(parse('./modules/headerFormModal_form.R', encoding='UTF-8'))
eval(parse('./modules/headerFormRatingControl.R', encoding='UTF-8'))
eval(parse('./modules/headerFormCheckboxCols.R', encoding='UTF-8'))
eval(parse('./modules/headerFormTextControl.R', encoding='UTF-8'))
eval(parse('./modules/headerFormBoxControl.R', encoding='UTF-8'))
eval(parse('./modules/headerFormRadioControl.R', encoding='UTF-8'))

#generate report module
eval(parse('./modules/generate_report.R', encoding='UTF-8'))

# manage SQL data
eval(parse('./modules/data_management.R', encoding='UTF-8'))

# Text template loading ####
helpText <- read_xlsx("./www/templates/help_template.xlsx")


# modalXLargeDialog ####
modalXLargeDialog <- function(..., title = NULL, footer = modalButton("Dismiss"),
                              easyClose = FALSE, fade = TRUE) {
  
  cls <- if (fade) "modal fade" else "modal"
  div(id = "shiny-modal", class = cls, tabindex = "-1",
      `data-backdrop` = if (!easyClose) "static",
      `data-keyboard` = if (!easyClose) "false",
      
      div(
        class = "modal-dialog modal-xl",
        div(class = "modal-content",
            if (!is.null(title)) div(class = "modal-header",
                                     tags$h4(class = "modal-title", title)
            ),
            div(class = "modal-body", ...),
            if (!is.null(footer)) div(class = "modal-footer", footer)
        )
      ),
      tags$script("$('#shiny-modal').modal().focus();")
  )
}

#import data
wd <- getwd()
path <- paste0(wd,"/data")
