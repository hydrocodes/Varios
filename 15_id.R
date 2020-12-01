### Lectura de los numeros para  el desarrollo del BID
### https://github.com/EL-BID/Libreria-R-Numeros-para-el-Desarrollo
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
library("devtools")
install_github("EL-BID/Libreria-R-Numeros-para-el-Desarrollo")
library("iadbstats") 

# Ingresar el(los) codigo(s) del pais y del indicador de desarrollo
data<-iadbstats(country="PER,CHL,MEX",frequency="year",indicatorcode="SOC_2540")
head(data)
library(ggplot2)

# Editar el ploteo
ggplot(data, aes(x=Year, y=AggregatedValue, color=CountryTableName, group=CountryTableName)) +
  geom_line(size = 2) + xlab('Año') + ylab('Hogares rurales pobres con acceso a agua entubada (%)')
