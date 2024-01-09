# Final script including all the different scripts during lectures

# Summary:
# 01 Beginning
# 02.1 Population Density
# 02.2 Population Distribution
# 03 Communities Multivariate Analysis
# 04 Remote Sensing Visualization
# 05 Spectral Indices
# 06 Time Series

#---------------

# 01 Beginning

# it is important, for the exam that every operation that you comment what you are doing

# R as a calculator
2+3

# Assign to an object
dima <- 2+3 
dima

duccio <- 5+3
duccio

final <- dima * duccio
final

final^2

# array

sophi <- c(10,20,30,50,70) #microplastics 
#functions have parentheses and inside them are arguments

paula <- c(100,500,600,1000,2000) #people

plot(paula,sophi)

plot(paula,sophi,xlab="number of people",ylab="microplastics")

people <- paula
microplastics <- sophi

plot(people, microplastics) 

plot(people,microplastics, pch=19) #pch changes how the point looks like, you can fin this info online
plot(people,microplastics, pch=19, cex=2) #cex is the diameter of the point symbol
plot(people,microplastics, pch=19, cex=2, col="blue") #col is to change the color

#---------------

# 02.1 Population Density

#LESSON 02
# code related to population ecology
# a package is needed for point pattern analysis
# we can download R packages from cran but we need to use quotes to protect R ""
install.packages("spatstat")
# the library function uses the package that we installed, we don't need quotes anymore because we are inside R already
library(spatstat)

# let's use the bei data
# data description:
# https://cran.r-project.org/web/packages/spatstat/index.html

bei

# plotting the data
plot(bei)

# changing dimention of the points with - cex
plot(bei, cex=0.5)
# changing the symbol of points with - pch
plot(bei, cex=0.5, pch =19)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
# the dollar sign $ links only elevation to the dataset not the other element
plot(bei.extra$elev)
elevation <- bei.extra$elev # we assign the elevation dataset to an object called elevation
plot(elevation) # now we can just plot the object elevation
# second method to select individual elements of a dataset
elevation2 <- bei.extra[[1]] # you use double square brackets and inside just put the number of the element that you want to select [[1]]
plot(elevation2)



####
#10/10/2023 Density Maps

## passing from points tp continuous surface
densitymap <- density(bei)
densitymap # we are dealing with PIXELS now instead of points
plot(densitymap) # gives us a continuous surface
points(bei, cex = .2) # this function will allow us to add the tree points on top of the continuous density map
# !! avoid using maps with blue, green, and red combo because color blind people see it as the same

## making a different color ramp
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100) # 100 is the gradient (how many color shades we use to pass from one color to another
                                                                   # the higher the number, the smoother the transition looks)
plot(densitymap, col = cl) # the function col will allow us to add our color ramp tp the plot

# if we search R colors on the internet we can see all the colors that we can use in R
cl <- colorRampPalette(c("cornsilk3", "aquamarine3", "blue2", "blue4"))(100) #another color ramp with colors available in r
# verdis webpage that can show which colors are good to use for maps (NEVER USE RAINBOW PALETTE)

plot(bei.extra) #additional 2 variables, contains the elevation(elev)), and the gradient(grad)

elev <- bei.extra[[1]] # plotting just the 1st element: elevation(elev)
##Another way to select elevation: bei.extra$elev   plot(bei.extra$elev)
plot(elev)


## multiframe
par(mfrow = c(1,2)) # builds a multiframe with 2 empty slots one on the left and one on the right
plot(densitymap)
plot(elev) # now we have the density map on the left and the elevation on the right size in the same window

# in case we want 2 rows and 1 column we can switch the order
par(mfrow = c(2,1)) # builds a multiframe with 2 empty slots one on the top and one on the bottom ( 2 rows, 1 column)
plot(densitymap)
plot(elev)

# building a multiframe with 3 plots side by side, the trees (bei) on the left, the density map in the middle, and the elevation on the right
par(mfrow = c(1,3)) 
plot(bei)
plot(densitymap)
plot(elev)


#---------------

# 02.2 Population Distribution

#### Population Distribution 03 || 10 October 2023
### Why populations disperse over the landscape in a certain manner?
#check OSGea website

# install.pachakges("sdm")
# install.packages("rgdal", dependencies = T)

library(sdm) # library function does not need quotes because we are already inside R
library(terra) #terra package deals with spatial data in R
library(rgdal)

# system file function in R which allows you to search for a file in a package that you installed

file <- system.file("external/species.shp", package="sdm") # external is a folder in the sdm package and species.shp is another shape file inside the external folder

rana <- vect(file) # function vect creates a vector from the shape file by using coordinates of the points
rana # rana is just the genus name of the frog species we are working with
rana$Occurrence # sequences of 0 1 shows whether the organisms is present or not, not how many of the species are present

plot(rana)

# Selecting presences
pres <- rana[rana$Occurrence == 1,]  # what's the reason behind , space
pres
plot(pres)

# excersise: select absence and call them abse
abse <- rana[rana$Occurrence == 0,] # we need to use the comma to close the query cause we are using sql
#abse <- rana[rana$Occurrence != 1,] # another way to select the absences
abse
plot(abse)

# Plot one plot next to the other
par(mfrow = c(1,2)) # builds a multiframe with 2 empty slots one on the left and one on the right
plot(pres, cex = 0.5)
plot(abse, cex = 0.5)

# Excersise
# first we close the multiframe with the function dev.off() 
dev.off()
# Plotting presence and absence occurrences with two different colors on the SAME plot
plot(pres, col ="dark blue")    # in this case the two occurences pres and abse are on the same plot but in different colors
points(abse, col = "light blue")

