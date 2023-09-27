#5.2.1 Scatterplots and boxplots
a=seq(1,15,1) #continuous variable 1
b=seq(16,30,1) #continous variable 2
plot(a,b) #plot two continuous variables

#creating a fictious factor vector (i.e., discrete variable)
fac=factor(c(rep("A", 5), rep("B", 5), rep("C", 5))) #a factor
plot(fac, a) #plot factor on x-axis and continuous variable on y-axis

#formula syntax
plot(a~fac) #formula syntax using "~"

#5.2.2 Line plots
t = seq(1, 10, 1) #time sequence, from 1 to 10
response = c(1, 5, 4, 2, 3, 9, 6, 7, 8, 10) #10 random numbers
plot(t, response, type = "l") #plot a line plot

#same figure with both lines and points
plot(t, response, type="b") #plot a line plot

#line plots with a few other formats
plot(t, response, type="p") #just points, no line
plot(t, response, type="h") #horizontal lines
plot(t, response, type="s") #continous line/bargraph-looking thing

#Bar Plots
groups=c(rep("a", 10), rep("b", 5), rep("c", 2))
groups.table=table(groups) #create a frequency table
groups.table #look at it
barplot(groups.table) #plot it

#the iris dataset has both continuous and discrete variables
iris #see all the data
str(iris) #see the structure of the iris dataset
?iris #learn morre about the dataset

plot(iris$Sepal.Length, iris$Sepal.Width) #plotting two continuous factors against each other
plot(iris$Species, iris$Sepal.Width) #plotting a continuous variable (sepal length) against a factor (iris species)

#formula syntax to do the same thing as above
plot(iris$Sepal.Width~iris$Sepal.Length)
plot(iris$Sepal.Width~iris$Species)
#simplifying the code a bit:
plot(Sepal.Width~Sepal.Length, data=iris)

#5.4.1 Axis labells and plot title
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width")
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", main="Length vs width of sepals in Iris", las=1)

#Specifying the types of points you want
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, cex=1, col=4)

#Creating a color palette
my.colors=rainbow(12) #set up color palette of rainbow colors with n=12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each with different colors

#Using the rgb() to produce different colors
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=1, cex=3, col=rgb(1,0,0,0.5))

#Setting up the plotting region using par()
par(mfrow=c(1,2)) #set up a plotting region with one row and two columns
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col="#00FF00") #first plot
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col="tomato") #second plot

#Plotting data by factors and using legends
as.numeric(iris$Species)

#Assigning different colors to dots for different species
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=as.numeric(iris$Species))

#Adding a legend to the figure
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)

