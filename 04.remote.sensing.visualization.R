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

