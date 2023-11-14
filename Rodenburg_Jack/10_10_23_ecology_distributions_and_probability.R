##distributions and population growth model

#getting a set of 100 random numbers from a normal distribution
rnorm(100)
?rnorm

r <- rnorm(100)
hist(r) #make a histogram

#make the random sampling repeatable
set.seed(2) #telling the "random" algorithm which number to *start* with
r <- rnorm(100)
hist(r) #make a histogram

#sample from uniform distribution
u <- runif(100,0,100)
hist(u)

#sample from binomial distribution
b <- rbinom(100, 1, prob=c(.5,.5)) #100 iterations of 1 conflict
b
sum(b)/length(b) #finds the average

rbinom(1, 100, prob=c(0.5,0.5)) #this is 1 iterations of 100 conflicts

#modeling population growth
#install.packages("primer")
#install.packages("RColorBrewer") installs these for first time
library(primer)
library(RColorBrewer)

N0 <- 100
lambda <- 1.5
t <- 0:10

N <- N0*lambda^t
N_round <- round(N,0)

N_round

#plot geometric population growth
plot(t, N, type="o", las=1) #las=1 makes the y axis numbers verticle
#plot y-axis as log scale
plot(t, N, type="o", las=1, log="y")

#project population at different growth rates "lambda"

N0 <- 100
lambda <- seq(.6, 1.4, .2)
lambda
t <- 0:10
#now, use sapply to calculate N across time (t) at differnt growth rates lambda
N <- sapply(lambda, function(x) N <- N0*x^t) #lambda becomes the x in the function
N

matplot(t, N, las=1) #plot the results of the matrix
matplot(t, N, las=1, type="o", pch=1:5, log="y")

#introduce some stochasticity
hist(rlnorm(100, meanlog=0, sdlog=0.1))

lambdas <- rlnorm(100, meanlog=0, sdlog=0.1)
lambdas

#make a loop to simulate population
N0 <-  100
times <-  20
N <-  vector(length=times)

#set intial population size as N0
N[1] <- N0
#here, let's use a static lambda
lambda <- 1.2
for(t in 2:times){
  N[t] = N[t-1]*lambda
}

N
plot(1:times, N, type="o", las=1) #this is still static lambda

#now we're ready to introduce stochasticity

N0 <-  100
times <-  20
N <-  vector(length=times)

N[1] <- N0
#lets use a distribution of lambdas
set.seed(2)
lambda <- rlnorm(times-1, meanlog=0, sdlog=.1) #sets the value at actual 1, log(1)=0

for(t in 2:times){
  N[t] = N[t-1]*lambda[t-1]
}
N




#run multiple simulations and plot the results
set.seed(2)
sims <- 10 #creates a matrix, running the same scenario 10 different times
times <-  200
#sapply function will setup 10 iteration of the loop
outmat <- sapply(1:sims, function(x) {
  N0 <-  100

  N <- vector(length=times)
  N[1] <- N0
  lambda <- rlnorm(times-1, meanlog=0, sdlog=.1) #sets the value at actual 1, log(1)=0
  for(t in 2:times){
    N[t] = N[t-1]*lambda[t-1]
  }
  N
})

outmat
matplot(1:times, outmat, las=1, type="l", log="y")