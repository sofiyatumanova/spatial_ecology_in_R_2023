# Remote Sensing for Ecosystem Modelling | 24 October 2023 
#This is a script to visualize satellite data
install.packages("devtools")
library(devtools) # packages in R are also called libraries
#open the terra package
library(terra)

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")

install.packages("imageRy")
library(imagery)

# listing the data | gives you the list of all the files that are available in the imageRy package
im.list()
# importing the data image
b2 <- im.import("sentinel.dolomites.b2.tif") #we are importing the band 2 of Sentinel 2 (blue band)
b2 # we see the information available about this band/image



