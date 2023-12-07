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


