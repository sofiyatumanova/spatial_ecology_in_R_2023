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
