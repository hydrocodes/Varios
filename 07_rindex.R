### Monthly runoff index in ungauged basins
### Based on Eq. 8 from Rau et al (2019)
### https://doi.org/10.1002/hyp.13318
### https://github.com/hydrocodes
rm(list=ls())
dev.off()
library(ggplot2)
# Enter a csv monthly database: %b-%y(Date), Precipitation (P) and Potential Evapotranspiration (PET) in mm
data <- read.csv("C:/8_COURSES/R_Hidrologia/Rfiles_base/rindex/data.csv",header=TRUE, check.names = F, stringsAsFactors = F)
# Enter morphometric parameters of the basin
a <-2352   #Area in km2
l <- 88.3  #Main channel lenght in km
p <- 261   #Perimeter in km

rindex <- function(data,a,l,p)
{ X1 <- (a^0.393*l^-4.107*p^4.291)/64.5
  X2 <- log(0.883*a^0.369*l^-0.229*p^-0.168)
  X1o <- X1/2
  X2o <- 30
  phi <- tanh(data$P/X1)
  psi <- tanh(data$PET/X1)
  phio <- tanh(data$P[1]/X1)
  psio <- tanh(data$PET[1]/X1)

  S1 <- c(1:nrow(data))
  S1[1] <- (X1o+X1*phio)/(1+phio*X1o/X1)
  for (i in 2:nrow(data)) {
    S2 <- S1*(1-psi)/(1+psi*(1-S1/X1))
    S <- S2/((1+(S2/X1)^3)^(1/3))
    S1[i] <- (S[i-1]+X1*phi[i])/(1+phi[i]*S[i-1]/X1)
    S2 <- S1*(1-psi)/(1+psi*(1-S1/X1))
    S <- S2/((1+(S2/X1)^3)^(1/3))
  }
  P1 <- c(1:nrow(data))
  P1[1] <- data$P[1]+X1o-S1[1]
  for (i in 2:nrow(data)) {
    P1[i] <- data$P[i]+S[i-1]-S1[i]
    P2 <- S2-S
    P3 <- P1+P2
  }
  R1 <- c(1:nrow(data))
  R1[1] <- P3[1]+X2o
  for (i in 2:nrow(data)) {
    R2 <- R1*X2
    Q <- R2^2/(R2+60)
    R <- R2-Q
    R1[i] <- P3[i] + R[i-1]
    R2 <- R1*X2
    Q <- R2^2/(R2+60)
    R <- R2-Q
  }
  data$Qsim <- Q
  Qmatrix <- t(matrix(Q,12))

  res <- scale(Qmatrix)
  attributes(res)[3:4] <- NULL
  res_vector<-as.vector(t(res))
  data$Date <- as.POSIXct(paste("01", data$Date, sep = "-"), format = "%d-%b-%y")
  data$RIndex <- res_vector
  
  
  # Plotting time series
  theme_set(theme_bw())
  plotrindex <- ggplot(data, aes(x = Date, y = RIndex, fill = RIndex >=0)) +
    geom_col(position = "identity")+
    scale_fill_manual(values = c("red", "blue"), guide = FALSE)+
    theme(axis.text=element_text(size=12),
        axis.title=element_text(size=12),
        plot.title=element_text(size=14))
  return(list(res_vector, Q, plotrindex))
}

rindex(data,a,l,p)

# Writing output file
write.csv(data,"C:/8_COURSES/R_Hidrologia/Rfiles_base/rindex/output.csv")

