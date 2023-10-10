####################apply functions and loops##############
#create an example function
mult.2 <- function(x) x*2
mult.2(23498235)

#use sapply() (simplified apply function) to apply this function to a set of numbers
#take the integers from 1 to 5 and multiply each by 2
#you could do it with a pre-named function
sapply(1:5, mult.2)

#or you can define a function inside the sapply
sapply(1:5, function(x) x*2)

#difference between sapply() and lapply() is just the output format
#sapply gives you the output in the simplest form; lapply always gives you a list
lapply(1:5, mult.2)

#use sapply() to apply a function that generates more than just a vector
v <- c(1,2,3)
sapply(1:5, function(x) x*v) #x is vector of 1,2,3,4,5 and v is a vector 1,2,3.
#you get a matrix

lapply(1:5, function(x) x*v)
#you get v*1, v*2, v*3, v*4, v*5. This is a list.

#### Use sapply() an lapply() to run a linear model on multiple datasets
#split iris dataset to 3 datasets- 1 for each species
iris.split <- split(iris, iris$Species)
iris.split
#created a list of 3 dataframes
class(iris.split) #this tells you it's a list

#we could fit the linear model and then see the summaries manually
spp.mods <-lapply(iris.split, function(x) lm(Petal.Length~Sepal.Length, data=x)) #apply this function to each of the three dataframes
spp.mods
summary(spp.mods[[1]]) #get model fit results for the first model (setosa). You need thwo sets of square brackets because it's a list.
summary(spp.mods[[2]]) #get model fit results for versicolor
summary(spp.mods[[3]]) #get model fit results for virginica


#or we can get lapply to give you all the summaries
spp.mods.summary <- lapply(spp.mods, function(x) summary(x))
spp.mods.summary

#let's get the slope of relationship for each of the models
str(spp.mods.summary[[1]]) #look at the structure of the summary output
spp.mods.summary[[1]]$coefficients
spp.mods.summary[[1]]$coefficients[2,1] #this is the number I want to extract from each model summary
slopes <- sapply(spp.mods.summary, function(x) x$coefficients[2,1]) #it's easier to store the numbers as a vector instead of a list, so we use sapply
slopes

#visualize the relationships between petal length and sepal length for each species
library(ggplot2)
#put them all on the same plot
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  geom_smooth(method="lm")

#you can get the plots to be separate using facet_wrap(~Species)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~Species)


############ Loops ###############
for(i in 1:5)print(i*2)

#create a vector with 5 empty spots
v <- vector(length=5)
v
#fill the vector spots using the for loop
for(i in 1:5) v[i]=i*2
v

a <- c(8,4,3,1)

for(i in 1:5) v[i] = a[i]*2
v

times=5
m <- matrix(nrow=times, ncol=10)
for(i in 1:times) m[i,] = (1:10) *i
m


#with lists, you don't need to pre-define the number of elements
#it's relatively safe to use lists

#### While loop
j=1
while(j<10){ #while j is less than 10
  print(j) #print j
  j=j+1 #then add one to j to make the new j
}
#be careful to not make while loops infinite


j=1
while(j<20){ #while j is less than 10
  if(j==10) print("10!!!!!") else print(j)
  j=j+1 #then add one to j to make the new j
}



############## Samples

sample(1:10, 1) #sample one from 1:10 without replacement
sample(1:10, 134, replace= TRUE) #sample 134 from 1:10 with replacement (bootstrapping)
#bootstrapping is sampling with replacement. Basically like picking a number out of a hat then replacing it in the hat. People use it when the measurements are robust to sampling error.

#jackknifing- randomly subsetting your data
sample(1:10, 7, replace=FALSE)

obs.mean <- mean(mtcars$mpg)
obs.mean

samp.mean <- vector(length=100) #create an empty vector of 100 numbers
for(i in 1:100){
  samp <- sample(1:length(mtcars$mpg), 25) #randomly pick 25 numbers between 1 and 32 (number of cars)
  samp.mean[i] <- mean(mtcars$mpg[samp]) #pick the cars assigned by samp and take the mean
}
samp.mean #this is a vector of all the means of these samples
obs.mean #compare to observed mean
#this can let you check how robust the estimate of the mean was
hist(samp.mean) #make a histogram of means of the samples
abline(v=obs.mean, col="seagreen") #draw a line at the overall mean
