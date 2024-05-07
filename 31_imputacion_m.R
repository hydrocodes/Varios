### Imputacion simple de datos mensuales
### https://github.com/hydrocodes

### Metodo del promedio mensual
data <- read.table(file.choose(), header=T, sep="\t") #leer txt con estaciones A y B
estacionA <- data$A
resA <- cbind.data.frame(split(estacionA, rep(1:12, times=length(estacionA)/12)), stringsAsFactors=F)
names(resA) <- c("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
for (i in 1:ncol(resA)) {
  resA[is.na(resA[,i]), i] <- mean(resA[,i], na.rm=T)
}
View(resA)

### Metodo por regresion lineal
data <- read.table(file.choose(), header=T, sep="\t") #leer txt con estaciones A y B
estacionA <- data$A
resA <- cbind.data.frame(split(estacionA, rep(1:12, times=length(estacionA)/12)), stringsAsFactors=F)
names(resA) <- c("Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic")
estacionB <- data$B
resB <- cbind.data.frame(split(estacionB, rep(1:12, times=length(estacionB)/12)), stringsAsFactors=F)
names(resB) <- names(resA)
View(resA)
View(resB)
#Completando vacios de Diciembre en A y B
compl <- lm(resA$Dic ~ resB$Dic)
summary(compl)
new_resA_Dic <- compl$coefficients[2]*resB$Dic + compl$coefficients[1]
resA$Dic[is.na(resA$Dic)] <- new_resA_Dic[is.na(resA$Dic)] #Completando Dic A
View(resA)

compl <- lm(resB$Dic ~ resA$Dic)
summary(compl)
new_resB_Dic <- compl$coefficients[2]*resA$Dic + compl$coefficients[1]
resB$Dic[is.na(resB$Dic)] <- new_resB_Dic[is.na(resB$Dic)] #Completando Dic B
View(resB)
