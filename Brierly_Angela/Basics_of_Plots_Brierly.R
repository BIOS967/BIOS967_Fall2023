# Basics of Plots

# The Generic Plot function: plot(), plot(x,y), plot(y~x); R will auto-detect the type of vector (variable) I'm trying to plot.

#Scatterplot with numerical vectors

a=seq(1,15,1)  #continuous variable 1
b=seq(16,30,1) #continuous variable 2
plot(a,b)  #plot TWO CONTINUOUS VARIABLES

# Factor Vector (DISCRETE VARIABLE)
fac=factor(c(rep("A",5), rep("B",5), rep("C",5)))  # a factor
plot(fac,a)
# **R recognizes we want to plot Factor on x-axis and Continuous Variable on y-axis!**
# So R defaults to BOXPLOT

# Plotting with FORMULA  "~" SYNTAX
plot(a~fac)
# order of variables is different. "Plot 'a' as function of 'fac'",
#so 1st variable shows on y-axis, and 2nd on x-axis.


# LINE PLOT with TIMESERIES, by designating plot 'type' inside the plot() fucntion.
t=seq(1,10,1) # TIME SEQUENCE, from 1 to 10
response=c(1,5,4,2,3,9,6,7,8,10) # 10 random numbers
plot(t, response, type = "b") #plot a line plot

#TYPO on module ###5.2.2 -->It is an "l" not a "1"!
plot(t, response, type = "l") #line plot

#Lookup plot formats with "?plot()"
plot(t, response, type = "p") #plots points
plot(t, response, type = "h") #Histogram-like plot with thin lines
plot(t, response, type = "s") #Stair-Step plot


## BAR PLOTS

groups=c(rep("a",10), rep("b", 5), rep("c", 2))
groups.table=table(groups)  #create a FREQUENCY TABLE
groups.table  #Look at FREQUENCY TABLE
barplot(groups.table) #plot the Frequency Table



##PLOTTING FROM A DATAFRAME
iris
str(iris)  #see structure of dataset
?iris  #Learn more about dataset
plot(iris$Sepal.Length, iris$Sepal.Width) #SCATTERPLOT: CONTINUOUS x CONTINUOUS
plot(iris$Sepal.Width~iris$Sepal.Length) #SCATTERPLOT: CONTINUOUS ~ CONTINUOUS with "formula syntax"
plot(iris$Species, iris$Sepal.Width)  #BOXPLOT: FACTOR (species) x CONTINUOUS(sepal length)
plot(iris$Petal.Width~iris$Species)  #BOXPLOT: CONTINUOUS(sepal length) ~ FACTOR (species)

#Make it EASY: Use "syntax format" like this:
plot(Sepal.Width~Sepal.Length, data = iris)




##FORMATTING THE PLOT

# LABEL THE AXES: xlab"x-axis label" and ylab="y-axis label"
plot(Sepal.Width~Sepal.Length, data = iris, xlab="Sepal Length", ylab = "Sepal Width")
# ADD TITLE: main="Title"
# Re-orient Y-axis to be HORIZONTAL: las=1
plot(Sepal.Width~Sepal.Length, data = iris, xlab="Sepal Length", ylab = "Sepal Width", main= "Length vs. Width of sepals in Iris", las=1)
# CHANGE AXIS RANGE: xlim=c(,) and ylim=c(,) with (lower limit,upper limit).
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", main="Length vs. width of sepals in Iris", las=1, xlim=c(0,10), ylim=c(0,5))
# Choose POINT TYPE: pch=#  there is a directory using numbers 1-25
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=4)
# Change POINT SIZE: cex=#
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=1, cex=3)



##COLORS!!!

# col= inside the plot() function. This argument can take many different types of inputs:
# NUMERICAL VALUES from 1:8, (1=black, 2=red, 3=grn, 4=blu, 5=aqua, 6=magent, 7=ylow, 8=gray)
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col=4)
# NAMES OF COLORS (you need to know the specific name that R recognizes: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col="red")
# HEXIDECIMAL RGB color specification (http://www.color-hex.com/)
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col="#00FF00")
# create a COLOR PALETTE: rainbow(#), heat.colors(), terrain.colors(), topo.colors(), cm.colors()
# more palettes in "RColorBrewer" package!
my.colors=rainbow(12) #set up a rainbow color palette with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each a different color

my.colors=topo.colors(12) #set up a topo color palette with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each a different color

my.colors=heat.colors(12) #set up a heat color palette with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each a different color

my.colors=terrain.colors(12) #set up a terrain color palette with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each a different color

my.colors=cm.colors(12) #set up a cm color palette with n = 12
plot(1:12, pch=19, cex=2, col=my.colors) #plot dots, each a different color

# GRADIENTS and NEW COLORS: rgb() function
# create own color with intensities of colors: rgb(red,green,blue,transparency)
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=16, cex=3, col=rgb(1, 0, 0, 0.5))  #Module 5.4, change point type to pch=16


# PLOT REGION: par()    note--must be used BEFORE the plot()!!
#  mfrow=  used inside the par() function
par(mfrow=c(1,2)) #set up plot region with ONE ROW and TWO COLUMNS:
#first plot
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",  las=1, pch=19, col="#00FF00")
#second plot
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col="tomato")

## HELP/LEARN about plot() and par():  ?par



##Using 2+ TYPES OF POINT/SYMBOL/SPECIES
head(iris$Species) #recall that head() shows the first three elements of a vector
# CONVERT Species name INTO COLORS:
# 1st, convert species to Numbers
as.numeric(iris$Species)
# 2nd, assign different colors to dots for different species using: "col=as.numeric(factor$factor)
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=as.numeric(iris$Species))
# oops! fix the one row, two columns I'd set the plotting region to last exercise!
par(mfrow=c(1,1))


##CREATE OWN 3-COLOR PALETTE
# create a palette of 3 colors
colorset=rainbow(3)
# Make a VECTOR of colors for each point
pt.cols=colorset[as.numeric(iris$Species)]
# Now, you can use this new set of colors, 'pt.cols', for the plot.
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)


##ADD A LEGEND,  legend(x-coordiante,y-coordinate) with more info at '?legend'
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
legend("bottomright", legend=c("I. setosa", "I. versicolor", "I. virginica"), pch=19, col=colorset)
# FINE-TUNE LEGEND LOCATION using x-y coordinates of Top-Left-Corner of Legend

##LEGEND OUTSIDE of PLOT
# To allow a PLOT OUTSIDE OF AXES: (xpd=TRUE)
# To EXPAND MARGINS using 'mar=' (see '?par' for details), and set using x-y coords.
par(mar=c(4,4,1,7), xpd=TRUE) # To make the MARGIN WIDER & ALLOW to PLOT OUTSIDE BOX
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
legend(8.2, 3, legend=c("I. setosa", "I. versicolor", "I. virginica"), pch=19, col=colorset)





