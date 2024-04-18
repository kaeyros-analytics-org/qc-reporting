################# this file is dedicated to manage SQL database data.

############## import SQL DATA  Pour se deconnecter dbDisconnect(con)
con <- DBI::dbConnect(RMySQL::MySQL(), host = "localhost", dbname="afriland", user = "root", password = "",  bigint = "integer")

############ Liste de toutes les tables présente
tables <-  dbListTables(con)
#tables <-  as.data.frame(tables)

########### Extraction des comptes courants
for (table_name in tables) {
  name <- table_name
  assign(name, dbReadTable(con, table_name))
}

