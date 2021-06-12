### Modelo de Horton a partir de un ensayo de infiltracion
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
# Lectura de archivo txt con dos columnas "tiempo" acumulado en minutos y "lamina" infiltrada acumulada en cm
data <- read.table("/21_dobleanillo.txt", header=T)
i_f <- 2 #ingresar la capacidad de infiltracion final en mm/hr

# Procesamiento
t <- data$tiempo
l <- data$lamina
tc <- t/60
thrc <- tc[-1]
thr <- c()
lmm <- c()
for (i in 2:length(t)) {
  thr[i-1] <- (t[i]-t[i-1])/60
}
for (i in 2:length(l)) {
  lmm[i-1] <- (l[i]-l[i-1])*10
}
inf <- lmm/thr
# Modelo de ajuste lineal y plot
horton.lm <- lm(log10(inf-i_f) ~ thrc)
y.log.e <- summary(horton.lm )$coefficients[2,1]
log.i_o.i_f <- summary(horton.lm )$coefficients[1,1]
i_o <- 10^log.i_o.i_f + i_f
y <- y.log.e/log10(exp(1))
corr <- cor(log10(inf-i_f),thrc)
sim <- i_f + (i_o-i_f)*exp(y*thrc)
sprintf("Capacidad de infiltracion inicial io = %f mm/hr", i_o)
sprintf("Constante de recesion y = %f 1/hr", -y)
sprintf("Coef. correlacion Modelo = %f", corr)
sprintf("i = %f + %f exp ( %f t )",i_f, i_o-i_f,y)
plot(thrc,inf, type="o", col=1, xlab="t (hr)", ylab="i (mm/hr)", main="Modelo de infiltracion de Horton")
lines(thrc,sim, type="l", col=2, lty=2, xlab="t (hr)", ylab="i (mm/hr)")
legend("topright", legend = c("Observado","Simulado"), col = c(1,2),lty = c(1, 2))
