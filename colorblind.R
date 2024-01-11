# simulating color blind vision

# we need two packages:

library(devtools)
devtools::install_github("clauswilke/colorblindr") # a package that someone developed and we need to install it from GitHub
library(colorblindr)

library(ggplot2)

iris
head(iris)

fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig

cvd_grid(fig)
