### Completacion de datos diarios faltantes
### Método CUTOFF (Feng et al, 2014): Imputacion optimizada de una correlacion cruzada
### http://dx.doi.org/10.1016/j.jhydrol.2014.11.012
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(cutoffR)
# Ingresar una base de datos en csv: %d-%b-%y (date), datos diarios (cabecera con codigo de estaciones)
data <- read.csv("C:/8_COURSES/R_Hidrologia/Rfiles_base/completacion/data0.csv",header=TRUE, check.names = F, stringsAsFactors = F)
# Ingresar la ruta y el nombre del archivo de salida
output <- "C:/8_COURSES/R_Hidrologia/Rfiles_base/completacion/completd.csv"

# Funcion de completacion
completd <- function(data)
{fechas <- as.POSIXct(data$date, sep = "-", format = "%d-%b-%y")
 data$date <- fechas
 comd <- cutoff(data, method = c("correlation"), corr = "spearman", cutoff = 0.5)
 rownames(comd) <- as.factor(data$date)
 write.csv(comd,output)
}

# Ejecutar funcion
completd(data)
