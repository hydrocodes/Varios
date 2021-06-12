### Modelo Precipitacion-Escorrentia (P-Q) puntual basado en el modelo de infiltracion Green-Ampt
### Modificado de Moore (2020)
### https://github.com/hydrocodes
rm(list = ls())
dev.off()
# Lectura de archivo txt con dos columnas "tiempo" en minutos continuos y "precipitacion" en mm
data <- read.table(".../20_evento_prec.txt", header=T)
# Ingresar parametros del suelo
p0 = 0.437   #porosidad                                               
p0e = 0.401  #porosidad efectiva          
Se = 0.1     #saturacion efectiva inicial          
psi = 6.13   #carga de succion en cm                            
K = 2.5      #conductividad hidraulica saturada en cm/hr                            
hstor = 0.25 #almacenamiento de depresion en cm

# Procesamiento
dtheta0 <- p0e*(1-Se) #cambio en la humedad del suelo
pcm <- (data$precipitacion)/10
t <- data$tiempo
nt <- length(t);                                                                         
dt <- t[2]-t[1]
fp <- rep(0,nt); dFa <- rep(0,nt)
Fp <- rep(0,nt); dFp <- rep(0,nt)              
Sstor <- rep(0,nt); exc <- rep(0,nt)
runoff <- rep(0,nt);dSstor <- rep(0,nt)
dexc <- rep(0,nt); pcm_Sstor <- rep(0,nt)  
Fp[1] <- 0.00001 #valor inicial 
for (i in 2:nt){                                                                          
  fp[i] <- K*(1 + (psi*dtheta0)/Fp[i-1]) #tasa de infiltracion potencial
  dFp[i] <- fp[i]*dt/60                  #infiltracion acumulada potencial                        
  pcm_Sstor[i] <- pcm[i]+Sstor[i-1]      #ingreso de almacenamiento                          
  dFa[i] <- min(dFp[i],pcm_Sstor[i])     #incremento de infiltracion real                      
  Fp[i] <- Fp[i-1] + dFa[i]              #infiltracion real                                   
  dexc[i] <- pcm_Sstor[i] - dFa[i]       #precipitacion en exceso                                
  Sstor[i] <- min(dexc[i],hstor)         #almacenamiento de depresion                                    
  runoff[i] <- dexc[i] - Sstor[i]        #escorrentia real                                        
}
dFahr <- dFa*60/dt

par(mfrow=c(2,2),mar=c(4,5,2,3))
plot(t,pcm*10,type="S", ylab = "P (mm)", col="blue", xlab=NA, ylim=c(0,max(pcm*10)))
plot(t,dFahr*10,type="b", ylab = "f (mm/hr)", xlab=NA)
plot(t,Fp,type="b", ylab = "F (cm)")
mtext(side=1,"Tiempo (min)", line=3)
plot(t,runoff*10,type="S", ylab = "Q (mm)", col="blue", ylim=c(0,max(pcm*10)))
mtext(side=1,"Tiempo (min)", line=3)
