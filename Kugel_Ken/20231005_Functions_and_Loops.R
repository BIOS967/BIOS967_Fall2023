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



#For Loops #################################################################################
for(i in 1:5) print(i*2)


v=vector(length=5)
for(i in 1:5) v[i]=i*2
v

a=c(8,4,3,1)
for(i in 1:5) v[i]=a[i]*2
v



times=20
col.times = 20
m=matrix(nrow=times,ncol=col.times)
m
for(i in 1:times) m[i,]=i* (1:col.times)
m


j=1
while(j<=10){
  if(j ==10) print("j too high") else print(j)
  j= j+1
}





#Samples and Distributions ###################################

#Sample function takes a vector, then gives a random value within the vector under certian conditions

sample(1:10,1)

sample(1:10,10) #gives you 1:10 in random order, but no repeats

sample(1:10, 10, replace=T) #now we can get repeats
#This is also called bootstrapping - sampling with replacement

obs.mean = mean(mtcars$mpg)
samp.mean= vector(length=100)
for(i in 1:100){
  samp = sample(1:length(mtcars$mpg),25)
  samp.mean[i]=mean(mtcars$mpg[samp])
}
samp.mean
obs.mean
hist(samp.mean)
abline(v=obs.mean, col="red")
