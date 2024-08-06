### Extraccion de la escorrentia mensual del producto GRUN (Ghiggi et al, 2019)
### https://github.com/hydrocodes
library(terra)
r <- rast(".../bo_GRUN.nc")
plot(r[[1]])
v <- vect(".../ravelo.shp")
plot(v, add=T)
crop <- terra::crop(r, v, snap="out")
plot(crop[[1]])
plot(v, add=T)
long_lat <- read.csv("01_long_lat.csv", header = T) #ingresar coordenadas de extraccion en el archivo csv
long_lat$NN <- NULL
values <- extract(crop, long_lat) 
datos <- t(values)*30.5 # convirtiendo datos diarios a mensuales
View(datos)
write.csv(datos, ".../data_long_lat.csv", quote = F) # archivo de salida
x <- ts(datos[2:nrow(datos)], start=1902, end=2014, frequency = 12)
plot(x, type="l", ylab="Q (mm/mes)", xlab="Años")
lines(lowess(time(x), x), col="blue", lwd=2)
#Para el caso de cuencas que abarcan mas de una grilla. Estimando el peso de cada grilla
weights <- extract(crop[[1]], v, cellnumbers=T,  weights=T) 
