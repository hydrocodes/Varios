### Preparacion de datos formato SNIRH-Peru de 12HR a Mensual
### https://github.com/hydrocodes
library(dplyr)
library(zoo)
library(xts)
bdd <- read.csv(file.choose(),header=TRUE) #leer archivo CSV de precipitaciones
bdd$FECHA <-as.POSIXct(paste(bdd$FECHA, bdd$HORA), format="%d/%m/%Y %H:%M", tz = "GMT")
bdd$HORA <- NULL
ts <- seq.POSIXt(as.POSIXct("1963-11-15 07:00:00",'%Y-%m-%d %H:%M:%S', tz = "GMT"), as.POSIXct("2018-04-30 19:00:00",'%Y-%m-%d %H:%M:%S', tz = "GMT"), by="12 hours")
df <- data.frame(FECHA=ts)
bdd_sf <- full_join(df,bdd) #sin fechas faltantes

df1.zoo <- zoo(bdd_sf[,-1], order.by = bdd_sf[,1]) #revisar fechas iniciales y finales
plot(df1.zoo, ylab="P 12HR (mm)", xlab="Fecha") #Ploteando la serie de tiempo 12HR
bdd_d <- rollapplyr(df1.zoo[,2], 2, sum, by = 2) #sumando valores 12HR para obtener diarios
plot(bdd_d, ylab="P diaria (mm)", xlab="Fecha") #Ploteando la serie de tiempo diaria
bdd_m <- apply.monthly(bdd_d, FUN = sum) #sumando valores diarios para obtener mensuales
plot(bdd_m, ylab="P mensual (mm)", xlab="Fecha") #Ploteando la serie de tiempo mensual
write.csv(bdd_m,"mensual.csv", row.names = T) #grabando los datos mensuales
