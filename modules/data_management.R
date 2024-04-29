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

##############  rename colnames global_situation_tab_3
tab4 <- reactive({
  data <- global_situation_tab_3()
  col_names <- c(names(data))
  nb <- length(col_names)
  for (i in 1:nb) {
    col_names[i] <- paste0(col_names[i], paste0(rep(" ", i), collapse = ""), collapse = "")
  }
  colnames(data) <- col_names
  data
})

######## Merge table global_situation_tab_2 and global_situation_tab_3
final_second_tab <- reactive({
  final <- cbind(global_situation_tab_2(),tab4())
  final_ <- flextable(
    data = final,
    col_keys = c(names(final)[1:4],"col1",names(final)[5:7])) |>
    #width(j = "col1", width = .2) |>
    empty_blanks(width = 100)
  final_ <- width(final_, j = "col1", width = 2)
  final_ <- align(final_, align = "right", part = "all")
  final_<- bg(final_, i=c(11,15),bg = "#D3D3D3")
  final_<- bg(final_, i=16,bg = "#808080")
  final_<- bg(final_, bg = "#808080", part = "header")
})

########## Call first table
source("./modules/table_modules/global_situation_tab_1.R")
########## Call second table
source("./modules/table_modules/global_situation_tab_2.R")
source("./modules/table_modules/global_situation_tab_3.R")



#Pour se deconnecter 
#dbDisconnect(con)
