### Application of GR1A model 
### https://github.com/hydrocodes
library(airGRteaching)
BasinObs <- read.csv(file.choose(),header=TRUE, check.names = F, stringsAsFactors = F) #almacenar los datos csv en BasinObs
BasinObs$DatesR <- as.POSIXlt(BasinObs$DatesR, format="%Y-%m-%d", tz = "UTC", origin = "1971-01-01")
head(BasinObs)
str(BasinObs)
PREP <- PrepGR(ObsDF = BasinObs, HydroModel = "GR1A", CemaNeige = FALSE)
CAL <- CalGR(PrepGR = PREP, CalCrit = "KGE2",
             WupPer = NULL, CalPer = c("1971-01-01", "1990-01-01"))
SIM <- SimGR(PrepGR = PREP, CalGR = CAL, EffCrit = "KGE2",
             WupPer = NULL, SimPer = c("1991-01-01", "2005-01-01"))
head(as.data.frame(PREP))
head(as.data.frame(CAL))
head(as.data.frame(SIM))
plot(PREP, main = "Observation")
plot(CAL, which = "perf")
plot(CAL, which = "iter")
plot(CAL, which = "ts", main = "Calibration")
plot(SIM)
dyplot(SIM, main = "Simulation")
