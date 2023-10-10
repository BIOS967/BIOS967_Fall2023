##apply functions and loops

#create an example function
mult.2=function(x) x*2
mult.2(1242)

#use sapply() to apply this function to a set of numbers

#take integers from 1 to 5, and multiply each by 2
sapply(1:5, mult.2)

#... or you can just define the function within the sapply() function.
sapply(1:5, function(x) x*2)

#difference between sapply() and lapply() is just the output format
#lapply always gives you a list
lapply(1:5, function(x) x*2)

### use sapply() to apply a function that generates more than just a vector

v=c(1,2,3)
sapply(1:5, function(x) x*v)

lapply(1:5, function(x) x*v)

### use sapply() and lapply() to run linear models on multiple datasets

iris

iris.split=split(iris, iris$Species)
iris.split
class(iris.split)

spp.mods=lapply(iris.split, function(x) lm(Petal.Length~Sepal.Length, data=x))
spp.mods

summary(spp.mods[[1]]) #results for lm on setosa
summary(spp.mods[[2]]) #results for versicolor
summary(spp.mods[[3]]) #results for virginica

spp.mods.summary=lapply(spp.mods, function(x) summary(x))

#let's get the slope of relationship for each of the models
str(spp.mods.summary[[1]]) #look at the structure of the summary output
spp.mods.summary[[1]]$coefficients
spp.mods.summary[[1]]$coefficients[2,1] #THIS is the number I want to extract from each model summary

slopes=sapply(spp.mods.summary, function(x) x$coefficients[2,1])
slopes

#visualize the relationships between petal length and sepal length for each species
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~Species)

### for-loops()
for(i in 1:5) print(i*2)

v=vector(length=5)
v
for(i in 1:5) v[i]=(i+1)*2
v

a=c(8, 4, 3, 1)

for(i in 1:5) v[i]=a[i]*2
v

times=8
m=matrix(nrow=times, ncol=10)
for(i in 1:times) m[i,]=(1:10)*i
m

## while-loop
j=1
while(j<20) {
  if(j==10) print("10!") else print(j)
  j=j+1
}

### samples

sample(1:10, 1) #gives you one number between 1 and 10
sample(1:10, 10) #gives you 10 numbers between 1 and 10 in randomized order
sample(1:10, 10, replace=TRUE) #BOOTSTRAPPING -- sampling with replacement. Basically like picking number out of a hat, then replacing it back into the hat.

sample(1:10, 7, replace=FALSE) #jackknifing: randomly subsampling your data

obs.mean=mean(mtcars$mpg)

samp.mean=vector(length=100) #create an empty vector of 100 numbers
for(i in 1:100){
  samp=sample(1:length(mtcars$mpg), 25) #randomly pick 25 numbers between 1 and 32 (number of cars)
  samp.mean[i]=mean(mtcars$mpg[samp]) #I'm going to pick the cars assigned by "samp" and take the mean of mpg
}

samp.mean
obs.mean

hist(samp.mean) #make a histogram of my subsample means
abline(v=obs.mean, col='red') #draw a red line where my observed mean was
