generate_report <- function(tab1,tab2,text1){
  #text1 <- readRDS(paste(path,"/text1.rds", sep="")) 
  # fichier <- "./data/tab1.xlsx"
  # tab1 <- readxl::read_excel(fichier)
  # tab2 <- readxl::read_excel(paste0(path,"/tab2.xlsx",sep=""), col_names = FALSE)
  doc <- docx(template="Rapport hebdo.docx") 
  # Change the default font size and font family
  options('ReporteRs-fontsize'=11, 'ReporteRs-default-font'='Trebuchet MS')
  doc <- addParagraph(doc,"La situation hebdomadaire du réseau First Bank à travers les agrégats repris comme suit : ")
  doc <- addParagraph(doc,"   ✓  Les ressources")
  doc <- addParagraph(doc,"   ✓  Les réemplois ")
  doc <- addParagraph(doc,"   ✓  Le recouvrement ")
  doc <- addParagraph(doc,"   ✓  La production")
  doc <- addParagraph(doc, " ")
  doc <- addParagraph(doc, "I.  LES RESSOURCES") 
  doc <- addParagraph(doc, " ")
  doc <- addParagraph(doc, "  A- Situaton Globale")
  doc <- addParagraph(doc, " ")
  doc <- addParagraph(doc, as.character(text1))
  tab <- FlexTable(tab1,body.text.props = textProperties( font.size = 8,font.weight = "bold",font.family ="Trebuchet MS"),
                   header.cell.props = cellProperties( background.color = "#808080"),
                   header.text.props = textProperties(font.size = 8,font.family = "Trebuchet MS",font.weight = "bold")
  )
  
  ret_corp <- FlexTable(tab2,header.columns=FALSE,body.text.props = textProperties( font.size = 8,
                                    font.weight = "bold",font.family ="Trebuchet MS"))
  tab <- setColumnsColors(tab, j=1, colors = "#FFC0CB" )
  tab <- setRowsColors(tab,i=c(1,12,16), colors="#808080")
  doc <- addFlexTable(doc, tab)
  doc <- addParagraph(doc," ")
  doc <- addParagraph(doc, "                                                                 Retail banking                            Corporate banking") 
  doc <- addFlexTable(doc, ret_corp)
  return(doc)
}