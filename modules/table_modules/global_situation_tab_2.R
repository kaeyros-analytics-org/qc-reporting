
##################### Second table of Situation globale
global_situation_tab_2 <- shiny::reactive({

  
  colnames(tab_2)[colnames(tab_2) == 'retails_date_start'] <- as.character(filterStates$date_start)
  colnames(tab_2)[colnames(tab_2) == 'retails_date_end'] <- as.character(filterStates$date_end)
  colnames(tab_2)[colnames(tab_2) == 'corporate_date_start'] <- as.character(filterStates$date_start)
  colnames(tab_2)[colnames(tab_2) == 'corporate_date_end'] <- as.character(filterStates$date_end)
  
  ############### Final data frame
  tab_2
}) #### END


