### Plotear un shp, caso mapa de aridez del Peru (Rau, 2019)
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(raster)
library(rgdal)
shpfile <- readOGR("peru_aridez_regiones.shp")
head(shpfile)
all_shp_colors <- c("red", "yellow", "orange", "green", "white")[shpfile$DN]
l_palette <- c("red", "yellow", "orange", "green", "white")
par(mar = c(4, 4, 3, 2)) 
plot(shpfile,
     col = all_shp_colors,
     main = "Mapa de aridez del Perú",
     axes=T, xlab="Longitud", ylab="Latitud"
     )
text(-82,-9,"Océano\nPacífico", cex=0.8)
legend(-86,-11.5,
       legend = c("hiperárido", "árido", "semiárido", "subhúmedo seco"),
       fill = l_palette,
       bty="n",
       cex=0.9)

