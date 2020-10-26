#Importing the neccessary libraries
library(RMySQL)
library(pool)
library(modules)
library(dplyr)
library(DT)
library(plotly)
library(ggplot2)
library(tidyr)







#Database Connection
DatabaseCon <-  dbPool(RMySQL:: MySQL(), user='spicywords', password='Harbeedeymee_123', dbname='hrdb', host='localhost')

#checking the list of tables 
dbListTables(DatabaseCon)

#store the database table to a variable
table_v <- dbGetQuery(DatabaseCon , "SELECT * FROM  student_academic_performance")



#Creating the UI component for the Dashboard
body <- dashboardBody(
  
  #adding the tab items in the application
  tabItems(
    
    tabItem(tabName = "dashboard", class = "active",
            
            fluidRow(
              infoBox("Male", value = dbGetQuery(DatabaseCon, "SELECT count(*) FROM student_academic_performance WHERE gender = 'M' ;"), icon = icon("user"), color ="red",width = 6 ),
              infoBox("Female", value = dbGetQuery(DatabaseCon, "SELECT count(*) FROM student_academic_performance WHERE gender = 'F' ;"), icon = icon("user"), color ="red",width = 6),
              
              box(title = strong("Students Absence Rate" ), status = "danger", width = 4,
                 #plotting with Plotly
                                   plot_ly(data = table_v , x = ~StudentAbsenceDays)

                  
                  ),
              box(title = strong("Class with the Highest number of students"), status = "danger", width = 4,
                  #plotting with Plotly
                  plot_ly(data = table_v , x = ~GradeID , y = ~StageID , color = I("red") ) %>%
                            add_lines() %>% add_markers(color = ~StageID)),
              
              box(title = strong("Subjects Enrolled by students"), status = "danger", width = 4,
                  #plotting with Plotly
                  plot_ly(data = table_v , x = ~Topic) %>%
                    add_histogram(name = "Subject Enrollment")),
              
        
                  
                  
              
              box(title = strong("Tables Portraying Important information"), status = "danger", width = 12,
                DT::dataTableOutput ("DashboardTable")
                 )
                  
            )
    ),
             
    tabItem(tabName = "Prediction" , class = "active",
            fluidRow(
              box(title = strong("Student performance"), status = "danger", width = 8
                  
                  
                  
                  
                  ),    
              box(title = strong("Possible Student Enrollment"), status = "danger", width = 4
                  
                  
                  
                  
                  
                  )
            )
            )
    
  )
  )

  



server <- function(input , output , session){

output$DashboardTable = DT::renderDataTable({
  
dbGetQuery(DatabaseCon, "SELECT ParentschoolSatisfaction , StudentAbsenceDays, VisITEDResources, gender FROM student_academic_performance ;")
  
})

}
