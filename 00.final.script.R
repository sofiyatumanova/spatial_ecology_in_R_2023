# Final script including all the different scripts during lectures

# Summary:
# 01 Beginning
# 02.1 Population Density
# 02.2 Population Distribution
# 03.1 Communities Multivariate Analysis
# 03.2 Communities Overlap
# 04 Remote Sensing Visualization
# 05 Spectral Indices
# 06 Time Series
# 07 External Data Import
# 08 Copernicus Data 
# 09 Classification
# 10 Variability
# 11 Principal Component Analysis



#---------------------
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



#-----------------------
# 02.1 Population Density

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
elevation <- bei.extra$elev       # we assign the elevation dataset to an object called elevation
plot(elevation)                   # now we can just plot the object elevation
      # second method to select individual elements of a dataset
elevation2 <- bei.extra[[1]]      # you use double square brackets and inside just put the number of the element that you want to select [[1]]
plot(elevation2)



##
#10/10/2023 Density Maps

      # passing from points tp continuous surface
densitymap <- density(bei)
densitymap                        # we are dealing with PIXELS now instead of points
plot(densitymap)                  # gives us a continuous surface
points(bei, cex = .2)             # this function will allow us to add the tree points on top of the continuous density map
                                  # !! avoid using maps with blue, green, and red combo because color blind people see it as the same

      # making a different color ramp
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100) # 100 is the gradient (how many color shades we use to pass from one color to another
                                                                   # the higher the number, the smoother the transition looks)
plot(densitymap, col = cl) # the function col will allow us to add our color ramp tp the plot

      # if we search R colors on the internet we can see all the colors that we can use in R
cl <- colorRampPalette(c("cornsilk3", "aquamarine3", "blue2", "blue4"))(100) #another color ramp with colors available in r
      # verdis webpage that can show which colors are good to use for maps (NEVER USE RAINBOW PALETTE)
    
plot(bei.extra) #additional 2 variables, contains the elevation(elev)), and the gradient(grad)

elev <- bei.extra[[1]] # plotting just the 1st element: elevation(elev)
      # Another way to select elevation: bei.extra$elev   plot(bei.extra$elev)
plot(elev)


      # multiframe
par(mfrow = c(1,2)) # builds a multiframe with 2 empty slots one on the left and one on the right
plot(densitymap)
plot(elev)          # now we have the density map on the left and the elevation on the right size in the same window

      # in case we want 2 rows and 1 column we can switch the order
par(mfrow = c(2,1)) # builds a multiframe with 2 empty slots one on the top and one on the bottom ( 2 rows, 1 column)
plot(densitymap)
plot(elev)

      # building a multiframe with 3 plots side by side, the trees (bei) on the left, the density map in the middle, and the elevation on the right
par(mfrow = c(1,3)) 
plot(bei)
plot(densitymap)
plot(elev)



#-----------------------------
# 02.2 Population Distribution

# October 10 2023

### Why populations disperse over the landscape in a certain manner?
#check OSGea website

# install.pachakges("sdm")
# install.packages("rgdal", dependencies = T)

library(sdm)       # library function does not need quotes because we are already inside R
library(terra)     # terra package deals with spatial data in R
library(rgdal)

      # system file function in R which allows you to search for a file in a package that you installed

      # external is a folder in the sdm package and species.shp is another shape file inside the external folder
file <- system.file("external/species.shp", package="sdm") 

rana <- vect(file) # function vect creates a vector from the shape file by using coordinates of the points
rana               # rana is just the genus name of the frog species we are working with
rana$Occurrence    # sequences of 0 1 shows whether the organisms is present or not, not how many of the species are present

plot(rana)

# Selecting presences
pres <- rana[rana$Occurrence == 1,]  # what's the reason behind , space
pres
plot(pres)

