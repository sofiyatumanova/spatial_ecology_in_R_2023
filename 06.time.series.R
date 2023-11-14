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

### New example : temperature in Greenland

g2000 <- im.import("greenland.2000.tif") # greenland in 2000
# changing the color ramp
clg <- colorRampPalette(c("black","blue","white","red")) (100)
plot(g2000, col= clg)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col= clg)

# plotting them together
par(mfrow= c(1,2))
plot(g2000, col= clg) # wider black part means more ice extent in greenland
plot(g2015, col= clg) # we see that in 2015 the ice extent is much smaller

# stacking the images together
stackg <- c(g2000, g2005, g2010, g2015)
plot(stack, col = clg)

# exersice : make difference between teh first and final elements of the stack
gdif <- g2000 - g2015
dev.off
plot(gdif)

# another way
gdif <- stackg[[1]] - stackg[[4]]
plot(gdif, col = clg)

# exercise : make an RGB plot using different years
im.plotRGB(stackg, r = 1, g = 2, b = 3) # using the different elements of a stack to create the RGB
