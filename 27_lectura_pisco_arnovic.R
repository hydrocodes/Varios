### Extraccion del caudal medio diario de PISCO_HyD_ARNOVIC v1.0 para un "comid" (Llauca y Leon, 2023)
### https://github.com/hydrocodes
library(raster)
filename <- '.../PISCO_HyD_ARNOVIC_v1.0.nc'
nc <- nc_open(filename)
comid <- ncvar_get(nc,'comid')
time <- as.Date(as.POSIXct(ncvar_get(nc,'time'), origin="1970-01-01"))
qr <- round(t(ncvar_get(nc,'qr')),1)
mycomid <- 9089523 #ingresar numero de comid 
ind <- which(comid==mycomid)
my_df <- data.frame(Dates=time, Q_m3s=qr[,ind])
write.csv(my_df, ".../caudal.csv")
