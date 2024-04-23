################# this file is dedicated to manage SQL database data.

############## import SQL DATA
#con <- DBI::dbConnect(RMySQL::MySQL(), host = "localhost", dbname="afriland", user = "root", password = "",  bigint = "integer")

con <- DBI::dbConnect(RSQLite::SQLite(), "./data/afriland_fake_data.sqlite")

############ Liste de toutes les tables présente
tables <-  dbListTables(con)
#tables <-  as.data.frame(tables)

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
row_1 <- c("Compte courant", "Compte bloquées", "Compte chèques", "Compte livrets", "Dépots de garantie",
           "Flash cash", "Autres sommes dues à la clientèle", "Valeur non imputées", 
           "Comptes à vue des correspondants", "Disposition à Payer", "Dépôts à vue")
row_2 <- c("Bons de caisse", "Dépôts à terme", "Banque et Etabl. Fin", "Dépôts à terme ", "Total des ressources")

###########"" contain of global_situation_tab_1 data frame
tab <- data.frame(
  `encours_ressources` = c(row_1, row_2),
  first_date = "",
  Objectifs_year = "",
  date_start = "",
  date_end = "",
  Variation = "",
  Réalisation = "",
  taux_de_realisation = "",
  stringsAsFactors = FALSE
)
fill_cell <- function(compte,filter,name){
  values <- compte %>%
    filter(date == as.Date(filter))
  # Récupérer l'indice de la ligne 'compte_courant'
  indice_ligne <- which(tab$`encours_ressources` == name)
  ################# i make the sum of retail and corporate banking
  amount <- values$retail_banking[1] + values$corporate_banking[1]
  return(amount)
}
########## Call first table
source("./modules/table_modules/global_situation_tab_1.R")
########## Call second table
source("./modules/table_modules/global_situation_tab_2.R")


#Pour se deconnecter 
#dbDisconnect(con)
