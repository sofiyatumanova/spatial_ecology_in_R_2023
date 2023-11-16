#### External data || 16 November 2023

# always put the packages on top of the working directory
library(terra)
# we set the directory in which we are working with
# we need quotes because we are exiting R and going to the directory
# set the \ to / 
# find the directory where you saved your data / downloaded your data
setwd("E:/Unibo/1Year.1Sem/Spatial Ecology in R")

# function to upload the data "rast"
# we put the name of the image we downloaded inside the function
naja <- rast("najafiraq_etm_2003140_lrg.jpg")

# we plot the image using a different function "plotRGB"
plotRGB(naja, r=1, g=2, b=3)
# second image from the same site and open it in R , call is najaaug because its august
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

# plot the two images together
par(mfrow = c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)
# exam you can compare two images by plotting one element from each image

# we will calculate the difference between naja and najaaug
najadif= naja[[1]] - najaaug[[1]]
cl <- colorRampPalette(c("brown","grey","orange")) (100)
plot(najadif, col = cl) # we get a raster with the differences between them


thailand <- rast("thailand_smoke.jpg")
plotRGB(thailand , 1,2,3)







