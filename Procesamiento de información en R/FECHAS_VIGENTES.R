Sys.setlocale("LC_ALL", "es_ES.UTF-8") 
library(pacman)
p_load( lubridate, tidyverse, janitor, scales, cowplot, readr, readxl,rebus)


bd_vigentes <-read_csv("01 DATOS/licitaciones_vigentes.csv")
names(bd_vigentes)
glimpse(bd_vigentes)

bd_vigentes2<-bd_vigentes %>% 
  mutate(
    plazo_participacion=dmy_hm(plazo_participacion),
    fecha_publicacion_anuncio=dmy_hm(fecha_publicacion_anuncio),
    d_fecha_publicacion_anuncio=weekdays(fecha_publicacion_anuncio),
    d_plazo_participacion=weekdays(plazo_participacion),
    dd_pub_part=round(difftime(plazo_participacion,fecha_publicacion_anuncio, units = c("days")), 0),
    menor_15d=ifelse(dd_pub_part<15,1,0), 
    nombre_unidad_compradora1=nombre_unidad_compradora) %>%
  separate(nombre_unidad_compradora1, c("siglas_de_la_institucion", "institucion"), "-") %>% 
 mutate(orden_de_gobierno=case_when(
   siglas_de_la_institucion=="AGS"~"GE",
   siglas_de_la_institucion=="BC"~"GE",
   siglas_de_la_institucion=="BCS"~"GE",
   siglas_de_la_institucion=="CAMP"~"GE",
   siglas_de_la_institucion=="CDMX"~"GE",
   siglas_de_la_institucion=="CHIH"~"GE",
   siglas_de_la_institucion=="CHIS"~"GE",
   siglas_de_la_institucion=="COAH"~"GE",
   siglas_de_la_institucion=="COL"~"GE",
   siglas_de_la_institucion=="DGO"~"GE",
   siglas_de_la_institucion=="GRO"~"GE",
   siglas_de_la_institucion=="GTO"~"GE",
   siglas_de_la_institucion=="HGO"~"GE",
   siglas_de_la_institucion=="JAL"~"GE",
   siglas_de_la_institucion=="MEX"~"GE",
   siglas_de_la_institucion=="MICH"~"GE",
   siglas_de_la_institucion=="MOR"~"GE",
   siglas_de_la_institucion=="NAY"~"GE",
   siglas_de_la_institucion=="NL" ~"GE",
   siglas_de_la_institucion=="OAX" ~"GE",
   siglas_de_la_institucion=="PUE"~"GE",
   siglas_de_la_institucion=="QRO"~"GE",
   siglas_de_la_institucion=="QROO"~"GE",
   siglas_de_la_institucion=="SIN"~"GE",
   siglas_de_la_institucion=="SLP"~"GE",
   siglas_de_la_institucion=="SON"~"GE",
   siglas_de_la_institucion=="TAB"~"GE",
   siglas_de_la_institucion=="TAMPS"~"GE",
   siglas_de_la_institucion=="TLAX"~"GE",
   siglas_de_la_institucion=="VER"~"GE",
   siglas_de_la_institucion=="YUC"~"GE",
   siglas_de_la_institucion=="ZAC"~"GE",
   TRUE~"APF"))

bd_vigentes2 %>% 
   group_by(tipo_expediente) %>% 
   summarise(freq=n())


bd_alertas1<-bd_vigentes2 %>% 
  mutate(palabras_expediente=str_count(descripcion_expediente," "),
         Descripción=if_else(palabras_expediente<=5,1,0),
         Cumplimiento_plazo=ifelse(tipo_expediente!="Adjudicación Directa LOPSRM"|tipo_expediente!="Adjudicación Directa LAASSP", case_when( is.na(caracter_procedimiento) & dd_pub_part<15~1,
                              caracter_procedimiento== "Internacional" & dd_pub_part<20~1,
                              caracter_procedimiento== "Internacional bajo TLC" & dd_pub_part<20~1,
                              caracter_procedimiento=="Nacional"& dd_pub_part<15~1,
                              TRUE~0),0),
         alerta=if_else(Descripción==1|Cumplimiento_plazo==1|sin_adjuntos==1,1,0)) 


write.csv(bd_alertas1,file="01 Datos/bd_alertas1.csv")                                    
  
bd_alerta2<-read_csv("01 DATOS/alerta2.csv")
 
bd_alerta_general<- bd_componentes %>% 
   left_join(bd_alertas,
             by = "link")

names(bd_alerta_general)

bd_alerta_general<-bd_alerta_general %>% 
   mutate(alerta_g=case_when(alerta==1 & alerta2==2~1,
                            alerta==1 & alerta2==3~1, 
                            alerta==1 & alerta2==4~1,
                            alerta==1 & alerta2==5~1,
                            alerta==1 & is.na(alerta2)~1,
                            alerta!=1 & alerta2==2~2,
                            alerta!=1 & alerta2==3~3, 
                            alerta!=1 & alerta2==4~4,
                            alerta!=1 & alerta2==5~5,
                            alerta!=1 & alerta2==0~1
                )) 
 
write.csv(bd_alerta_general,file="01 Datos/bd_alerta_general.csv")  

                                    

