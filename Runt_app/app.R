## app.R ##
library(shinydashboard)
library(shinythemes)
library(tidyverse)

# bases de datos
datos<-readRDS("BaseFinal.rds")
datos$Unidades<-as.integer(datos$Unidades)
holid<- readRDS(file = "national_holidays.rds")
special<- readRDS(file = "special_dates.rds")
modelo<- readRDS("Modelo.rds")
observance<- filter(special, type == "Observance")

ui <- dashboardPage(
    title="Runt App",
    skin = "purple",
    
    dashboardHeader(),
    #Sidebar
    dashboardSidebar(
        sidebarMenu(
            menuItem("Predicciones", tabName = "dashboard", icon = icon("search")),
            menuItem("Enlaces Externos", tabName = "widgets", icon = icon("exchange-alt")),
            #menuItem("Delete Tables", tabName = "dashboard3", icon = icon("trash-alt")),
            menuItem("Sobre nosotros", tabName = "widgets4", icon = icon("info-circle"))
        )
    ),
    ## Body content
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "dashboard",
                    # Create a new Row in the UI for selectInputs
                    fluidRow(
                        column(4, wellPanel(
                            dateInput('date',
                                      label = 'Fecha de entrada: año-mes-día',
                                      value = "2018-01-06"
                            ),
                            
                            # botton para graficar los mapas
                            actionButton(inputId = "api",label = "Continuar y graficar",icon=icon("brain")),
                            hr(),
                            dateRangeInput('dateRange',
                                           label = 'Fecha de entrada: año-mes-día',
                                           start = "2018-01-06", end = "2018-01-06"
                            ),
                            # botton para graficar los mapas
                            actionButton(inputId = "api2",label = "Continuar y graficar",icon=icon("brain"))
                        )),
                        
                        column(6,
                               #verbatimTextOutput("pred"),
                               verbatimTextOutput("dateRangeText")
                        )
                    ),
                
            ),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    h2("Update truckers table"),
                    # Spreadsheet name and sheet name 
            ),
            
            # 3 tab content
            #tabItem(tabName = "dashboard3",
            #        h2("Widgets tab content 3")
            #),
            
            # 4 tab content
            tabItem(tabName = "widgets4",
                    h2("About Us"),
                    fluidRow()
            )
            #-------------
            
        )
    )
)

server <- function(input, output, session) {

    output$dateText  <- renderText({
        paste("El número de registros predicho es: ", predic1)
    })
    
    output$dateRangeText  <- renderText({
        paste("Date range is", 
              paste(as.character(input$dateRange), collapse = " to ")
        )
    })
    
    # reactive event ****************** 2
    predic1 <- eventReactive(input$api,{  
        source('ND.R')
        pred <- predict(modelo, newdata = ND(input$date))
        pred
    })
    
    
}

shinyApp(ui, server)
#renv load every library
#renv::init()
#renv::snapshot() #photo
#Set Size App
#rsconnect::configureApp(appName = 'runt_app',account = 'kaamayam', size = 'xxxlarge' )