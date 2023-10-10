#APPLY FUNCTIONS AND LOOPS
library(ggplot2)

#create an example function
mult.2 <- function(x) x*2
mult.2(1242)

#use supply() to apply this function to a set of numbers

#take integers from 1:5, and multiply each by 2
sapply(1:5, mult.2)

sapply(1:5, function(x) x*3) #you can create/define the function within sapply

#DIFFERENCE BETWEEN SAPPLY AND LAPPLY
#lapply always gives you a list
#sapply gives you "simplest" form

lapply(1:5, function(x) x*3)

#use sapply() to apply a function that generates more than just a vector

v=c(1,2,3) #or v=c(1:3)
sapply(1:5, function(x) x*v)

lapply(1:5, function(x) x*v)

### use sapply() and laaply() to run a linear model on multiple data sets

iris

iris.split <- split(iris, iris$Species)
iris.split
#class(iris.split) tells you what form this is in (its a list)

spp.mods <- lapply(iris.split, function(x) lm(Petal.Length~Sepal.Length, data=x))
spp.mods

summary(spp.mods[[1]]) #results for lm on setosa
summary(spp.mods[[2]]) #results for lm on versicolor
summary(spp.mods[[3]]) #results for lm on virginica
#need double square brackets because its a list

#Kind of cumbersome to run this three times

spp.mods.summary <- lapply(spp.mods, function(x) summary(x))
spp.mods.summary

#let's get the slope of relationship for each of the models
str(spp.mods.summary[[1]]) #look at the strucure of the summary output
spp.mods.summary[[1]]$coefficients[2,1] #THIS is the number I want tot extract from each modeled sumamry

slopes <- sapply(spp.mods.summary, function(x) x$coefficients[2,1])
slopes

#visualize the relationships between between petal length and sepal length for each species

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~Species) #creates three different graphs


####for-loops()

for (i in 1:5){
  print(i*3)
}
#could also be
for (i in 1:5) print(i*2)


v <- vector(length=5)
for(i in 1:5) v[i] <- i*2
v
#lets say you wanted something else, like this
for(i in 1:5) v[i] <- (i+1)*2
v

a <- c(8,4,3,1)
for(i in 1:5) v[i] <- a[i]*2
v

#creates matrix bru
times <- 5
m <- matrix(nrow = times, ncol = 10)
for(i in 1:times)m[i,]=(1:10)*i
m

## WHILE-LOOP
#while loops are super useful when there are weird things you want to avoid
j <- 1
while(j<20){
  if(j==10) print("10!") else print(j)
  #print(j)
  j <- j+1
  #print(j)
}

## SAMPLES

sample(1:10, 1) #gives you one number between 1 and 10 (randomly)
sample(1:10,10) #gives you 10 numbers between 1 and 10 in randomized order
sample(1:10, 11, replace=TRUE) #puts the number you drew, back into the set to draw from, known as BOOTSTRAPPING

sample(1:10, 7, replace=FALSE) #JACKKNIFING: randomly subsampling your data

obs.mean <- mean(mtcars$mpg)
samp.mean <- vector(length = 100)
for(i in 1:100){
  samp <- sample(1:length(mtcars$mpg), 25) #randomly plick 25 numbers between 1 and 32 (number of cars)
  samp.mean[i]=mean(mtcars$mpg[samp]) #pick the cars assigned by "samp" and take the mean
}

samp.mean
obs.mean
#checks how robust estimate of mean was

hist(samp.mean) #make a histogram of my subsample means
abline(v=obs.mean, col='red') #draw a red line where my observed mean was