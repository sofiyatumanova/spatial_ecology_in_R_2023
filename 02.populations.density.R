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
