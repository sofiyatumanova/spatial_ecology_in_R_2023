#### Overlap | October 19 2023
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