# excersise: select absence and call them abse
abse <- rana[rana$Occurrence == 0,]  # we need to use the comma to close the query cause we are using sql
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
elev`                 # to see the path
elevmap <- rast(elev) # from the terra package
plot(elevmap)
points(pres, cex =.5) # this function will allow us to plot the occurrences (presence) on top of the raster
                      # from the graph we can see that the rana frog does not have many occurrences at very low, and very high elevations


# Temperature Predictor : allows us to plot a termperature raster with the presence points on top
temp <- system.file("external/temperature.asc", package="sdm") # evelation file is a raster (ASCII)
temp                  # to see the path
tempmap <- rast(temp) # from the terra package
plot(tempmap)
points(pres, cex =.5)
                      # from the graph we can see that the rana frog prefers higher temperatures


# Vegetation Cover 
veg <- system.file("external/vegetation.asc", package="sdm") # evelation file is a raster (ASCII)
veg                   # to see the path
vegmap <- rast(veg)   # from the terra package
plot(vegmap)
points(pres, cex =.5)


# Precipitatiom
prec <- system.file("external/precipitation.asc", package="sdm") # evelation file is a raster (ASCII)
prec                  # to see the path
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



#-------------------------------
# 03.1 Communities Multivariate Analysis

# October 19 2023

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



#----------------------------
# 03.2 Communities Overlap

# October 19 2023

## relation among species in time

install.packages("overlap")
library(overlap)

# the  dataset is called "kerinci"
data(kerinci)
head(kerinci)
summary(kerinci)

# selecting the first species
tiger <- kerinci[kerinci$Sps=="tiger",]  # the way to select tiger species from the whole dataset using SQL
tiger


# tiger
# The unit of time is the day, so values range from 0 to 1. - duccio rocchini
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan), - duccio rocchini
# so this speeds up simulations. The conversion is straightforward: kerinci$Time * 2 * pi - duccio rocchini
kerinci$timeRad <- kerinci$Time * 2 * pi   #adding a new column where we have this calculation (assigning the calculation to a new object)
head(kerinci)

tiger <- kerinci[kerinci$Sps=="tiger",] # we want to overwrite the old dataset, with the new dataset containing the new column timRad that we just made
tiger

# plotting the time within the tiger dataset
timetig <- tiger$timeRad # creating a new variable
densityPlot(timetig, rug = TRUE) # new function "densityPlot", rug is used to just smooth the lines
                                 # from the plot we see the density of the tigers in time (how many times we have seen the tiger at a certain part of the day)

# excersise : select only the data on the monkeys (macaque)
macaque <- kerinci[kerinci$Sps=="macaque",]

timemac <- macaque$timeRad # creating a new variable
densityPlot(timemac, rug = TRUE)

# we want to see the density of the tiger in time and the density of the macaque in time together to see the overlap
# overlap
overlapPlot(timetig, timemac) # we can see a moment during the day in which we can find the tiger and the macaque together
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')    # labeling the graphs



#-----------------------------
# 04 Remote Sensing Visualization

# November 2 2023

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



#-----------------------------
# 05 Spectral Indices

# November 7 2023 

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



#----------------------------
# 06 Time Series

# November 14 2023

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



#----------------------------
# 07 External Data Import

# November 16 2023

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



#-----------------------------
# 08 Copernicus Data 

# November 28 2023

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



#---------------------
# 09 Classification

# December 7 2023 

# Procedure for Classifying Remote Sensing Data and estimate the amount of change in different classes

library(imagery) # in the imagery package there is a function to list all the files "im.list()"
library(terra)

# listing all the files
im.list()
# there is a file related to the sun "Solar_Orbiter...."

# importing the first image of the sun
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # there is a direct plot of the raster in RGB, we can see the gases of the sun, with 3 levels of energy based on the colors

# classifying the gases with the "im.classify()" function
sunclass <- im.classify(sun, num_clusters = 3)
plot(sunclass) # where the sun gas color is the lighest, thats where it has the most energy

im.list()
# importing the Mato Grosso images
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")                     
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# classifying the image 1992
m1992class <- im.classify(m1992, num_cluster=2)
plot(m1992class) # classes: bare soil = 1 , forests = 2

# classifying the image 2006
m2006class <- im.classify(m2006, num_cluster=2)
plot(m2006class) # classes: bare soil = 1, forests = 2

# plotting them together
par(mfrow = c(1,2))
plot(m1992class[[1]])
plot(m2006class[[1]])

# we want to see the proportion of pixels in each clas, counts how many pixels are in forests, and how many are in bare soil
f1992 <- freq(m1992class)
f1992

# 1992 image land cover percentage:
# If we want to see the percentages, we first have to find the total number of pixels
tot1992 <- ncell(m1992class) # total number of pixels
# percentage
p1992 <- f1992 * 100/ tot1992
p1992
# forest: 83%; human: 17%


# 2006 image land cover percentage:
f2006 <- freq(m2006class)
f2006

# If we want to see the percentages, we first have to find the total number of pixels
tot2006 <- ncell(m2006class) # total number of pixels
# percentage
p2006 <- f2006 * 100/ tot2006
p2006
# forest: 45%; human: 55%

# building the final table
# defining the columns
class <- c("forest", "human")
y1992 <- c(83,17)
y2006 <- c(45,55)
# building the dataframe
tabout <- data.frame(class,y1992,y2006)
tabout

# final table looks like this: 
#   class y1992 y2006
# 1 forest    83    45
# 2  human    17    55

install.packages("ggplot2")
install.packages("patchwork")
library(patchwork)
library(ggplot2)
# final plot
# x is the class, y is the column related to the year
# geom_bar is histograms
# color for filling is white
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p2

p1 + p2 # to visualize the tables together

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2



#-------------------------------
# 10 Variability

# December 19 2023

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
viridisc <- colorRampPalette(viridis(7))(255) # 7 colors and 255 values
plot(sd3, col=viridisc)                       # we see in the green where the geology is very complex and there is a lot of changes, the variability is high

# Exercise: calculate variability in a 7x7 moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7)
viridisc <- colorRampPalette(viridis(7))(255) # 7 colors and 255 values
plot(sd7, col=viridisc)                       # we see in the green where the geology is very complex and there is a lot of changes, the variability is high

# Exercise: plot via par(mfrow() the 3x3 and the 7x7 standard deviation
par(mfrow=c(1,2))
plot(sd3, col=viridisc) # we see a very local calculation, the variability of the landscape in the NIR shows subtle differences
plot(sd7, col=viridisc) # if we enlarge the moving window to 49 pixels we see an even higher variability

# original image plus  the sd of 7 x 7
par(mfrow=c(1,2))
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)  # we see where the terrain changes from snow (white) to bare soil (pink) we see that the variability graph is high in that area
                         # in other words on the color palette we see an area of bright green or yellow



#------------------------------
# 11 Principal Component Analysis

# December 21 2023

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















