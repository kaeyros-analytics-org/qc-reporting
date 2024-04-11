ui <- htmlTemplate("www/index.html",
  
  ############## Content of sideBar navigation
  sidebarNavigation = 
    tagList(
       useShinyjs(),
       DefaultButton.shinyInput("generate_report",
                                text = "Generate Report",
                                iconProps = list(iconName = "Download"),
                                style = "background-color: #065BF9; color: #fff; display: block; margin: auto; top: 580px;"
       ),
    ),

  ################## Content of Header Navigation
  headerNav = htmlTemplate("./www/htmlComponents/headerNav.html",
                           slider = sliderInput("x", "Slider", 1, 100, 50)
  ),
  
  ################# Content of Body display
  contentSection = mainContentRouter_ui(id = "mainContentRouter")
) 


