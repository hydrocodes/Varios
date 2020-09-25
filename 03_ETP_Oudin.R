### Evapotranspiración Potencial diaria por el Metodo de Oudin (Oudin et al, 2005)
### Modificado de Begueria (2013)
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
library(RCurl)
p<-getURL("https://raw.githubusercontent.com/hydrocodes/Varios/master/03_Tm_d.csv")
datos<-read.csv(text = p)
tm <- datos$Td
times <- datos$Fecha
times <- as.POSIXlt(times, format="%Y-%m-%d")
oudinD <- function (tm, times, lat)
{ n <- length(tm) 
ET0 <- tm*NA
tm <- ifelse(tm < 0, 0, tm)
J <- times$yday+1
delta <- 0.409 * sin(0.0172 * J - 1.39)
dr <- 1 + 0.033 * cos(0.0172 * J)
latr <- lat/57.2957795
sset <- -tan(latr) * tan(delta)
omegas <- sset * 0
omegas[sset>={-1} & sset<=1] <- acos(sset[sset>={-1} & sset<=1])
omegas[sset<{-1}] <- max(omegas)
Ra <- 37.6 * dr * (omegas * sin(latr) * sin(delta) + cos(latr) * cos(delta) * sin(omegas))
Ra <- ifelse(Ra < 0, 0, Ra)
ET0 <- 0.408 * Ra * (tm + 5) / 100
ET0 <- ifelse(ET0 < 0, 0, ET0)
return(ET0) }
###Ingresar la latitud (+N o -S) como ultimo parámetro de la función oudinDay
ET0d<-oudinD(tm, times, -11)
write.csv(ET0d, file="D:/2_Courses/R_Hidrologia/Tutorial_files/03_ETP.csv")
plot(times, ET0d, main="Evapotranspiración Potencial diaria - Método de Oudin", xlab="Dias", ylab="ETP (mm/d)", col="blue")
