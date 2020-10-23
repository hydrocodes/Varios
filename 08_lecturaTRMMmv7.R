### Extraccion de datos desde netcdfs TRMM3B43, caso cuenca Ravelo (Bolivia)
### https://github.com/hydrocodes
rm(list=ls())
library(ncdf4)
library(sp)
library(lattice)
library(rgdal)
library(raster)
library(maps)
library(rgl)
setwd("C:/8_COURSES/USFX-Posgrado/HAplicada/labos/trmm") #Carpeta donde se encuentren descargados los archivos NetCDF del TRMM

#Convirtiendo de shapefile poligono a un raster de 0.05 x 0.05
p <- shapefile('ravelo.shp')
plot(p, axes=T,col=c("cyan"))
pgeo <- spTransform(p, CRS('+proj=longlat +datum=WGS84'))
ext <- floor(extent(pgeo))
rr <- raster(ext, res=0.05)
rr <- rasterize(pgeo, rr, field=1)
str(rr)
plot(rr)
trmm.stack2017<-stack() #stack vacio para alimentarlo con rasters leidos
i=1
for(i in i:12) {
  trmm.read<-paste("3B43.2017",i,"01.7.HDF.nc", sep="") # Lectura de formato de nombres de archivos
  
  #Lectura y conversion a raster
  ras.trmm.read<-brick(trmm.read, values=T, varname="precipitation") # Lectura de raster TRMM
  
  plot(ras.trmm.read) # Verificacion del ploteo (se muestra invertido?)
  raster.trmm <- raster(ras.trmm.read,layer=1) # Lectura como formato raster
  ras.flip1 <- flip(raster.trmm,2) # Lectura como formato raster
  ras.flip2 <- t(ras.flip1) # Rotar de dirección
  plot(ras.flip2) # Transponer ejes
  ras.flip <- flip(ras.flip2,2) # Rotar datos
  plot(ras.flip) # Verificacion del ploteo (ok!)
  
  ras.trmm<-ras.flip*30.5*24 # Convertir de mm/hr (unidades iniciales del TRMM 3B43) a mm/mes
  class(ras.trmm)
  plot(ras.trmm) #plot para verificar la lectura correcta
  # Usar el mismo sistema WGS84 Geográfico en trmm y raster
  projection(ras.trmm)<-projection(rr) 
  str(ras.trmm)
  # Extensión de los limites del analisis (xmin, xmax, ymin, ymax)
  extent(ras.trmm)<-extent(c(-180,180,-50,50)) #Extension de datos
  # Convirtiendo la resolucion del raster 0.05 x 0.05 a la resolucion del TRMM 0.25°x0.25°
  rrResamp<-resample(rr, ras.trmm, resample="bilinear")
  # Captura de datos TRMM dentro de una máscara de cuenca (raster de la cuenca)
  precip_rr<-mask(ras.trmm, rrResamp)
  plot(precip_rr, ext = extent(rr))
  names(precip_rr)<-trmm.read
  trmm.stack2017<-stack(trmm.stack2017, precip_rr, na.rm=TRUE)
}

plot (trmm.stack2017, ext = extent(rr))

# Lectura del promedio de todas las grillas del raster final
avg_trmm.stack2017 <- as.data.frame(cellStats(trmm.stack2017,mean))
month<-c(1:12)
plot(month,cellStats(trmm.stack2017, mean),ylab="TRMM (mm/month)", type="o", col="blue")
