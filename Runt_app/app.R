## app.R ##
library(shinydashboard)
library(shinydashboardPlus)
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
            #menuItem("Video", tabName = "dashboard3", icon = icon("trash-alt")),
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
                    )
                
            ),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    fluidRow(
                        shiny::HTML("<br><br><center> 
                                     <h1>Video Explicativo</h1> 
                                     </center>")),
                    tags$div( align = "center",
                              icon("tv", class = "fa-4x")
                    ),
                    
                    div(
                        style = 
                            "height: 315px; background-color: white; width: 100%; position: relative; right:0;",
                        tags$iframe(width="560", height="315", src="https://www.youtube.com/embed/rLNm1adTyog", 
                                    frameborder="0", allow="accelerometer; autoplay; encrypted-media; gyroscope; 
                                               picture-in-picture", allowfullscreen=NA)
                    ),
                    style="text-align:center",
                    
                    fluidRow(
                        column(3),
                        
                        # Andre
                        column(3, h3("Reporte Técnico"),
                    tags$a(icon("file-invoice", class = "fa-4x"),
                           href="https://rpubs.com/kaamayam/Accidentalidadtae")),
                    
                    
                    column(3,h3("Repositorio"),
                    tags$a(icon("github-square", class = "fa-4x"),
                           href="https://github.com/kaamayam/Tae-AccidentalidadMed")),
                    column(3)
                    )
            ),
            
            # 3 tab content
            #tabItem(tabName = "dashboard3",
            #        h2("Widgets tab content 3")
            #),
            
            # 4 tab content
            tabItem(tabName = "widgets4",
            #Titulo
            shiny::HTML("<br><br><center> 
                         <h1>Sobre nosotros</h1> 
                        </center>"),
                        tags$div( align = "center",
                         icon("users", class = "fa-4x")
                         ),

                    fluidRow(
                        column(2),
                        column(8,
                               # Panel for Background on Data
                               div(class="panel panel-default",
                                   div(class="panel-body",  
                                       
                                       img(src='stat.jpg',height="40%", width="40%", align = "left"),
                                       tags$p(h6("Somos un grupo de estudiantes de la Universidad 
                                                 Nacional de Colombia sede Medellín cuyo objetivo es la
                                                 resolución de problemas mediante análisis estadístico,
                                                 implementando técnicas de programación y machine learning.
                                                 Así mismo implememtmos desarrollo de sus respectivas
                                                 aplicaciones iteractivas")),
                                       )
                               ) # Closes div panel
                        ), # Closes column
                        column(2)
                    ),
                    
                    # TEAM BIO
                    
                    fluidRow(
                        
                        style = "height:50px;"),
                    
                    fluidRow(
                        column(2),
                        
                        # Andre
                        column(2,
                               div(class="panel panel-default", 
                                   div(class="panel-body",  width = "600px",
                                       align = "center",
                                       div(
                                           tags$img(src = "team.jpg", 
                                                    width = "50px", height = "50px")
                                       ),
                                       div(
                                           tags$h5("Andrea"),
                                           tags$h6( tags$i("Estadística"))
                                       )
                                   )
                               )
                        ),
                        # Sebas
                        column(2,
                               div(class="panel panel-default",
                                   div(class="panel-body",  width = "600px", 
                                       align = "center",
                                       div(
                                               tags$img(src = "team.jpg", 
                                                    width = "50px", height = "50px")
                                       ),
                                       div(
                                           tags$h5("Sebastián"),
                                           tags$h6( tags$i("Estadístico"))
                                       )
                                   )
                               )
                        ),
                        # Pili
                        column(2,
                               div(class="panel panel-default",
                                   div(class="panel-body",  width = "600px", 
                                       align = "center",
                                       div(
                                           tags$img(src = "team.jpg", 
                                                    width = "50px", height = "50px")),
                                       div(
                                           tags$h5("Pilar"),
                                           tags$h6( tags$i("Estadística"))
                                       )
                                   )
                               )
                        ),
                        # Isa
                        column(2,
                               div(class="panel panel-default",
                                   div(class="panel-body",  width = "600px", 
                                       align = "center",
                                       div(
                                           tags$img(src = "team.jpg", 
                                                    width = "50px", height = "50px")),
                                       div(
                                           tags$h5("Isabel"),
                                           tags$h6( tags$i("Estadística"))
                                       )
                                       
                                   )
                               )
                        ),
                        column(2)
                        
                    ),
                    fluidRow(style = "height:150px;")
                    
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