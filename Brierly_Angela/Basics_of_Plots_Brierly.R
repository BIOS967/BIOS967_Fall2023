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

#TYPO on MODULE ###5.2.2 -->It is an "l" not a "1"!
plot(t, response, type = "l") #line plot

#Lookup plot formats with "?plot()"
plot(t, response, type = "p") #plots just points
plot(t, response, type = "h") #Histogram-like plot with thin lines
plot(t, response, type = "s") #Stair-Step plot


## BAR PLOTS

groups=c(rep("a",10), rep("b", 5), rep("c", 2))
groups.table=table(groups)  #create a FREQUENCY TABLE
groups.table  #Look at the FREQUENCY TABLE
barplot(groups.table) #plot the Frequency Table



##PLOTTING FROM A DATAFRAME
iris
str(iris)  #see the structure of the iris dataset
?iris  #Learn more about the dataset
plot(iris$Sepal.Length, iris$Sepal.Width) #SCATTERPLOT: CONTINUOUS x CONTINUOUS
plot(iris$Sepal.Width~iris$Sepal.Length) #SCATTERPLOT: CONTINUOUS ~ CONTINUOUS with "formula syntax"
plot(iris$Species, iris$Sepal.Width)  #BOXPLOT: FACTOR (species) x CONTINUOUS(sepal length)
plot(iris$Petal.Width~iris$Species)  #BOXPLOT: CONTINUOUS(sepal length) ~ FACTOR (species)

#Make it EASY: Use "syntax format" like this:
plot(Sepal.Width~Sepal.Length, data = iris)


##FORMATTING THE PLOT