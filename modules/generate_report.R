generate_report <- function(tab1,tab2,text1){
  set_flextable_defaults(
    font.size = 8, font.family = 'Trebuchet MS',
    font.color = "#333333",
    table.layout = "fixed",
    border.color = "gray",
    theme_fun = "theme_box",
    padding.top = 3, padding.bottom = 3,
    padding.left = 4, padding.right = 4)
  
  doc <- read_docx(path="./data/Rapport_hebdo.docx")
  options('ReporteRs-fontsize'=11, 'ReporteRs-default-font'='Trebuchet MS')
  doc <- body_add_par(doc,"La situation hebdomadaire du réseau First Bank à travers les agrégats repris comme suit : ")
  doc <- body_add_par(doc,"   ✓  Les ressources")
  doc <- body_add_par(doc,"   ✓  Les réemplois ")
  doc <- body_add_par(doc,"   ✓  Le recouvrement ")
  doc <- body_add_par(doc,"   ✓  La production")
  doc <- body_add_par(doc, " ")
  doc <- body_add_par(doc, "I.  LES RESSOURCES") 
  doc <- body_add_par(doc, "  A- Situaton Globale")
  doc <- body_add_par(doc, text1)
  doc <- body_add_flextable(doc,flextable(tab1))
  doc <- body_add_par(doc, " ")
  doc <- body_add_par(doc, "                                                                 Retail banking                            Corporate banking") 
  doc <- body_add_flextable(doc,flextable(tab2))
  return(doc)
  
}