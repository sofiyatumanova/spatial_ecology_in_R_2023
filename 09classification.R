# Classification | December 7 2023 

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


