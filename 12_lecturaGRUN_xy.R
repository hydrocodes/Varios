### Extraccion de la escorrentia mensual del producto GRUN (Ghiggi et al, 2019)
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
library(raster)
library(ncdf4)
library(sp)
setwd("/.../")  
#Visualizando el alcance de GRUN sobre la cuenca
p <- raster::brick("GRUN_v1_GSWP3_WGS84_05_1902_2014.nc")
w <- shapefile('piura_up.shp')
r <- shapefile('rio.shp')
raster_q <- crop(p, w, snap="out")
plot(raster_q[[1]])
plot(w, add=T)
plot(r, col="blue", add=T)
str(raster_q)
#Lectura de archivo csv conteniendo la(s) coordenadas(s) seleccionada(s)
long_lat <- read.csv("12_long_lat.csv", header = T)
sp::coordinates(long_lat) <- ~XX+YY
raster::projection(long_lat) <- raster::projection(raster_q)
points_long_lat <- raster::extract(raster_q[[1]], long_lat, cellnumbers = T)[,1]
data_long_lat <- t(raster_q[points_long_lat])*30.5
colnames(data_long_lat) <- as.character(long_lat$NN)
#Ploteando la serie de escorrentia mensual para una sola coordenada de ingreso
#Para un grupo de coordenadas, ir directamente al archivo csv generado en la linea 28
plot(data_long_lat, type="l",xlab="1902-2014", ylab="R (mm/mes)", main="Escorrentía media mensual")
write.csv(data_long_lat, "12_R_GRUN.csv", quote = F)
