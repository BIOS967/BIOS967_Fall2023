# Basics of Plots

# The Generic Plot function: plot(), plot(x,y), plot(y~x); R will auto-detect the type of vector (variable) I'm trying to plot.

#Scatterplot with numerical vectors

a=seq(1,15,1)  #continuous variable 1
b=seq(16,30,1) #continuous variable 2
plot(a,b)  #plot TWO CONTINUOUS VARIABLES

# Factor Vector (DISCRETE VARIABLE)
fac=factor(c(rep("A",5), rep("B",5), rep("C",5)))  # a factor
plot(fac,a)
# **R recognizes that we want to plot Factor on x-axis and Continuous Variable on y-axis!**
# So R defaults to a BOXPLOT

# Plotting with FORMULA  "~" SYNTAX
plot(a~fac)
# order of variables is different. "Plot 'a' as a function of 'fac'",
#so the 1st variable shows on the y-axis, and 2nd on the x-axis.


# LINE PLOT with TIMESERIES, by designating plot 'type' inside the plot() fucntion.
t=seq(1,10,1) # TIME SEQUENCE, from 1 to 10
response=c(1,5,4,2,3,9,6,7,8,10) # 10 random numbers
plot(t, response, type = "b") #plot a line plot
##triend to plot type= "1", but given error: invalid plot type '1'.

#Lookup some plot formats using "?plot()"
plot(t, response, type = "p") #plots just points
plot(t, response, type = "h") #Histogram-like plt with thin lines
plot(t, response, type = "s") #Stair-Step plot

plot(t, response, type="1")


