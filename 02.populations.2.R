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



