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



