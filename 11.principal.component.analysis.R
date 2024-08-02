#### Principal Component Analysis | December 21 2023

library(imageRy)
library(viridis)
library(terra)

im.list()

sent <- im.import("sentinel.png")
pairs(sent)   # gives us a lot of information, for example the correlation between the bands

# Principal Component Analysis
sent.pca <- im.pca2(sent) 
  # the first component represents the most variability, in this case PC1 represents 77.26 percent of variability
  # the other components have less and less variability

# We can also isolat ethe first component
sentpc <- im.pca2(sent)
pc1 <- sentpc$PC1

viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col = viridisc)

# calculating the standard deviation ontop of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun = sd)
plot(pc1sd3, col = viridisc)

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun = sd)
plot(pc1sd7, col = viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent,2,1,3) # sentinel original data
# sd from the variability script Lesson 10
plot(sd3, col= viridisc)
plot(sd7, col= viridisc)
plot(pc1, col = viridisc)
plot(pc1sd3, col = viridisc)
plot(pc1sd7, col = viridisc)

# We want to stack all the new layers sd3, sd7, pc1sd3, pc1sd7 together
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7") # this way we can see the name of each band on top of it
plot(sdstack, col = viridisc)  

# the function focal can also be used for other statistics, like the average for example