# Elevation Predictor : allows us to plot an elevation raster with the presence points on top
elev <- system.file("external/elevation.asc", package="sdm") # evelation file is a raster (ASCII)
elev # to see the path
elevmap <- rast(elev) # from the terra package
plot(elevmap)
points(pres, cex =.5) # this function will allow us to plot the occurrences (presence) on top of the raster
# from the graph we can see that the rana frog does not have many occurrences at very low, and very high elevations

# Temperature Predictor : allows us to plot a termperature raster with the presence points on top
temp <- system.file("external/temperature.asc", package="sdm") # evelation file is a raster (ASCII)
temp # to see the path
tempmap <- rast(temp) # from the terra package
plot(tempmap)
points(pres, cex =.5)
# from the graph we can see that the rana frog prefers higher temperatures

# Vegetation Cover 
veg <- system.file("external/vegetation.asc", package="sdm") # evelation file is a raster (ASCII)
veg # to see the path
vegmap <- rast(veg) # from the terra package
plot(vegmap)
points(pres, cex =.5)

# Precipitatiom
prec <- system.file("external/precipitation.asc", package="sdm") # evelation file is a raster (ASCII)
prec # to see the path
precmap <- rast(prec) # from the terra package
plot(precmap)
points(pres, cex =.5)
# we can see from the graph that the rana frog prefers areas with higher precipitation

## Plotting everything together on a multiframe
par(mfrow = c(2,2))

# elevation
plot(elevmap)
points(pres, cex =.5)

# temperature
plot(tempmap)
points(pres, cex =.5)

# vegetation
plot(vegmap)
points(pres, cex =.5)

# precipitation
plot(precmap)
points(pres, cex =.5)


#---------------

# 03 Communities Multivariate Analysis

#### Lesson 03 Communities Multivariate Analysis | October 19 2023

# orination methods = multivariate analysis
install.packages("vegan")
library(vegan)

data(dune) # dataset is called "dune"
head(dune) # this function allows us to preview only the first 6 rows of the dataset

ord <- decorana(dune) 

# length of axis
ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888

# total lengths of axis
total = ldc1 + ldc2 + ldc3 + ldc4

# percentages of the lengths of axis
pldc1 = ldc1 *100 / total
pldc2 = ldc2 *100 / total
pldc3 = ldc3 *100 / total
pldc4 = ldc4 *100 / total

# seeing the percentage of the axis
pldc1
pldc2

pldc1 + pldc2 #we see that these two percentages cover about 71% of the total

plot(ord) # we can see from the plot that some species like to stay together (close location)

#---------------

# 04 Remote Sensing Visualization

###  November 2 2023
## Code to visualize remote sensing data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)
library(terra)

# simple operation
10 + 10

# this is an object
duccio <- 10 + 10
duccio

# objects
adam <- 5 + 3
duccio + adam

# arrays
diameter <- c(100, 10, 50, 20, 15)
iron <- c(10, 1000, 20, 700, 900)

# a function
plot(iron, diameter) # iron and diameter are arguments!
plot(iron, diameter, pch=19) # https://www.google.com/search?client=ubuntu-sn&hs=Ssn&sca_esv=564367827&channel=fs&sxsrf=AB5stBhOTkEGpHkLRMvuoUQuTCdqYjKtEw:1694448980289&q=pch+in+R&tbm=isch&source=lnms&sa=X&ved=2ahUKEwjzmr2s-qKBAxUOGuwKHUdlAnMQ0pQJegQIDBAB&biw=960&bih=484&dpr=2#imgrc=lUw3nrgRKV8ynM
plot(iron, diameter, pch=19, cex=2)
plot(iron, diameter, pch=19, cex=2, col="red")

# do you want info about functions?
?plot()

# now we will use a package
        # gives us a list of all the data
im.list()    

        # importing the bands
b2 <- im.import("sentinel.dolomites.b2.tif")

        # import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=cl)

        # import the red band from Sentinel-2 (band 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

        # import the NIR band from Sentinel-2 (band 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

        # multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

        # stack images | you can but the bands as elements of an array that defines an object
stacksent <- c(b2, b3, b4, b8)
stacksent

dev.off() # it closes devices
plot(stacksent, col=cl)
        # plotting the 4th element of the stack (nir band) only 
plot(stacksent[[4]], col=cl)


# Exercise: plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)


# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1) # true color composite
im.plotRGB(stacksent, r=4, g=3, b=2)
im.plotRGB(stacksent, r=3, g=4, b=2)
im.plotRGB(stacksent, r=3, g=2, b=4)


pairs(stacksent)

#---------------

# 05 Spectral Indices

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

# NDVI : Normalized Difference Vegetation Index | always ranges from -1 to 1

ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])  # (NIR-R)/(NIR+R)
plot(ndvi1992, col = cl) # the new range is exactly -1 to 1, therefore it can be compared with other images unlike DVI which has a different range
# or ndvi1992 = (m1992[[1]] - m1992[[2]])/ (m1992[[1]] + m1992[[2]])

# NDVI for 2006 image
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])  # (NIR-R)/(NIR+R)
plot(ndvi2006, col = cl)

par(mfrow=c(1,2)) # one row and two columns
plot(ndvi1992, col= cl)
plot(m2006, col = cl)


# speeding up the calculation
ndvi2006a <- im.ndvi(m2006, 1, 2) # function to calculate NDVI automatically is "im.ndvi" | 1 = NIR band , 2 = RED band
plot(ndvi2006a, col = cl)

#---------------

# 06 Time Series

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
