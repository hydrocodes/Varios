### Extraccion de la temperatura mensual desde un netcdf CRU TS v.4.04 (Harris et al, 2020) para coordenada(s) almacenada(s) en csv
### https://github.com/hydrocodes
library(raster)
library(ncdf4)
library(sp)
setwd(".../")  
long_lat <- read.csv("11_long_lat.csv", header = T)
raster_pp <- raster::brick("cru_ts4.04.2011.2019.tmp.dat.nc", varname="tmp")
sp::coordinates(long_lat) <- ~XX+YY
raster::projection(long_lat) <- raster::projection(raster_pp)
points_long_lat <- raster::extract(raster_pp[[1]], long_lat, cellnumbers = T)[,1]
data_long_lat <- t(raster_pp[points_long_lat])
colnames(data_long_lat) <- as.character(long_lat$NN)
plot(data_long_lat, type="l", ylab="Tm (°C)", main="Temperatura media mensual")
write.csv(data_long_lat, "11_Tmp_CRU.csv", quote = F)
