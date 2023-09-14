#continuous variables
a=seq(1,15,1)
b=seq(16,30,1)
plot(a,b)

#continuous and factor
fac=factor(c(rep("A", 5), rep("B", 5), rep("C", 5))) #what does this function do?
plot(fac,a)
plot(a~fac)

#line plot
t=seq(1,10,1) # time sequence from 1 to 10
response=c(1,5,4,2,3,9,6,7,8,10)
plot(t, response, type="l") #plot a line plot
plot(response~t, type = "b") #both lines and points
plot(t, response, type="p") #plot just points
plot(t, response, type="h") #Make a histogram-like plot with thin lines
plot(t, response, type="s") #Make stair steps

#bar plot
groups=c(rep("a", 10), rep("b", 5), rep("c", 2))
groups.table=table(groups) #create a frequency table
groups.table
barplot(groups.table)

#plotting from a dataframe
str(iris)
?iris
plot(iris$Sepal.Length, iris$Sepal.Width) #two continuous variables
plot(iris$Species, iris$Sepal.Width) #continuous and factor
plot(iris$Sepal.Width~iris$Sepal.Length) #scatterplot
plot(iris$Sepal.Width~iris$Species) #box plot
plot(Sepal.Width~Sepal.Length, data=iris) #another syntax

#labels
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width")

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", main="Length vs. width of sepals in Iris", las=1)
#las= makes the values horizontal on the vertical axis

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", main="Length vs. width of sepals in Iris", las=1, xlim=c(0,10), ylim=c(0,5))
#xlim and ylim change the ranges

#types of points
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=4)

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=1, cex=3)
#cex changes the sizes of points

#colors
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col=4)
#1-8 numerical values representing colors
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col="red")
#lots of named colors
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col="#00FF00")
#hexadecimal colors
my.colors=rainbow(12) #set up color palette of rainbow colors with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each with different colors
#rainbow
my.colors=topo.colors(12) #set up color palette of topo colors with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each with different colors
#gradient
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=1, cex=3, col=rgb(1, 0, 0, 0.5))

#setting up plotting region using par function and mfrow argument
par(mfrow=c(1,2)) #set up a plotting region with one row and two columns:
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col="#00FF00") #first plot
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col="tomato") #secon plot

#plotting data by factors and using legends
head(iris$Species)
as.numeric(iris$Species) #convert species into numbers.
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=as.numeric(iris$Species))
#assign diferent colors to different species

colorset=rainbow(3) #create a palette of 3 colors
pt.cols=colorset[as.numeric(iris$Species)] #This is now a vector of colors for each point
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
