#sample function
sample(1:10, 1) #generate a random number

sample(1:10, 10, replace = TRUE) #this is called bootstrapping. Simply known as sampling with replacement.

sample(1:10, 7, replace = FALSE) #this is called jackknifing: randomly sampling your data

obs.mean= mean(mtcars$mpg)
samp.mean=vector(length=100) #create an empty vector of 100 numbers
for(i in 1:100){
  samp=sample(1:length(mtcars$mpg), 25) #randomly pick 25 numbers between 1 and 32 (number of cars)
  samp.mean[i]=mean(mtcars$mpg[samp]) # I'm going to pick the cars assigned by "samp" and take the mean of mpg
}
samp.mean
obs.mean

hist(samp.mean)
abline=