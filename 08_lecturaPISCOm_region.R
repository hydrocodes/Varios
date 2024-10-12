### Extraccion de datos del raster PISCO de precipitacion mensual delimitado por un poligono shapefile
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
#Llamando al paquete terra
library(terra)
#Leyendo el archivo netcdf desde la ruta y nombre almacenado
r <- rast("C:/.../PISCOm_pr.nc")
#Ploteando el primer [1] mes del raster
plot(r[[1]])
#Leyendo el shapefile desde la ruta y nombre almacenado
v <- vect("C:/.../chillon.shp")
#Ploteando la cuenca encima del netcdf
plot(v, add=T)
#Cortando el netcdf hasta las extensiones del shapefile
crop <- terra::crop(r, v)
plot(crop[[1]]) #Ploteando el netcdf cortado
plot(v, add=T) #Ploteando la cuenca encima del netcdf cortado
#Capturando toda el área del shapefile
r.basin <- mask(crop, v)
# Ploteando los meses de enero a diciembre [1:12] de 1981
plot(r.basin[[1:12]])
# Extrayendo los datos y promediando todas las grillas contenidas en la cuenca
p.mensual <- extract(r.basin, v, fun=mean)
# Asignando valores numéricos consecutivos a la ubicación de las columnas generadas
colnames(p.mensual) <- 1:ncol(p.mensual)
# Visualizando los datos
View(p.mensual[2:ncol(p.mensual)])
# Obteniendo el rango max y min de las precipitaciones obtenidas
range(p.mensual[2:ncol(p.mensual)])
# Ploteando la serie de precipitación promedio areal
plot(t(p.mensual[2:ncol(p.mensual)]), type="l", ylab="P (mm)",
     main="Precipitacion mensual areal PISCO", col="blue")
