#distributions and population growth model
#sampling from probability distributions
#getting a set of 100 random numbers from a normal distribution
rnorm(100)
?rnorm
r <- rnorm(100)
hist(r)

#make the random sampling repeatable by using seed
set.seed(20)
r <- rnorm(100)
hist(r)

#r unif gives you numbers from a uniform distribution between 0 and 1
u <- runif(100)
hist(u)

#sample from binomial distribution (randomly choose 0 or 1 based on a probability)
#do 100 iterations of one coin flip with equal probability of getting 0 and 1.
b <- rbinom(100, 1, prob=c(0.5, 0.5))
hist(b)
sum(b)/length(b) #should be close to 0.5

#another way
rbinom(1, 100, prob=c(0.5,0.5)) #gives you the number of times you get 1


##################################### Modeling population growth #############
install.packages("primer")
install.packages("RColorBrewer")
library(primer)
library(RColorBrewer)
N0 <- 100
lambda <- 1.5
t=0:10 #time from 0 to 10
N = N0 * lambda ^ t
N
round(N, 0) #to make number of individuals whole numbers (digits=0)
#plot population vs time for geometric population growth
plot(t, N, type="o", las=1, pch=19)
#plot population vs time with y axis on a logarithmic scale
plot(t, N, type="o", las=1, log="y")

### Project population at different growth rates
N0 <- 100
lambda <- seq(0.6, 1.4, 0.2) #0.6-1.4 at increments of 0.2
t <- 0:10
# we will get 5 projections of populations
#use sapply to calculate N across time (t) at different growth rates
N <- sapply(lambda, function(x) N0 * x ^ t)
N
#plot a matrix of information using matplot()
matplot(t, N, las=1)
matplot(t, N, las=1, pch=1:5, log="y", type="o")

### Simulate stochasticity
#make a distribution of lambda values
hist(rnorm(1000))
hist(rlnorm(1000, meanlog=0, sdlog=0.1)) #varying values of lambda
lambdas <- (rlnorm(1000, meanlog=0, sdlog=0.1))

#make a loop to simulate population
N0 <- 100
times <- 20
N <- vector(length=times)

#set initial population size as N0
N[1] <- N0
#here, let's use a static lambda
lambda <- 1.2
for(t in 2:times) {
  N[t] = N[t-1] * lambda
}
plot(1:times, N, type="o", las=1)

#different values of lambda - incorporate variation in population growth rate
lambda <- rlnorm(times-1, meanlog=0, sdlog=0.1)
#meanlog is the mean on a log scale, so meanlog=0 means the mean is e ^ 0 = 1

for(t in 2:times) {
  N[t] = N[t-1] * lambda[t-1]
}
plot(1:times, N, type="o", las=1)

#run multiple simulations and plot the results
set.seed(2)
sims <- 10
outmat <- sapply(1:sims, function(x) {
  N0 <- 100
  times <- 20
  N=vector(length = times)
  N[1] <- N0
  lambda <- rlnorm(times-1, meanlog=0, sdlog=0.1)
  for(t in 2:times){
    N[t]=N[t-1]*lambda[t-1]
  }
  N
})

outmat
matplot(1:times, outmat, type="l", las=1, lty=5, ylim=c(0,200), ylab="N", xlab="year")
