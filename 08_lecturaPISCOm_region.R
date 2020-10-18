### Extraccion de la evapotranspiracion mensual desde un raster PISCO delimitado por una region poligono shapefile
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(sp)
library(rgdal)
library(raster)
library(ncdf4)
setwd(".../") 
cuenca.shape <- readOGR(dsn="files", layer="chillon")
class(cuenca.shape)
plot(cuenca.shape, axes=T,col=c("cyan"))
head(cuenca.shape@data)
#Verificar y/o convertir coordenadas
cuenca.utm <- spTransform(cuenca.shape, CRS("+proj=utm +zone=18 +ellps=WGS84 +south +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"))
plot(cuenca.utm, axes=T, asp=1)
cuenca.wgs <- spTransform(cuenca.utm, CRS("+proj=longlat +ellps=WGS84"))
plot(cuenca.wgs, axes=T, asp=1)

Pisco.prec.brick <- brick("PISCOmpe_oudin_v1.1.nc")
Pisco.prec.brick
nlayers(Pisco.prec.brick)
plot(Pisco.prec.brick[[1:12]]) 

# Extraer los valores prec. promedio areal para el Chillôn
r <- stack("PISCOmpe_oudin_v1.1.nc")
plot(r[[1]])
plot(cuenca.wgs, add=T)
r.chillon <- crop(r, cuenca.wgs, snap="out")
plot(r.chillon[[1:12]])
r.chillon <- mask(r.chillon, cuenca.wgs)
plot(r.chillon[[1:12]])

etp.cuenca.mensual <- extract(Pisco.prec.brick, cuenca.wgs, fun=mean)
colnames(etp.cuenca.mensual) <- 1:ncol(etp.cuenca.mensual)
plot(etp.cuenca.mensual[1,], type="l", col="1", ylab="ETP (mm)", xlab = "Meses", main="Evapotranspiracion mensual areal")

