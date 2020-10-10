rm(list=ls())
dev.off()
library(raster)
library(rgdal)
library(maps)
topo <- raster("C:/9_RECHERCHE/Algerie/sig_algerie/grids/srtm_37_05.tif") #insérer le raster tif
str(topo)
shpfile <- readOGR("C:/9_RECHERCHE/Algerie/sig_algerie/shapes/isser_finale.shp") #insérer le bassin shp
topo.crop <- crop(topo, shpfile, snap="out")
plot(topo.crop)
topo.mask <- mask(topo.crop, shpfile, snap="out")
plot(topo.mask)
str(topo.mask)
plot(ecdf(topo.mask@data@values), main="Courbe Hypsométrique", xlab="Altitude (m)")
f<-ecdf(topo.mask@data@values) #les résultats x et y de l'ecdf
  x <- environment(f)$x
  y <- environment(f)$y
par(mfrow=c(1,2))
par(mar = c(4, 4, 4, 2)) 
plot(topo.mask,
     breaks = c(0,250, 500,750, 1000, 1250, 1500, maxValue(topo.mask)),
     col = rev(terrain.colors(6)),
     main="Relief de l'oued Isser",
     xlab="Longitude",
     ylab="Latitude"
     )
maps::map.scale(2.8, 36.8, relwidth = 0.15, ratio = FALSE)
par(mar = c(6, 6, 4, 2)) 
plot(100*y,x, type="l", col="blue", main="Courbe Hypsométrique", xlab="Surface cumulée (%)", ylab="Altitude (m)")

raster::area(shpfile) 
raster::perimeter(shpfile) 
library(rgeos)
gArea(shpfile)
