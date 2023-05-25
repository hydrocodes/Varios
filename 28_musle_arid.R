### Synthetic MUSLE Sedimentograph for a given direct hydrograph in arid zones
### https://github.com/hydrocodes
# Enter direct hydrograph q[m3/s] vs hr[hour]
hydr <- read.table(file.choose(), header=T)
dt <- 1 # time interval in hr
# Enter hydrogeomorphic parameters
A <- 20 # basin area in km2
Fd <- 0.5 # drainage density
LC25 <- 25 # contour length km at 25% basin altitude range
LC50 <- 31 # contour length km at 50% basin altitude range
LC75 <- 35 # contour length km at 75% basin altitude range
Z <- 0.5 # altitude range in km
# Enter MUSLE parameters
K <- 0.04 # Soil erodibility Factor
C <- 1 # Land cover management Factor
P <- 1 # Conservation practices Factor

# Do not edit
lmd <- 0.5/Fd 
s <- 0.25*Z*(LC25+LC50+LC75)/A
if (s<0.09)
{LS <- (lmd/22.1)^0.3 * (0.065+0.0454*s+0.0065*s^2)
} else {
  LS <- (lmd/22.1)^0.3 * (s/229.1)^1.3
}
Q <- sum(hydr$q)*dt*60*60
qp <- max(hydr$q)
Y <- 11.8*(Q*qp)^0.56 *K*LS*C*P
datemax <- hydr$hr[which.max(hydr$q)]
tsed1 <- seq(0,datemax,dt)
tsed2 <- seq(datemax+dt,max(hydr$hr),dt)
ntsed1 <- length(tsed1)-1
ntsed2 <- length(tsed2)
sed1 <- seq(0,2*Y/max(hydr$hr),(2*Y/max(hydr$hr))/ntsed1)
sed2 <- seq(2*Y/max(hydr$hr)-(2*Y/max(hydr$hr))/ntsed2,0,-(2*Y/max(hydr$hr))/ntsed2)

# erosion rate plot with a background image
library(png)
plot(c(tsed1,tsed2),c(sed1,sed2), type="l", xlab="Hours",             
     ylab="Erosion rate (Ton/hr)", main="Synthetic MUSLE Sedimentograph")
ima1 <- readPNG("C:/2_Cursos/R_Hidrologia/Tutorial_files/desert4.png")
lim <- par()
rasterImage(ima1, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
grid(col="white")
lines(c(tsed1,tsed2),c(sed1,sed2), type="l", col="yellow", lwd=3, lty=1)
