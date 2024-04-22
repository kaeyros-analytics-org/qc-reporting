################# this file is dedicated to manage SQL database data.

############## import SQL DATA
con <- DBI::dbConnect(RMySQL::MySQL(), host = "localhost", dbname="afriland", user = "root", password = "",  bigint = "integer")

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
row_2 <- c("Bons de caisse", "Dépôts à terme", "Banque et Etabl. Fin", "Dépôts à terme", "Total des ressources")

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


##################### First table of Situation globale
global_situation_tab_1 <- shiny::reactive({
  ###############" compte courant #####################
  compte_courant <- reactives$compte_courant() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_courant'
  indice_ligne <- which(tab$`encours_ressources` == 'Compte courant')
  ################# i make the sum of retail and corporate banking
  compte_courant_amount <- compte_courant$retail_banking[1] + compte_courant$corporate_banking[1]
  tab$first_date[indice_ligne] <- compte_courant_amount
  ############### compte_bloquées #########################
  compte_bloquee <- reactives$compte_bloquee() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Compte bloquées')
  ################# i make the sum of retail and corporate banking
  compte_bloquee_amount <- compte_bloquee$retail_banking[1] + compte_bloquee$corporate_banking[1]
  tab$first_date[indice_ligne2] <- compte_bloquee_amount
  ############### compte_cheques #######################
  compte_cheques <- reactives$compte_cheques() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Compte chèques')
  ################# i make the sum of retail and corporate banking
  compte_cheques_amount <- compte_cheques$retail_banking[1] + compte_cheques$corporate_banking[1]
  tab$first_date[indice_ligne2] <- compte_cheques_amount
  ############### compte_livrets #############################
  compte_livrets <- reactives$compte_livrets() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Compte livrets')
  ################# i make the sum of retail and corporate banking
  compte_livrets_amount <- compte_livrets$retail_banking[1] + compte_livrets$corporate_banking[1]
  tab$first_date[indice_ligne2] <- compte_livrets_amount
  ############### depot_garantie #############################
  depot_garantie <- reactives$depot_garantie() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Dépots de garantie')
  ################# i make the sum of retail and corporate banking
  depot_garantie_amount <- depot_garantie$retail_banking[1] + depot_garantie$corporate_banking[1]
  tab$first_date[indice_ligne2] <- depot_garantie_amount
  ############### flash_cash #############################
  flash_cash <- reactives$flash_cash() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Flash cash')
  ################# i make the sum of retail and corporate banking
  flash_cash_amount <- flash_cash$retail_banking[1] + flash_cash$corporate_banking[1]
  tab$first_date[indice_ligne2] <- flash_cash_amount
  ############### autre_somme_client #############################
  autre_somme_client <- reactives$autre_somme_client() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Autres sommes dues à la clientèle')
  ################# i make the sum of retail and corporate banking
  autre_somme_client_amount <- autre_somme_client$retail_banking[1] + autre_somme_client$corporate_banking[1]
  tab$first_date[indice_ligne2] <- autre_somme_client_amount
  ############### valeur_non_imputees #############################
  valeur_non_imputees <- reactives$valeur_non_imputees() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Valeur non imputées')
  ################# i make the sum of retail and corporate banking
  valeur_non_imputees_amount <- valeur_non_imputees$retail_banking[1] + valeur_non_imputees$corporate_banking[1]
  tab$first_date[indice_ligne2] <- valeur_non_imputees_amount
  ############### compte_a_vue #############################
  compte_a_vue <- reactives$compte_a_vue() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Comptes à vue des correspondants')
  ################# i make the sum of retail and corporate banking
  compte_a_vue_amount <- compte_a_vue$retail_banking[1] + compte_a_vue$corporate_banking[1]
  tab$first_date[indice_ligne2] <- compte_a_vue_amount
  ############### disposition_a_payer #############################
  disposition_a_payer <- reactives$disposition_a_payer() %>%
    filter(date == as.Date(filterStates$first_date))
  # Récupérer l'indice de la ligne 'compte_bloquee'
  indice_ligne2 <- which(tab$`encours_ressources` == 'Disposition à Payer')
  ################# i make the sum of retail and corporate banking
  disposition_a_payer_amount <- disposition_a_payer$retail_banking[1] + disposition_a_payer$corporate_banking[1]
  tab$first_date[indice_ligne2] <- disposition_a_payer_amount
  
  ############### Dépôts à vue ############################# Sum of all lines
  indice_lignex <- which(tab$`encours_ressources` == 'Dépôts à vue')
  ################# i make the sum of al lgine
  depot_a_vue_amount <- c (compte_courant_amount + compte_bloquee_amount + compte_cheques_amount
  + compte_livrets_amount + depot_garantie_amount + flash_cash_amount + autre_somme_client_amount
  + valeur_non_imputees_amount + compte_a_vue_amount + disposition_a_payer_amount)
  
  tab$first_date[indice_lignex] <- depot_a_vue_amount
  
  
  # bon_caisse_amount <- reactives$bon_de_caisse() %>%
  #   filter(date == as.Date(filterStates$first_date))
  # # Récupérer l'indice de la ligne 'compte_courant'
  # indice_ligne <- which(tab$`encours_ressources` == 'Compte courant')
  # ################# i make the sum of retail and corporate banking
  # compte_courant_amount <- compte_courant$retail_banking[1] + compte_courant$corporate_banking[1]
  # tab$first_date[indice_ligne] <- compte_courant_amount
  # bon_caisse_amount <- 
  
  colnames(tab)[colnames(tab) == 'first_date'] <- as.character(filterStates$first_date)
  colnames(tab)[colnames(tab) == 'date_start'] <- as.character(filterStates$date_start)
  colnames(tab)[colnames(tab) == 'date_end'] <- as.character(filterStates$date_end)
  colnames(tab)[colnames(tab) == 'Objectifs_year'] <- paste("Objectif", year(filterStates$date_start))
  
  ############### Final data frame
  tab
}) #### END


#Pour se deconnecter 
#dbDisconnect(con)
