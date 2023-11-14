#### Time Series Analysis | November 14, 2023

library(imageRy)
library(terra)

# importing data:
im.list()

EN01 <- im.import("EN_01.png") # shows the levels of Nitrogen (NO2) across Europe in January
EN13 <- im.import("EN_13.png") # amount of Nitrogen (NO2) in March

par(mfrow= c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# seeing the difference between the two months

dif = EN01[[1]]-EN13[[1]] # using the first band of each of these images, so we put [[]]
dev.off()
plot(dif)

# changing the color ramp to see the differences more clearly, pay attention to the colors so everyone is able to interpret them

#palette
cldif <- colorRampPalette(c("blue","white","red")) (100) # red parts mean NO2 was higher in January, blue parts men that NO2 was higher in March
plot(dif, col = cldif)
