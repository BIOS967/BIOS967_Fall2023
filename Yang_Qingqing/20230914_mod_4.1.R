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
#assign different colors to different species

colorset=rainbow(3) #create a palette of 3 colors
pt.cols=colorset[as.numeric(iris$Species)] #This is now a vector of colors for each point
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
#how do you make it not follow the "par" thing from before?

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
legend("bottomright", legend=c("I. setosa", "I. versicolor", "I. virginica"), pch=19, col=colorset)

par(mar=c(4,4,1,7), xpd=TRUE) #make the margin wider and let me plot outside the box
par(mfrow=c(1,1))
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
legend(8.2, 3, legend=c("I. setosa", "I. versicolor", "I. virginica"), pch=19, col=colorset)
# how do I undo par(mfrow=c(1,2))?

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols) #make the same plot without the legend
example.plot=recordPlot() #save the plot as an object called 'example.plot'
#want sepal length and width for each species
#calculate the means
mean.Sepal.length=tapply(iris$Sepal.Length, iris$Species, mean)
mean.Sepal.width=tapply(iris$Sepal.Width, iris$Species, mean)
mean.Sepal.length
mean.Sepal.width

points(x=mean.Sepal.length, y=mean.Sepal.width, pch="x", cex=2) #add an "x" at the mean Sepal length & width for all three species
text(x=mean.Sepal.length, y=mean.Sepal.width, labels=c("setosa", "versicolor", "virginica"), pos=1, offset=0.5) #add text below each of the "x" (pos=1), and how far it should be offset (offset = 0.5)

#two functions for lines: line and abline
#abline can have specified slope and intersept

example.plot
abline(v=mean.Sepal.length, lty=3) #add a vertical dotted lines at the mean sepal length for each species.

example.plot
abline(v=mean.Sepal.length, lty=3, col=colorset) #add vertical lines at the mean Sepal lengths for each species.
abline(h=mean.Sepal.width, lty=3, col=colorset) #add horizontal lines at the mean Sepal widths for each species.

#exporting plots
#can use the interface or
pdf(file="exampleplot.pdf") #open up a pdf 'graphical device'
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols) #draw the plot
dev.off() # close the graphical device
#how do I determine where it saves? It went to the general BIOS967 folder