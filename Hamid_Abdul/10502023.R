10052023

#apply functions and loop


#create an axample function
mult.2=function(x) x*2
mult.2(1242)


#use sapply() to apply this function to a set of numbers

#take integers from 1 to 5, and multiply each by 2
sapply(1:5, mult.2)


# ... or you can just define the function within the sapply() function

sapply(1:5, function(x) x*2)

#diffrence between saaply and lapply is just the output format 
#lapply will always give you a list 
lapply(1:5, function(x) x*2)

#use sapply() to apply a function that geenrates more than just a vector 
v=c(1,2,3)
sapply(1:5, function(x) x*v)

lapply(1:5, function(x) x*v)


## use sapply and lapply to run a linera model of multiple dataset
iris

iris.split=split(iris, iris$Species)
iris.split
class(iris.split)


spp.mods=lapply(iris.split, function(x) lm(Petal.Length~Sepal.Length, data=x)) 
spp.mods


summary(spp.mods[[1]])
summary(spp.mods[[2]])
summary(spp.mods[[3]])

spp.mods.summary=lapply(spp.mods, function(x) summary(x))

#let's get the slope of relationship for each of the models
str(spp.mods.summary[[1]])
spp.mods.summary[[1]]$coefficient
spp.mods.summary[[1]]$coefficient[2,1]


slopes=sapply(spp.mods.summary, function(x) x$coefficients[2,1])
slopes


#visualize the relationships between petal length and sepal length for each species
library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~Species)


## for_loops()
for(i in 1:5) print(i*2)


v=vector(length=5)
v
for(i in 1:5) v[i]=i*2
v
for(i in 1:5) v[i]=(i+1)*2
v
a=c(8, 4, 3, 1)
for(i in 1:5) v[i]=a[i]*2
v

times=5
m=matrix(nrow=times, ncol=10)
for(i in 1:times) m[i,]=(1:10)*i
m
## while-loop

j=1
while(j<20) {
  if(j==10) print("10!") else print(j)
  j=j+1
}


#samples

sample(1:10, 1) # gives you 1 number between 1 and 10 


sample(1:10, 10, replace=TRUE) #BOOTSTRAPPING -- sapling with replacing 

sample(1:10, 7, replace=FALSE) #JACKKNIFING


obs.mean=mean(mtcars$mpg)
samp.mean=vector(length=100)
for(i in 1:100){
  samp=sample(1:length(mtcars$mpg), 25)
  samp.mean[i]=mean(mtcars$mpg[samp])
}

samp.mean
obs.mean


hist(samp.mean)
abline(v=obs.mean,col='red')
