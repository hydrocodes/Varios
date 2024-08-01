### Obtencion de la Curva Numero promedio para un poligono shapefile
### Uso del producto GCN250 Jaafar et al (2019)
### https://doi.org/10.6084/m9.figshare.7756202
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(raster)
library(terra)
cn <- rast("C:/.../GCN250_ARCII.tif")
str(cn) #verificar estructura SpatRaster
shpfile <- vect("C:/.../cuenca_caplina_ac.shp") #shapefile en WGS84 geo
plot(shpfile)
cn.crop <- crop(cn, shpfile)
plot(cn.crop)
cn.mask <- mask(cn.crop, shpfile)
plot(cn.mask)
cn.mean <- global(cn.mask, "mean", na.rm=T);cn.mean #mostrar promedio sin considerar los vacios NA
