# Pruebas y an'alisis
library(sf)
library(tidyverse)
library(stringr)
library(rebus)

map <- st_read("https://github.com/JuveCampos/MexicoSinIslas/raw/master/Sin_islas.geojson")
map
plot(map)
map$n <- rownames(map)

edos<-c("AGS","BC","BCS","CAMP","COAH","COL","CHIS",
        "CHIH","CDMX","DGO","GTO","GRO","HGO","JAL","MEX",
        "MICH","MOR","NAY","NL","OAX","PUE","QRO","QROO",
        "SLP","SIN","SON","TAB","TAMPS","TLAX","VER","YUC","ZAC")

map$abreviatura <- edos

map$ENTIDAD <-  str_replace(as.character(map$ENTIDAD), pattern = "DISTRITO FEDERAL", replacement = "CIUDAD DE MEXICO")

st_write(map, "mapa_dataton.geojson")

leaflet(map)

