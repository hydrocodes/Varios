### Curva de duracion de caudales con datos online
### Modificado de Rajib y Merwade (2015)
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
library(waterData)
library(hydroTSM)
library(RCurl)
# Opcion 1 - Leyendo archivo csv desde google drive
# Ingresar el ID del archivo compartido abiertamente
id <- "1A4XEx0h1qAbFq-CTKcvmg_unA8Q6JRHV"
gdata <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id))
qdiario <- gdata$Qd_m3s
# Opcion 2 - Leyendo archivo csv desde github
p<-getURL("https://raw.githubusercontent.com/hydrocodes/Varios/master/02_caudales.csv")
datos<-read.csv(text = p)
qdiario <- datos$Qd_m3s

fdc(qdiario,
    lQ.thr=0.9, hQ.thr=0.1,
    plot=TRUE, log="y",
    main= "Curva de duracion",
    xlab="% Tiempo con caudal igualado o excedido (% Persistencia)",
    ylab="Caudal diario (m3/s)",
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
