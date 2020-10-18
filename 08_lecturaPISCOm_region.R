### Extraccion de datos desde una region de un raster diario
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(sp)
library(rgdal)
library(raster)
library(ncdf4)
setwd("C:/8_COURSES/UNI-Postgrado/HidrologiaF/05_Laboratorios/lab2") 
cuenca.shape <- readOGR(dsn="files", layer="chillon")
class(cuenca.shape)
plot(cuenca.shape, axes=T,col=c("cyan"))
head(cuenca.shape@data)

cuenca.utm <- spTransform(cuenca.shape, CRS("+proj=utm +zone=18 +ellps=WGS84 +south +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"))
plot(cuenca.utm, axes=T, asp=1)
cuenca.wgs <- spTransform(cuenca.utm, CRS("+proj=longlat +ellps=WGS84"))
plot(cuenca.wgs, axes=T, asp=1)

writeOGR(cuenca.wgs,dsn= "Cuencas.kml",layer= "Cuencas", driver="KML")

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
spplot(r.chillon, col.regions = rev(terrain.colors(100)))


pp.cuenca.mensual <- extract(Pisco.prec.brick, cuenca.wgs, fun=mean)
colnames(pp.cuenca.mensual) <- 1:ncol(pp.cuenca.mensual)
View(pp.cuenca.mensual)
plot(pp.cuenca.mensual[1,], type="l", col="1", ylab="ETP (mm)", xlab = "Meses", main="Evapotranspiracion mensual areal")




