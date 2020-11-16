### Balance iónico y Diagrama de Piper
### https://github.com/hydrocodes
library(hydrogeo)
# Ingresar concentraciones en mg/l por muestra y separados por comas
# De no existir valores completar con ceros
# Cationes
Ca_mgl <- c(25.96,39.02,8.976,16.77)
Mg_mgl <- c(9.41,8.82,3.33,5.03)
Na_mgl <- c(11.27,12.73,7.82,25.95)
K_mgl <- c(3.20,1.95,4.43,6.02)
# Aniones
Cl_mgl <- c(4.7,6,2.4,11.7)
SO4_mgl <- c(17,30,4,55)
HCO3_mgl <- c(99,108,69,84)
NO3_mgl <- c(20,22,1,4)

#### No cambiar ####
Ca_meql <- Ca_mgl/20
Mg_meql <- Mg_mgl/12.15
Na_meql <- Na_mgl/23
K_meql <- K_mgl/39.1
Cl_meql <- Cl_mgl/35.45
SO4_meql <- SO4_mgl/48.05
HCO3_meql <- HCO3_mgl/61
NO3_meql <-NO3_mgl/62
total_cat <- Ca_meql+Mg_meql+Na_meql+K_meql
total_an <- Cl_meql+SO4_meql+HCO3_meql+NO3_meql
Error <- (total_cat-total_an)*100/(total_cat+total_an)
#### end ####

# Error calculado en %, debe ser inferior al 5% en todas las muestras
Error

# Plotear el Diagrama de Piper
# col: colores 1-negro, 2-rojo, 3-verde, 4-azul, 5-cyan ...
# pch: forma 1-circulo, 2-triangulo, 3-cruz, 4-equis, 5-rombo ...
l <- list(Ca=Ca_meql*100/total_cat, Mg=Mg_meql*100/total_cat, Cl=Cl_meql*100/total_an, SO4=SO4_meql*100/total_an)
lp <- piper(l)
lp@pt.col = c(1,2,3,4)
lp@pt.pch = c(2,2,2,2)
plot(lp, main="Diagrama de Piper", cex=1.4, cex.lab = 1.2)
