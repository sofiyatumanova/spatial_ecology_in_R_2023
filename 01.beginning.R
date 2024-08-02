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



