#Apply function and loops
library(tidyverse)
library(cowplot)

#creating simple function
mult.2 = function(x) x*2
mult.2(12)
mult.2(3)


#use sapply() to apply this function to a set of numbers. It is also known as simplified function
sapply(1:5, mult.2)

#or creat a function withing sapply
sapply(1:5, function(x)x*2)

#lapply will give a list
lapply(1:5, function(x)x*2)

#using sapply to apply function that generate more than just a vector
v = c(1:3)
sapply(1:5, function(x)x*v)
lapply(1:5, function(x)x*v)

#using sapply and lapply to run linear models on multiple data set
iris
iris.split = split(iris, iris$Species)
iris.split
class(iris.split)

spp.mods= lapply(iris.split, function(x) lm(Petal.Length~Sepal.Length, data = x))
spp.mods
summary(spp.mods[[1]])
summary(spp.mods[[2]])
summary(spp.mods[[3]])

#or to do all the models at ones
spp.mods.sum=lapply(spp.mods, function(x)summary(x))
spp.mods.sum

#slop of relationship for each of our model
str(spp.mods.sum[[1]])
spp.mods.sum[[1]]$coefficients
spp.mods.sum[[1]]$coefficients[2,1]

#making the above into a function
slopes=sapply(spp.mods.sum, function(x) x$coefficients[2,1])
slopes

#visualizing relationships between petal length and sepal length for each species
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  geom_point()+
  geom_smooth(method = "lm") +
  facet_wrap(~Species)

m=matrix(1:20, nrow=5, byrow = TRUE)
m
apply(m, 1, sum) # sum rows
apply(m,2,sum) # sum columns

#creating loops
for (i in 1:5) print(i*2)

v=vector(length = 5)
v
for (i in 1:5) v[i]=i*2
v
a=c(8,4,3,1)
for (i in 1:5) v[i]=a[1]*2
v

#matrix
times = 5
m=matrix(nrow = times, ncol = 10)
for(i in 1:times) m[i,]=(1:10)*i
m

#while-loop
j=1
while(j<10) {
  print(j)
  j=j+1
}

j=1
while(j<20) {
  if(j==10) print("10!") else print(j)
  j=j+1
}
