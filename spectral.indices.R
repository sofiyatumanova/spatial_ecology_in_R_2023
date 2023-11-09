### November 7 2023

# vegetation indices

library(imageRy)
library(terra)

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
# bands: 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, r=2, g=1, b=3) # we put the NIR band on the green
im.plotRGB(m1992, r=2, g=3, b=1) # we put the NIR band on the blue, everything that's bare soil will show up as yellow


# import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

# Excersise : build the multiframe with the two images from 1992 and 2006
par(mfrow=c(1,2)) # one row and two columns
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)


dev.off()
plot(m1992[[1]]) # plotting only the first element

# a "bit" is either 0 or 1, it is a binary code
# 2^3 = 8 bit
# 2^4 = 16 bit
# 2^8 = 256   # most images are 8 bit


# DVI = NIR - R
# NIR = element 1
# RED = element 2

# DVI of 1992 is an operation so we use the "=" not the "<-"
dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992) # anything from 0 to 200 should be healthy, below 0 to -200 should be sufferng vegetation
# changing the color
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi1992, col = cl) # everything which is dark red is healthy vegetation, going towards yellow and blue means unhealthy vegetation/ bare soil


# Exercise : calculate dvi of 2006 image
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006)
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi2006, col = cl)

