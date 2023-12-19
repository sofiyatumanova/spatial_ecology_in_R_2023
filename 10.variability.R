### Variability | 19 December 2023
# measurement of RS based variability

library(imageRy)
library(terra)
library(viridis)

# Importing Data
im.list()
sent <- im.import("sentinel.png")

# Plotting data
# band 1 = NIR
# band 2 = Red
# band 3 = Green

im.plotRGB(sent, r=1, g=2, b=3)

# Chnaging visualization
im.plotRGB(sent, r=2, g=1, b=3)

# Calculating variability

nir <- sent[[1]] # nir is just the first element of sent
plot(nir) # green part is vegetation, orange part is bear soil, range from 0 to 255 means it is an 8-bit image

# moving window - we will use the moving window to calculate the standard deviation of 3 by 3 cells (9 cells)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # the variable/band that we are using is NIR, then we have to describe the dimentions of the moving window with the matrix function
                                             # the moving window is composed of 9 pixels, and distributed 3 by 3
                                             # the function (fun) is the standard deviation (sd)
plot(sd3)
# we need to change the legend so that we can see the difference clearly
viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)  # we see in the green where the geology is very complex and there is a lot of changes, the variability is high


