### Triangulo textural de suelo
### Julien Moeys et al (2022)
library(soiltexture)
data <- data.frame(sand=15, silt=52, clay=33)
TT.plot(class.sys = "USDA.TT", tri.data = data,
        css.names = c("clay", "silt", "sand"),
        main = "Triangulo textural del suelo",
        col = "red" ,
        cex.axis = 0.8,
        cex.lab = 0.8)
