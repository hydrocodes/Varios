### Obtencion de la Curva Numero promedio para una region en shapefile
### Uso del producto GCN250 Jaafar et al (2019)
### https://doi.org/10.6084/m9.figshare.7756202
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(raster)
library(rgdal)
library(maps)
topo <- raster(".../GCN250_ARCIII.tif")
str(topo)
shpfile <- readOGR(".../caplina.shp") #shapefile en WGS84 geo
plot(shpfile)
topo.crop <- crop(topo, shpfile, snap="out")
plot(topo.crop)
topo.mask <- mask(topo.crop, shpfile, snap="out")
plot(topo.mask)
str(topo.mask)
cn.mean <- cellStats(topo.mask, stat='mean', na.rm=TRUE) #valor CN promedio
