### Standard Drought Index
### https://github.com/hydrocodes
library(drought)
library(ggplot2)
data <- read.csv("https://raw.githubusercontent.com/hydrocodes/Varios/master/33_Qm.csv", header=F)
sdi <- SDI(data$V1, ts = 6, dist = "EmpGrin") # enter ts in months
View(sdi$SDI)
sdi_v <- as.vector(t(sdi$SDI))
idx <- seq(as.Date('1981-01-01'),as.Date('2022-12-31'), by = "month")
df <- data.frame(Date=idx,SSI=sdi_v) 
ggplot(df, aes(x = Date, y = SSI, fill = SSI >=0)) +
  geom_col(position = "identity")+
  scale_fill_manual(values = c("red", "blue"), guide = "none")+
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=12),
        plot.title=element_text(size=14))
