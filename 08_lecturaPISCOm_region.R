### Extraccion de datos del raster PISCO de evapotranspiracion delimitado por un poligono shapefile
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(sp)
library(rgdal)
library(Rccp) # include for R 4.x versions, also try with package "terra"
library(raster)
library(ncdf4)
setwd("...") 
cuenca.shape <- readOGR(dsn="files", layer="chillon")
class(cuenca.shape)
plot(cuenca.shape, axes=T,col=c("cyan"))
head(cuenca.shape@data)

cuenca.utm <- spTransform(cuenca.shape, CRS("+proj=utm +zone=18 +ellps=WGS84 +south +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"))
plot(cuenca.utm, axes=T, asp=1)
cuenca.wgs <- spTransform(cuenca.utm, CRS("+proj=longlat +ellps=WGS84"))
plot(cuenca.wgs, axes=T, asp=1)

# Extrayendo datos y visualizando el producto ráster PISCO 
r <- stack("PISCOmpe_oudin_v1.1.nc") # El archivo *.nc debe estar en la ruta asignada en swd
# Visualizando la ETP espacial del primer mes (Enero) de 1981.
plot(r[[1]])
# Ploteando la cuenca del rio Chillón dentro del mapa de evapotranspiraciones
plot(cuenca.wgs, add=T)
# Delimitando el área de estudio al cuadrante que ocupa el rio Chillón
r.chillon <- crop(r, cuenca.wgs, snap="out")
# Ploteando enero de 1981 en el cuadrante que ocupa el rio Chillón
plot(r.chillon[[1]])
# Delimitando el área de estudio a la cuenca del rio Chillón
r.chillon <- mask(r.chillon, cuenca.wgs)
# Ploteando los meses de enero a diciembre de 1981
plot(r.chillon[[1:12]])
# Extrayendo los datos y promediando todas las grillas de la cuenca del Chillón
etp.cuenca.mensual <- extract(r.chillon, cuenca.wgs, fun=mean)
colnames(etp.cuenca.mensual) <- 1:ncol(etp.cuenca.mensual)
# Visualizando los 431 datos promediados 
View(etp.cuenca.mensual)
range(etp.cuenca.mensual)
# Ploteando la serie de los 431 valores de evapotranspiracion mensual promedio areal
plot(etp.cuenca.mensual[1,], type="l", col="1", ylab="ETP (mm)", xlab = "Meses", main="Evapotranspiracion mensual areal")
