# Oct 5th 2023

# Functions and Loops

# apply() sapply() lapply() etc

#example function
mult.2=function(x) x*2
mult.2(5)

#we can use sapply to apply the function to a set of numbers

#take intigers from 1--> 5 multiplying each by 2
sapply(1:5, mult.2)


sapply(1:5, function(x) x*2)


#difference between sapply and lappy is really just the output format!
#s stands for simplified apply
#l stands for list apply

lapply(1:5, mult.2)



#Use sapply to apply a function that generates more than a vector

v=c(1,2,3)
sapply(1:5, function(x) x*v) #output is a matrix!

lapply(1:5, function(x) x*v) #output is a list of each column



#use sapply and lapply to run linear models on multiple datasets

iris

iris.split=split(iris, iris$Species)
iris.split


spp.mods =lapply(iris.split,function(x) lm(Petal.Length~Sepal.Length,data=x))
spp.mods
summary(spp.mods[[1]])
summary(spp.mods[[2]])
summary(spp.mods[[3]])

species.mods.summary=lapply(spp.mods,function(x)summary(x))



#lets get slope from the lm
str(summary(spp.mods[[1]]))
species.mods.summary[[1]]$coefficients

species.mods.summary[[1]]$coefficients[2,1]

slopes = sapply(species.mods.summary,function(x) x$coefficients[2,1])
slopes


#lets visualize the relationships between petal and sepal length for each species

library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point()+
  geom_smooth(method = "lm")+
  facet_wrap(~Species)
