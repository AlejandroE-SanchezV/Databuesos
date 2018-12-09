
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      # Link a google fonts
      url <- a("Google Fonts", href="https://fonts.google.com")
      
      # Link 1
      output$tab <- renderUI({
        tagList("Catálogo de fuentes: ", url)
      })
      
      # Primer grafico
      output$plot1 <- renderPlotly({
      p1 <- a %>%
          ggplot(aes(x= tipo_expediente, y = freq, 
                     text = paste0("<b>Tipo de expediente: </b>", tipo_expediente, "<br>", 
                                   "<b>Ocurrencia: </b>", freq))) + 
          geom_histogram(stat = 'identity',
                         col="red", 
                         fill="green", 
                         alpha = .2)  + 
          theme(axis.text.x = element_text(angle = 90, hjust = 1)) + labs(title="") +
          labs(x="", y="")  +
          theme(axis.title.x=element_blank(),
                axis.text.x=element_blank(),
                axis.ticks.x=element_blank())
        ggplotly(p1, tooltip = "text") 
      })
      
      output$plot1_1 <- renderPlot({
        abd %>% 
          ggplot(aes(quinced, num, fill=tipo_de_procedimiento, label=num))+
          geom_col(position = "dodge")+
          scale_x_discrete(labels = c("mas de 15 dias","menos de 15 dias"))+
          geom_text(position = position_dodge(0.9),vjust = 0)+
          labs(title ="Duración de convocatorias en Compranet en 2012", x=" Duración de conovocatorias \n( desde publicación a apertura de proposiciones)", y="")+
          scale_fill_manual(name="Tipo de procedimiento",
                            values=c("#e41a1c","#377eb8","#4daf4a","#984ea3","#ff7f00"),labels = c("ADJUDICACION DIRECTA","INVITACION A C/ TRES","LICITACION PUBLICA","LICITACION PUBLICA OSD", "NA")
          )+
          theme(legend.position=c(0.7,0.8),legend.title=element_text(size=9),legend.text=element_text(size=7))+facet_wrap(~ orden_de_gobierno, ncol=3) 
      })
      
      output$Tabla_1 <- DT::renderDataTable({
        
        data <- bd_alertas
   
        # 
        # if(input$selOrdenGobierno == "Todos los Ordenes de Gobierno" & 
        #    input$selSiglas == "Todas las siglas" & 
        #    input$selNivelAlerta == "Todos los niveles"
        # ) {
        #   data <- bd_alertas
        # } 
        # 
        # data <- bd_alertas %>%
        #   case_when()
        # 
        
        DT::datatable(data = bd_alertas,  
                      options = list(pageLenth = 5, 
                                     language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
                                     autoWidth = TRUE))
      })
      
      output$Tabla_2 <- DT::renderDataTable({
        DT::datatable(data = bd_2, 
                      options = list(pageLenth = 5, 
                                     language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
                                     autoWidth = TRUE), 
                      escape = T)
      })
      
      output$Tabla_3 <- DT::renderDataTable({
        DT::datatable(data = bd_general, 
                      options = list(pageLenth = 5, 
                                     language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
                                     autoWidth = TRUE), 
                      escape = T) %>%
          formatStyle(
            'Alerta',
            color = styleEqual(levels = c(1,2,3,4,5), values = c('red', 'black', 'black', 'black', 'black'))
          )

      })
  })
  