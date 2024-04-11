################ clean workspace
rm(list = ls())
cat("\f")

#Loading required libraries
library(rJava)
library(shiny)
library(shiny.fluent)
library(reactable)
library(sf)
library(shinyWidgets)
library(stringr)
library(leaflet)
library(plotly)
library(dplyr)
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


# load modules and function ####
eval(parse('./modules/filter_section.R', encoding="UTF-8"))
eval(parse('./modules/bs4_tooltip.R', encoding="UTF-8"))

################ Load loginc modules
eval(parse('./modules/global_situation.R', encoding="UTF-8"))
eval(parse('./modules/network_situation.R', encoding="UTF-8"))
eval(parse('./modules/enter_relation.R', encoding="UTF-8"))
eval(parse('./modules/cpio.R', encoding="UTF-8"))

# visualization modules ###
eval(parse('./modules/mainContent.R', encoding="UTF-8"))
eval(parse('./modules/mainContent_landingPage.R', encoding="UTF-8"))





