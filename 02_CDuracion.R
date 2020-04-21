rm(list = ls())
dev.off()
library(waterData)
library(hydroTSM)
datos <- read.csv("D:/2_Courses/R_Hidrologia/Tutorial_files/caudales.csv", header = T)
qdiario <- datos$Qd_m3s
fdc(qdiario,
    lQ.thr=0.9, hQ.thr=0.1,
    plot=TRUE, log="y",
    main= "Curva de duracion Socsi 1970",
    xlab="% Tiempo con caudal igualado o excedido (% de Persistencia)",
    ylab="Caudal diario [m3/s]",
    ylim=c(1,1000),
    yat=c(0.1, 1, 10, 100, 1000),
    col="red", pch=21, lwd=2,
    lty=3, cex=0.4,
    cex.axis=1.2, cex.lab=1.2, leg.txt="1970",
    leg.cex=1, leg.pos="topright",
    verbose=TRUE,
    thr.shw=TRUE,
    new=T)
grid(nx = NULL, ny = NULL,
     col = "lightgray", lty =21, lwd=0.5,
     equilogs = TRUE)
