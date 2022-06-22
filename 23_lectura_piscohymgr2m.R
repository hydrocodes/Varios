### Lectura de netcdf producto PISCO-HyM-GR2m Caudales mensuales para Peru
### Llauca et al (2021) https://doi.org/10.3390/w13081048
### https://github.com/hydrocodes
library(raster)
r <- stack("C:/.../pisco_hym.nc")
Qm <- rev(r[,93]) # indicar el ID de la cuenca despues de la coma (ver shapefiles de cuencas y rios)
Qmd <- ts(Qm, start = c(1981,1), freq=12)
plot.ts(Qmd, ylab="Streamflow (m3/s)")
