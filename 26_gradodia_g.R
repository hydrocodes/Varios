### Modelo Grado-dia para la estimacion de la escorrentia por derretimiento glaciar
### https://github.com/hydrocodes
# Lectura online de datos y descarga de figura de glaciar
datos <- read.csv("https://raw.githubusercontent.com/hydrocodes/Varios/master/26_datosg.csv")
Tmin <- datos$Tmin
Tmax <- datos$Tmax
Qobs <- datos$Q
download.file("https://github.com/hydrocodes/Varios/blob/master/26_glaciar.PNG?raw=true", 
              destfile=file.path("D:/","glaciar.png"), mode = "wb")
# Parametros del modelo
Ag <- 4.4 #area glaciar km2
ddg <- 8 #factor grado-dia glaciar mm/C.d
cg <- 0.7 #coeficiente escorrentia glaciar  
T0 <- 0 #temperatura limite de derretimiento 
# Procesamiento
Tm <- (Tmin+Tmax)/2
Qg <- (Tm-T0)*ddg*cg*Ag/86.4
Qg[Qg<0] <- 0
idx <- seq(as.Date("1981-01-01"), as.Date("1981-01-31"), by = "day")
# Plot de resultados con figura de fondo
dev.off()
library(png)
ima1 <- readPNG("D:/glaciar.png")
plot (idx, Qg, type="l", ylab="Caudal (m³/s)", xlab="", main="Caudal de derretimiento glaciar", ylim=c(0,4))
lim <- par()
rasterImage(ima1, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
grid(col="white")
lines(idx,Qg, type="l", lwd=2, col="cyan")
lines(idx,Qobs, type="l", lwd=2, col="yellow")
legend("top", legend=c("Simulado", "Observado"),
       col=c("cyan","yellow"), bty = "n", ncol=2, text.col ="white", lty=c(1,1))
