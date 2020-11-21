### Análisis de frecuencia usando la distribución de probabilidad Gumbel (Valor extremo tipo I)
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
# lectura de archivo txt, con cabecera max
data <- read.table(file.choose(), header=T)
Q <- data$max
# añadir en Ttick y xtlab, otros periodos de retorno ascendentes, separados por comas 
TR <-
  c(1.001,1.01,1.1,1.5,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25,30,35,40,45,50,60,70,80,90,100)
xtlab <-
  c(1.001,1.01,1.1,1.5,2,NA,NA,5,NA,NA,NA,NA,10,NA,NA,NA,NA,15,NA,NA,NA,NA,20,NA,30,NA,NA,NA,50,NA,NA,NA,NA,100)

#### no cambiar ####
n <- length(Q)
r <- n + 1 - rank(Q)
T <- (n + 1)/r
y <- -log(-log(1 - 1/T))
ytick <- -log(-log(1 - 1/TR))
xmin <- min(min(y),min(ytick))
xmax <- max(ytick)
KTtick <- -(sqrt(6)/pi)*(0.5772 + log(log(TR/(TR-1))))
QT <- mean(Q) + KTtick*sd(Q)
nQ <- length(Q)
se <- (sd(Q)*sqrt((1+1.14*KTtick + 1.1*KTtick^2)))/sqrt(nQ)
LB <- QT - qt(0.975, nQ - 1)*se
UB <- QT + qt(0.975, nQ - 1)*se
max <- max(UB)
Qmax <- max(QT)
#### end ####

# plotear, editar la etiqueta del eje vertical
plot(y, Q,
     ylab = expression( "Pmax24h (mm)" ) ,
     xaxt = "n", xlab = "Periodo de retorno, T (años)",
     ylim = c(0, Qmax),
     xlim = c(xmin, xmax),
     pch = 21, bg = "red",
     main = "Analisis de frecuencia - Gumbel"
)
par(cex = 0.65)
axis(1, at = ytick, labels = as.character(xtlab))
lines(ytick, QT, col = "black", lty=1, lwd=2)
lines(ytick, LB, col = "green", lty = 1, lwd=1.5)
lines(ytick, UB, col = "green", lty = 1, lwd=1.5)
abline(v = ytick, lty = 3, col="light gray")

# editar el grillado horizontal en h=seq() en función de los datos
abline(h = seq(20, floor(Qmax), 20), lty = 3,col="light gray")
par(cex=1)
# ver resultados (TR = Periodo de retorno en años, QT = Valor calculado)
values <- data.frame(TR,QT) ; values

# Prueba de Kolmogorov-Smirnov
Qs <- sort(Q)
pw <- c()
for (i in 1:n)
{ pw[i] <- i/(n+1) 
}; pw
cdf <- c()
  for (i in 1:n)
    {cdf[i] <- exp(-exp(-(Qs[i]-(mean(Qs)-0.57721*sqrt(6)*sd(Qs)/pi))/(sqrt(6)*sd(Qs)/pi))) 
    }; cdf
plot(Qs, cdf, type="l", col="red", lty=1, main="Funcion de distribucion acumulada", xlab="datos", ylab="Probabilidad")
lines(Qs, pw, type="b", col="blue", pch=18)
legend("bottomright",legend=c("Distribucion Gumbel", "Distribucion Empirica"), lty=1:2 , col=c("red","blue"),cex=0.8, text.font=1)
grid()
dFP <- abs(pw-cdf)
dFP <- sort(dFP, decreasing = TRUE) ; dFP
delta <- dFP[1] ; delta
# Comparacion con el delta teorico para un p=0.05
library(cowsay)
if(n<35) {
  D005 <- 1.358/(sqrt(n)+0.12+(0.11/sqrt(n)))
} else  { D005 <- 1.36/sqrt (n)}; D005 
data.frame (delta , D005)
if (D005>delta) {say("La distribución se ajusta a los datos!", by = "cat")
}  else  {say("La distribución no se ajusta a los datos! editar el codigo para un p=0.1 o superior o emplear otra distribucion", by = "behindcat")}
