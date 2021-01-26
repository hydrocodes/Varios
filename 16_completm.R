### Completacion de datos mensuales faltantes
### Método CUTOFF (Feng et al, 2014): Imputacion optimizada de una correlacion cruzada
### http://dx.doi.org/10.1016/j.jhydrol.2014.11.012
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(cutoffR)
# Ingresar una base de datos en csv: %b-%y (date), datos mensuales (cabecera con codigo de estaciones)
data <- read.csv("C:/8_COURSES/R_Hidrologia/Rfiles_base/completacion/data1.csv",header=TRUE, check.names = F, stringsAsFactors = F)
# Ingresar la ruta y el nombre del archivo de salida
output <- "C:/8_COURSES/R_Hidrologia/Rfiles_base/completacion/completm.csv"

# Funcion de completacion
completm <- function(data)
{fechas <- as.POSIXct(paste("01", data$date, sep = "-"), format = "%d-%b-%y")
 data$date <- fechas
 comm <- cutoff(data, method = c("correlation"), corr = "spearman", cutoff = 0.7)
 rownames(comm) <- as.factor(data$date)
 write.csv(comm,output)
}

# Ejecutar funcion
completm(data)

