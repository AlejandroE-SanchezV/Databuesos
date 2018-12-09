#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(skin = "green",

  # HEADER
  dashboardHeader(title = "Datatón Anticorrupción"),
  
  # SIDEBAR
  dashboardSidebar(sidebarMenu(
    menuItem("Introducción", tabName = "tabIntroduccion"),
    #menuItem("Tiempo Real", tabName = "tabTiempoReal"), 
    #menuItem("Noticias", tabName = "tabNoticias"), 
    menuItem("Alerta General", tabName = "tabAlerta_3"),
    menuItem("Alerta 1", tabName = "tabAlerta_1"), 
    menuItem("Alerta 2", tabName = "tabAlerta_2") 
  )),
  
  # BODY
  dashboardBody(
  #####################################
  # Estilo y colores del contenido!!! #
  ####################################
  tags$head(tags$style(
    HTML("@import url('https://fonts.googleapis.com/css?family=Karla|Source+Serif+Pro|Ultra');
         .content-wrapper {
         background-color: white !important;}
         label, input, button, select { 
         font-family: 'Karla', sans-serif;
         font-color = #606060;
         font-size: 14pt;
         }
        
        h1 {
         font-family:'Ultra', serif;
         font-weight: 800;
         line-height: 1.1;
         color: 	#000000;
         font-size: 28pt;
         #text-align:left;
         #padding-right:190px;
         #padding-left:70px;
         }
         
      h2 {
         font-family:'Ultra', serif;
         font-weight: 500;
         line-height: 1.1;
         color: 	#000000;
         font-size: 22pt;
         text-align:center;
         padding-right:190px;
         padding-left:70px;
      }

 body {
         background-color: white;
         style= width: 80%;
         }
         p {
         text-indent: 0px;
         font-family: 'Karla', sans-serif;
         font-size: 12pt;
         color: #606060;
         text-align:justify;
         padding-top: 5px;
         padding-botton: 10px;
         padding-right:190px;
         padding-left:70px;
         
         }
         .main-header .logo {
         font-family: 'Ultra', serif;
         font-size: 15px;
         background-color:white;
         padding-top:0px; 
         padding-bottom:0px;
         }
         
         .main-sidebar {
         background-color: black !important;
         }
      
         .container {
         position: relative;
         width: 50%;
         }

         .image {
         opacity: 1;
         display: block;
         width: 100%;
         height: auto;
         transition: .5s ease;
         backface-visibility: hidden;
         }
         
         .middle {
         transition: .5s ease;
         opacity: 0;
         position: absolute;
         top: 50%;
         left: 50%;
         transform: translate(-50%, -50%);
         -ms-transform: translate(-50%, -50%)
         }
         
         .container:hover .image {
         opacity: 0.3;
         }
         
         .container:hover .middle {
         opacity: 1;
         }

         .text {
         background-color: black;
         color: white;
         font-size: 14px;
         padding: 16px 32px;
         }
        
        .box.box-solid.box-primary>.box-header {
        color:#606060;
        background:white;
        background-color:#f0f0f5;
        font-family: 'Karla', sans-serif;
        text-align:center;
        }
        
        .box.box-solid.box-warning>.box-header {
        color:#606060;
        background:white;
        background-color:#f0f0f5;
        font-family: 'Karla', sans-serif;
        text-align:center;
        }
        
        .box.box-solid.box-primary {
        color:#606060;
        background-color:white;
        border-color:white !important;
        }
         
         .box.box-solid.box-warning {
         color:#606060;
         background-color:white;
         border-color:white;
         }
      
         li span {
         font-family: 'Karla', sans-serif;
         font-size: 15px;
         font-color:#606060;
         
         }


         li {
         font-family: 'Karla', sans-serif;                    
         font-size: 16px;
         margin-top: 15px;
         padding-top: 20px;
         padding-botton: 20px;
         border:1px;
         line-height: 1.7;
         font-color:#606060;
         ul {
         list-style-type: none;
         }
         

       "))
    ), 
  
  tabItems(
  
    tabItem("tabAlerta_3", 
            h1("Sistema general de alerta"), 
            tags$li("En el nivel más alto de alerta se encuentran las dependencias no cumplen con la dimensión 1. Incluye variables que favorecen la discrecionalidad en los concursos, tales como: "),
            p("-Descripción del concurso demasiado breve que no permita a los proveedores la búsqueda de concursos en la plataforma"),
            p("-Inexistencia de archivos adjuntos en el concurso que no permiten al proveedor consultar las bases de la convocatoria"),
            p("-Incumplimiento del plazo legal de concursos: 15 días naturales para licitaciones de carácter nacional, 20 días para licitaciones de carácter internacional"),
            tags$li("En los niveles más bajos de alerta se encuentran las dependencias con incumplimientos en la dimensión 2.
            Incluye variables que dan cuenta de la impunidad mediante un análisis de componentes principales de las siguientes variables:"),  
            p("-El Índice de Riego de Corrupción del IMCO, "),
            p("-Unidades compradoras con contratos con proveedores sancionados, "),
            p("-Unidades compradoras con  funcionarios sancionados "),
            p("-Seguimiento hemerográfico de casos de corrupción de las dependencias."),
            br(),
            
            DT::dataTableOutput("Tabla_3")
               ),
            
    tabItem("tabAlerta_1", 
            h1("Sistema de Alerta 1"), 
            #p("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"),
            br(), br(), 
            fluidPage(
              # fluidRow(
              #   box(
              #     title = "Controles Base", width = 12, status = "success", solidHeader = T,
              #     selectInput("selOrdenGobierno", "Seleccione Orden de Gobierno", choices = orden_gob), 
              #     selectInput("selSiglas", "Seleccione Siglas Institucionales", choices = siglas_inst),
              #     selectInput("selNivelAlerta", "Seleccione nivel de alerta", choices = nivel_alerta) 
              #   )
              # ), 
              fluidRow(
                box(
                  title = "Sistema de Alerta 1", width = 12, status = "success", solidHeader = T,
                  DT::dataTableOutput("Tabla_1")
                )
              )
          )
        ), # Fin "tabAlerta_1"
    
    tabItem("tabAlerta_2",
            h1("Sistema de Alerta 2"),
            #p("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"),
                      # fluidRow(
                      # ###############  #
                      #   tabBox(
                      #     side = "right", height = "250px",
                      #     selected = "Tab3",
                      #     tabPanel("Primer Cuartil", "Tab content 1"),
                      #     tabPanel("Segundo Cuartil", "Tab content 2"),
                      #     tabPanel("Tercer Cuartil", "Note that when side=right, the tab order is reversed."), 
                      #     tabPanel("Cuarto Cuartil", "Lalalalalala")
                      #   )
                      # #############
                      # 
                      # ), 
        fluidRow(
            box(
              title = "Links", width = 12, status = "success", solidHeader = T,
              DT::dataTableOutput("Tabla_2")
            )
          )  
            
      ),  
    
# _____________ #  
    
       tabItem("tabIntroduccion",
          h1("INDICE DE ALERTA DE CONCURSOS (IAC)"),     
          h6("8 de dic. de 18. CDMX"),
          br(),
          h2("Motivaciones"), 
          tags$li("La discrecionalidad"),
          p("Existe un desaseo en la descripción del expediente. Es imprecisa, confusa y muchas de ellas tienen una descripción de menos de dos palabras.   
          "),
          p("Además, hay un continuo incumplimiento del plazo de la duración de la convocatoria."), 
          p("Peor aún, diversos contratos no tienen archivos adjuntos que describa el producto y el proceso de contratación."),
          br(),
          tags$li("La impunidad"), 
          p("El índice de riesgo de corrupción del IMCO ya identificó  donde se encuentran las prácticas adversas a la eficiencia del gasto de las dependencias y unidades compradoras."),
          p("Las bases de datos de la Función Púbica ya enlistan a decenas de funcionarios y proveedores sancionados."),
          p("Además, cada día se publican actos de corrupción de distintas dependencias en la prensa."),
          br(),
          h2("Índice de alertas de concursos (IAC)"),
          p("Qué es el IAC. Es una medida resumen que da cuenta del riesgo de irregularidades en los concursos que se publican en Compranet."),
          p("Qué mide el IAC. Mide el riesgo de la discrecionalidad y la impunidad de las dependencias a través de una escala de alertas."),
          p("Cómo se compone el IAC. El IAC se compone de dos principales dimensiones:"),
          p("- La primera dimensión incluye variables que favorecen la discrecionalidad en los concursos, tales como: descripción del contrato, los archivos adjuntos y la duración de la convocatoria."),
          p("- La segunda dimensión incluye variables que dan cuenta de la impunidad, tales como: el Índice de Riego de Corrupción del IMCO, las sanciones a proveedores y funcionarios y el seguimiento hemerográfico a las dependencias."),
          br(),
          h2("Cómo se construye."), 
          tags$li("El IAC se construyó en tres fases:"),
          p("1. En la primera fase se construyó un algoritmo de monitoreo de noticias de hechos de corrupción de las dependencias. Posteriormente, Se construyó un algoritmo para descargar una base de datos de las convocatorias vigentes en Compranet."),
          p("2. En la segunda fase se limpiaron las bases, se resumieron algunas variables mediante el Método de Componentes Principales y se pegaron las distintas bases por id dependencias."),
          p("3. Finalmente, se estratifican las dependencias de Compranet en un ranking de cinco alertas."), 
          br(), br(),
          h2("Fuentes de Información"), 
          p("- Licitaciones vigentes en Compranet: https://compranet.funcionpublica.gob.mx/esop/guest/go/public/opportunity/current?locale=es_MX"),
          p("- Índice de riesgos de Contrataciones Públicas del IMCO:  https://imco.org.mx/articulo_es/indice-riesgos-corrupcion-sistema-mexicano-contrataciones-publicas/"),
          p("- Servidores públicos sancionados: https://github.com/datatonanticorrupcion/08_servidores_publicos_sancionados"),
          p("- Proveedores y contratistas sancionados: https://github.com/datatonanticorrupcion/04_proveedores_contratistas_sancionados"), 
          p("- Noticias de periódicos: Las obtuvimos de los sitios web de noticias de distintos periódicos.")
              
        ) # Fin del tabIntroduccion
       )
    )
  )
) # fin del ShinyUI


