#Plotting continuous variables
a=seq(1,15,1)
b=seq(16,30,1)
plot(a,b)

#Plot discrete variables
fac=factor(c(rep("A",5),rep("B",5),rep("C",5)))
#plot factor on x-axis and continuous variable on y axis
plot(fac,a)
#formula syntax using "~"
plot(a~fac)


#lineplot








