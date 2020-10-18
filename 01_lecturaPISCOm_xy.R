### Extraccion de la precipitacion mensual desde un raster PISCO para una coordenada
### https://github.com/hydrocodes
setwd(".../")  
rm(list = ls())
library(raster)
library(ncdf4)
library(sp)
long_lat <- read.csv("long_lat.csv", header = T)
raster_pp <- raster::brick("PISCOV3-MONTHLY.nc")
sp::coordinates(long_lat) <- ~XX+YY
raster::projection(long_lat) <- raster::projection(raster_pp)
points_long_lat <- raster::extract(raster_pp[[1]], long_lat, cellnumbers = T)[,1]
data_long_lat <- t(raster_pp[points_long_lat])
colnames(data_long_lat) <- as.character(long_lat$NN)
save.image("D:/2_Courses/R_Hidrologia/Tutorial_files/data_long_lat.csv")
write.csv(data_long_lat, "data_long_lat.csv", quote = F)
