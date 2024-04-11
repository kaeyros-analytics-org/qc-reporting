ui <- htmlTemplate("www/index.html",
  
  ############## Content of sideBar navigation
  sidebarNavigation = 
    tagList(
       useShinyjs(),
       filterStatesRouter_ui("filterStates")
    ),

  ################## Content of Header Navigation
  headerNav = htmlTemplate("./www/htmlComponents/headerNav.html",
                           slider = sliderInput("x", "Slider", 1, 100, 50)
  ),
  
  ################# Content of Body display
  contentSection = mainContentRouter_ui(id = "mainContentRouter")
) 


