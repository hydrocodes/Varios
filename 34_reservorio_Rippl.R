### Metodo Rippl o "curva masa"  para el caudal-volumen de operacion en reservorios
### https://github.com/hydrocodes
library(reservoir)
library(png)
data <- read.csv("https://raw.githubusercontent.com/hydrocodes/Varios/master/33_Qm.csv", header=F) # caudal de ingreso en m3/s
op <- Rippl(data$V1, target=10, plot = T) #caudal constante de salida en "target", en m3/s
idx <- seq(as.Date('1981-01-01'),as.Date('2022-12-31'), by = "month")
vol <- op$No_fail_storage*3600*24*30/10^6; vol #volumen de operacion en MMC
vol_serie <- op$Storage_behavior*3600*24*30/10^6; vol_serie #serie de volumenes en MMC
spill_serie <- op$Uncontrolled_spill; spill_serie #serie de caudales por el vertedero
plot(idx, vol_serie,  type="l", xlab="Date", ylab="Storage (MCM)", col="blue", main="Reservoir operation")
ima1 <- readPNG("presa.PNG")
lim <- par()
rasterImage(ima1, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
grid(col="white")
lines(idx, vol_serie, type="l", col="cyan", lwd=2, lty=1)
plot(idx, op$Uncontrolled_spill, type="l", xlab="Date", ylab="Spillway discharge (m3/s)", col="brown")

