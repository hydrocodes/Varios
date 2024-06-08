### Metodo Rippl o "curva masa"  para el caudal-volumen de operacion en reservorios
### https://github.com/hydrocodes
library(reservoir)
data <- read.csv("https://raw.githubusercontent.com/hydrocodes/Varios/master/33_Qm.csv", header=F) # caudal de ingreso en m3/s
op <- Rippl(data$V1, target=10, plot = F) #caudal constante de salida en "target", en m3/s
idx <- seq(as.Date('1981-01-01'),as.Date('2022-12-31'), by = "month")
plot(idx, op$Storage_behavior,  type="l", xlab="Date", ylab="Storage (m3/s)", col="blue")
plot(idx, op$Uncontrolled_spill, type="l", xlab="Date", ylab="Spillway discharge (m3/s)", col="brown")
op$No_fail_storage # caudal-volumen en m3/s de operacion
