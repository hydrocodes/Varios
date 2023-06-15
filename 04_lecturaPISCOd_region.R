### Extraccion de la precipitacion diaria desde un netcdf PISCO delimitado por una region poligono shapefile
### https://github.com/hydrocodes
library(sp)
library(rgdal)
library(raster)
library(lattice)
library(latticeExtra)
library(ncdf4)
setwd(".../") 
# Leer un poligono shape "basin"
cuenca.shape <- readOGR(dsn="shapes", layer="basin")
class(cuenca.shape)
plot(cuenca.shape, axes=T,col=c("cyan"))
head(cuenca.shape@data)
# Verificacion de la proyeccion WGS84
cuenca.wgs <- spTransform(cuenca.shape, CRS("+proj=longlat +ellps=WGS84"))
plot(cuenca.wgs, axes=T, asp=1)
# Leyendo las precipitacion diarias desde un raster *.nc"
Pisco.prec.brick <- brick("PISCOpd.nc")
nlayers(Pisco.prec.brick)
plot(Pisco.prec.brick[[1]]) 
plot(cuenca.wgs, add=T)
# Extrayendo las precipitacion diarias para la region
r.region <- crop(Pisco.prec.brick, cuenca.wgs, snap="out")
plot(r.region[[1]])
plot(cuenca.wgs, add=T)
pp.cuenca.diaria <- extract(r.region, cuenca.wgs, fun=mean)
colnames(pp.cuenca.diaria) <- 1:ncol(pp.cuenca.diaria)
range(pp.cuenca.diaria)
plot(pp.cuenca.diaria[1,], type="o", col="1", ylim=c(0,200), ylab="P (mm/d)", xlab = "Dias", main="Precipitacion diaria areal")
write.csv(t(pp.cuenca.diaria), file="pd_region.csv")
