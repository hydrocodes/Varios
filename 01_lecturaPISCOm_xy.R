### Extraccion de la precipitacion mensual desde un netcdf PISCO para una coordenada
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(sp)
library(rgdal)
library(Rccp) # include for R 4.x versions, also try with package "terra"
library(raster)
library(ncdf4)
setwd("...")  
cuenca.shape <- readOGR("catchment.shp")
class(cuenca.shape)
plot(cuenca.shape, axes=T,col=c("cyan"))
head(cuenca.shape@data)
#Proyeccion y reproyeccion de coordenadas
cuenca.utm <- spTransform(cuenca.shape, CRS("+proj=utm +zone=18 +ellps=WGS84 +south +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"))
plot(cuenca.utm, axes=T, asp=1)
cuenca.wgs <- spTransform(cuenca.utm, CRS("+proj=longlat +ellps=WGS84"))
plot(cuenca.wgs, axes=T, asp=1)

# Visualizando el producto raster PISCO de precipitacion mensual
r <- stack("PISCOV3-MONTHLY.nc") 
# Visualizando la Precipitacion espacial del 1er mes (Enero) de 1981.
plot(r[[1]])
# Ploteando la cuenca dentro del mapa de precipitaciones
plot(cuenca.wgs, add=T)
# Delimitando el área de estudio al cuadrante que ocupa la cuenca
raster_pp <- crop(r, cuenca.wgs, snap="out")
# Ploteando enero de 1981 en el cuadrante que ocupa la cuenca
plot(raster_pp[[1]])
plot(cuenca.wgs, add=T)

#Ingresando las coordenadas del punto a extraer desde un archivo CSV
long_lat <- read.csv("01_long_lat.csv", header = T)
sp::coordinates(long_lat) <- ~XX+YY
raster::projection(long_lat) <- raster::projection(raster_pp)
points_long_lat <- extract(raster_pp[[1]], long_lat, cellnumbers = T)[,1]
data_long_lat <- t(raster_pp[points_long_lat])
colnames(data_long_lat) <- as.character(long_lat$NN)
write.csv(data_long_lat, "yanamayo.csv", quote = F)
prec <- ts(data_long_lat[,1],start = 1981, end = 2016, frequency = 12)
plot.ts(prec, type="l", ylab="P (mm)", xlab = "Meses", main="Precipitacion promedio areal - Yanamayo")

#Para el caso de cuencas que abarcan mas de una grilla. Estimando el peso de cada grilla
weights <- extract(raster_pp[[1]], cuenca.wgs, cellnumbers=T,  weights=T, small=T) 

### Patch simple para versiones R 4.3.x con rgdal desactualizado
library(terra)
r <- rast("PISCOV3-MONTHLY.nc")
plot(r[[1]])
v <- vect("catchment.shp")
plot(v, add=T)
crop <- terra::crop(r, v)
plot(crop[[1]])
plot(v, add=T)
long_lat <- read.csv("01_long_lat.csv", header = T)
long_lat$NN <- NULL
values <- extract(crop, long_lat) 
datos <- t(values)
View(datos)
write.csv(datos, "data_long_lat.csv", quote = F)
x <- ts(datos[2:nrow(datos)], start=1981, end=2016, frequency = 12)
plot(x, type="l", ylab="P (mm/mes)", xlab="Años")
lines(lowess(time(x), x), col="blue", lwd=2)
#Para el caso de cuencas que abarcan mas de una grilla. Estimando el peso de cada grilla
weights <- extract(crop[[1]], v, cellnumbers=T,  weights=T) 
