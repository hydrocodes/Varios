### Transito de avenidas en resevorios - Método de la Piscina Nivelada o Puls modificado
### https://github.com/hydrocodes
library(RHMS)
data1 <- read.table("D:/2_Courses/R_Hidrologia/Tutorial_files/hechms/input.txt", header=TRUE)
data2 <- read.table("D:/2_Courses/R_Hidrologia/Tutorial_files/hechms/sc.txt", header=TRUE)
data3 <- read.table("D:/2_Courses/R_Hidrologia/Tutorial_files/hechms/dc.txt", header=TRUE)

input <- data1$input
storageElevationCurve<-data.frame(s=data2$se,h=data2$he)
dischargeElevationCurve<-data.frame(q=data3$qd,h=data3$hd)
geometry<-list(storageElevationCurve=storageElevationCurve,
               dischargeElevationCurve=dischargeElevationCurve,
               capacity=5.458)
simulation<-list(start='2000-01-01',end='2000-01-02',by=1800)
reservoir_sim<-reservoirRouting(inflow=input, geometry=geometry, simulation=simulation)
plot(reservoir_sim$operation[,1],typ="o", ylab="Discharge rate (cms)", xlab="Time step")
lines(reservoir_sim$operation[,3],col=2)
