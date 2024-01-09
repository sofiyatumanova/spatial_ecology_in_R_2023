# Final script including all the different scripts during lectures

# Summary:
# 01 Beginning
# 02.1 Population Density
# 02.2 Population Distribution
# 03 Communities Multivariate Analysis

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


