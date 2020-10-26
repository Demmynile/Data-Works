library(shiny)
library(shinydashboard)
library(modules)
library(DT)
library(dbplyr)
library(reticulate)
library(ggplot2)
library(plotly)
library(RMySQL)
library(pool)
library(modules)
library(dplyr)
library(DT)
library(plotly)
library(ggplot2)
library(tidyr)

library(shinyWidgets)




#linking up the source of the sub script to the main app
source("source/dashboard.R",local = TRUE)

#creating the Ui  for dashboardheader 
header <- dashboardHeader(title = "EPMIS DASHBOARD",titleWidth =  "100%" )

#creating the Ui for dashboardsidebar

sidebar <- dashboardSidebar(
    sidebarMenu(
    menuItem("Dashboard", icon = icon("dashboard"), tabName = "dashboard"),
    menuItem("Prediction" , icon = icon("bar-chart") , tabName = "Prediction")
    )
    )
#creating the Ui for dashboardPage
ui <-   dashboardPage(header , sidebar , body , skin = "red")







# Run the application 
shinyApp(ui = ui, server = server)

