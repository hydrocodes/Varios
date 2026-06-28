### Modelo ENSO oscilador retardado simple 
### https://github.com/hydrocodes
library(ggplot2)

# Ingreso de parametros de tiempo
years <- 30
dt <- 1  #paso de tiempo mensual
yr <- years*12
time <- seq(1,yr)

# Ingreso de parametros fisicos
A <- 0.05            # retroalimentacion positiva oceano-atmosferica (e.g. de Bjerknes)
B <- 0.15            # retroalimentacion negativa retardada (e.g. ondas ecuatoriales: Kelvin, Rossby)
n <- 8               # retardo en meses (eta)
noise.sd <- 0.05     # forzante atmosferica estocastica

# Generando anomalias de temperatura superficial del mar con el modelo
T <- rep(0,yr)
T[1:n] <- 0.2
for(i in (n+1):(yr-1)){
  growth <- A*T[i]
  delayed <- B*T[i-n]
  noise <- rnorm(1,0,noise.sd)
  T[i+1] <- T[i] + dt*(growth-delayed) + noise
}
ENSO <- data.frame(Month=time, Year=time/12, SST=T)

# Clasificando la fase del ENSO
ENSO$Phase <- "Neutral"
ENSO$Phase[ENSO$SST > 0.5] <- "El Niño"
ENSO$Phase[ENSO$SST < -0.5] <- "La Niña"

# Plot final
ggplot(ENSO, aes(Year,SST))+
  geom_line(color="steelblue", linewidth=1)+
  geom_hline(yintercept=c(-0.5,0.5), linetype=2, color="red")+
  labs(title="Modelo ENSO oscilador retardado simple", x="Año", y="Anomalia SST (°C)")+
  theme_bw()
