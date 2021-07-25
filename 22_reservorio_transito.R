### Transito de avenidas en resevorios - Método de la Piscina Nivelada o Puls modificado
### https://github.com/hydrocodes
library(RHMS)
data1 <- read.table(".../input.txt", header=TRUE)  #leer hidrograma de entrada
data2 <- read.table(".../sc.txt", header=TRUE) #leer datos elevacion m vs almacenamiento MMC
data3 <- read.table(".../dc.txt", header=TRUE) #leer datos elevacion m vs caudal por vertedero m3/s

input <- data1$input
storageElevationCurve<-data.frame(s=data2$se,h=data2$he)
dischargeElevationCurve<-data.frame(q=data3$qd,h=data3$hd)
geometry<-list(storageElevationCurve=storageElevationCurve,
               dischargeElevationCurve=dischargeElevationCurve,
               capacity=5.458) # almacenamiento MMC inicio de interaciones
simulation<-list(start='2000-01-01',end='2000-01-02',by=1800)
reservoir_sim<-reservoirRouting(inflow=input, geometry=geometry, simulation=simulation)
plot(reservoir_sim$operation[,1],typ="o", ylab="Discharge rate (cms)", xlab="Time step")
lines(reservoir_sim$operation[,3],col=2)
