# global

library(shinydashboard)
library(tidyverse)
library(plotly)
library(DT)

# Leemos bases de datos
vig <- read_csv("www/vigentes.csv")
bd<-read_csv("www/b_fechas_2019.csv")
bd_2 <- read_csv("www/riesgo_por_dependencia.csv")%>%
  transmute(SIGLAS, alerta2, Riesgo_tipo_contratacion, serv_sanc, prov_sanc, noticias, pca) %>%
  arrange(alerta2)
names(bd_2) <- c("Dependencia", "Alerta", "Riesgo Contratación IMCO", 
                 "Servidores Sancionados", "Proveedores Sancionados", "Noticias", "PCA")

bd_general <- read.csv("www/bd_alerta_general.csv") %>%
  transmute(nombre_unidad_compradora, alerta_g, codigo_expediente, link) %>%
  arrange(alerta_g)
names(bd_general) <- c("Nombre de la Unidad Compradora", "Alerta", "Codigo de Expediente", "Link")


bd_alertas <- read_csv("www/bd_alertas.csv") %>%
  transmute(nombre_unidad_compradora, alerta, orden_de_gobierno, siglas_de_la_institucion, 
            sin_adjuntos, Descripción, Cumplimiento_plazo) %>%
  arrange(desc(alerta))
names(bd_alertas) <- c("Nombre Unidad Compradora", "Alerta", "Orden de Gobierno", "Siglas de la Institución", "Archivos Adjuntos", 
                       "Descripción", "Cumplimiento del Plazo Legal")



# Selectores
orden_gob <- c("Todos los Ordenes de Gobierno", levels(as.factor(bd_alertas$orden_de_gobierno)))
siglas_inst <- c("Todas las siglas", levels(as.factor(bd_alertas$siglas_de_la_institucion)))
nivel_alerta <- c("Todos los niveles",levels(as.factor(bd_alertas$alerta)))  

a <- vig %>%
  group_by(tipo_expediente) %>%
  summarise(freq = n())

# Base grafica 1.1 
abd <- bd %>% 
  filter(!is.na(quinced) & !is.na(tipo_de_procedimiento)) %>%
  mutate(quinced=as.character(quinced)) %>%
  group_by(orden_de_gobierno,tipo_de_procedimiento,quinced) %>% 
  summarise(num = n()) %>% 
  ungroup() 

## SELECTORES ##
# exploratorio (BORRAR)
  # Niveles de variables de interes
  localidad       <- levels(as.factor(vig$caracter_procedimiento))
  clas_bienes     <- levels(as.factor(vig$categorias_expediente))
  entidad         <- levels(as.factor(vig$entidad_federativa))
  tipo_bien_adq   <- levels(as.factor(vig$tipo_contratacion))
  tipo_expediente <- levels(as.factor(vig$tipo_expediente))

