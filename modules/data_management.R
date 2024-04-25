################# this file is dedicated to manage SQL database data.

############## import SQL DATA
#con <- DBI::dbConnect(RMySQL::MySQL(), host = "localhost", dbname="afriland", user = "root", password = "",  bigint = "integer")

con <- DBI::dbConnect(RSQLite::SQLite(), "./data/afriland_fake_data.sqlite")

############ Liste de toutes les tables présente
tables <-  dbListTables(con)

compte_courant<-DBI::dbGetQuery(con, paste("select * from ","compte_courant" , sep = ""))
compte_courant <- compte_courant %>% dplyr::filter(date>="2024-01-18" & date <= "2024-01-25")
compte_courant$Amount <- compte_courant$retail_banking + compte_courant$corporate_banking
########### J'actualise les données toutes les 3 secondes
autoInvalidate <- reactiveTimer(3000)

########### Extraction des comptes courants 
# Créer des réactifs pour chaque table dans une liste
reactives <- lapply(tables, function(table_name) {
  shiny::eventReactive(autoInvalidate(), {
    DBI::dbGetQuery(con, paste("select * from ", table_name, sep = ""))
  })
})

# Affecter les réactifs à des noms de variable distincts
names(reactives) <- tables

############## Contain the first element of column encours_ressources of global_situation_tab_1
row_tab_1_1 <- c("Compte courant", "Compte bloquées", "Compte chèques", "Compte livrets", "Dépots de garantie",
           "Flash cash", "Autres sommes dues à la clientèle", "Valeur non imputées", 
           "Comptes à vue des correspondants", "Disposition à Payer", "Dépôts à vue")
row_tab_1_2 <- c("Bons de caisse", "Dépôts à terme", "Banque et Etabl. Fin", "Dépôts à terme ", "Total des ressources")

############## Contain the first element of column encours_ressources of global_situation_tab_2
row_tab_2_1 <- c("Compte courant", "Compte bloquées", "Compte chèques", "Compte livrets", "Dépots de garantie",
           "Flash cash", "Autres sommes dues à la clientèle", "Valeur non imputées", 
           "Comptes à vue des correspondants", "Disposition à Payer", "Dépôts à vue")
row_tab_2_2 <- c("Bons de caisse", "Dépôts à terme", "Banque et Etabl. Fin", "Dépôts à terme ", "Total des ressources")

############## contain of global_situation_tab_1 data frame
tab <- data.frame(
  `encours_ressources` = c(row_tab_1_1, row_tab_1_2),
  first_date = "",
  Objectifs_year = "",
  date_start = "",
  date_end = "",
  Variation = "",
  Réalisation = "",
  taux_de_realisation = "",
  stringsAsFactors = FALSE
)

############## contain of global_situation_tab_2 data frame
tab_2 <- data.frame(
  `encours_ressources` = c(row_tab_2_1, row_tab_2_2),
  retails_date_start = "",
  retails_date_end = "",
  Variation = "",
  stringsAsFactors = FALSE
)

tab_3 <- data.frame(
  `encours_ressources` = c(row_tab_2_1, row_tab_2_2),
  corporate_date_start = "",
  corporate_date_end = "",
  Variation = "",
  stringsAsFactors = FALSE
)

fill_cell <- function(compte,filter,name){
  values <- compte %>%
    filter(date == as.Date(filter))
  ################# i make the sum of retail and corporate banking
  amount <- values$retail_banking + values$corporate_banking
  return(amount)
}

fill_cell_retail <-function(compte,filter,name){
  values <- compte %>%
    filter(date == as.Date(filter))
  amount <- values$retail_banking
  return(amount)
}

fill_cell_corporate <- function(compte,filter,name) {
  values <- compte %>%
    filter(date == as.Date(filter))
  amount <- values$corporate_banking
  return(amount)
}

########## Call first table
source("./modules/table_modules/global_situation_tab_1.R")
########## Call second table
source("./modules/table_modules/global_situation_tab_2.R")
source("./modules/table_modules/global_situation_tab_3.R")



#Pour se deconnecter 
#dbDisconnect(con)
