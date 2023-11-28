### Data From Copernicus | 28 November 2023

library(ncdf4)
library(terra)

# install.packages(" put your package here")

setwd("C:/Users/sofiy/Downloads")

#function to import the data, importing the raster
raster <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")

# there are two elements lets use the first one

plot(raster[[1]])

# change the color palette
cl <- colorRampPalette(c("red","orange","yellow")) (100)

plot(raster[[1]], col = cl)

# we want to crop our image, we need to specify the extent of the image
# defining an extent in space, where you want to crop your element
ext <- c(20, 23, 55, 57) # minlong, maxlong, minlat, maxlat | longitude is the x axis, latitude is the y axis
rastercrop <- crop(raster, ext)
plot(rastercrop[[1]]) # plots just the first element of the cropped raster

#when you download another image, you can crop the second image, based on the extent of the first image by just using the crop function, and the same extent



