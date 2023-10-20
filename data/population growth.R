#distributions and polpulation growth model

#getting a random set of numbers that follows normal distribution
r=rnorm(100)
hist(r)
#the larger the sample size the better the distribution
#make the sampling repeatable
set.seed(20)
r=rnorm(100)
hist(r)

?set.seed()

u=runif(100)
hist(u)

#sample from binomial distribution
b=rbinom(100, 1, prob = c(0.5, 0.5))
b
sum(b)/length(b)

#to know the number of 1s in the throw
rbinom(1, 100, prob = c(0.5, 0.5))

##modeling population growth
install.packages("primer")
install.packages("RColorBrewer")
library(primer)
library(ggplot2)
library(RColorBrewer)

#set intial population size to 100
N0=100
lambda=1.5
t=0:10
N=N0* lambda^t
N
#geometric scale
plot(t, N, type="o", las=1)

#log scale
plot(t, N, type = "o", las=1, log="y")

##project population at different growth rates
N0=100
lambda=seq(0.6, 1.4, 0.2)
t=0:10
N = sapply(lambda, function(x) N0*x^t)
N

matplot(t, N, las=1, type = "o", pch = 1:5, log = "y") #plot results in matrix

set.seed(2)
hist(rlnorm(10000, meanlog = 0, sdlog = 0.1), las=1, )


##using loop to simulate population growth
N0=1000
times=20
N=vector(length = times)

#set intial population to 0
N[1] = N0

lambda=1.2
for (t in 2:times) {
  N[t]=N[t-1]*lambda
}

plot(1:times, N, type = "o", las=1)
lambda=(rlnorm(1000, meanlog = 0, sdlog = 0.1), las=1, )

#stochastic model
N0=100
times=20
N=vector(length = times)

#set intial population to 0
N[1] = N0

lambda=rlnorm(times-1, meanlog = 0, sdlog = 0.1)
for (t in 2:times) {
  N[t]=N[t-1]*lambda[t-1]
}

plot(1:times, N, type = "o", las=1)
lambda=(rlnorm(100, meanlog = 0, sdlog = 0.1), las=1)

#run multiple simulation and plot the result
set.seed(2)
sims=10
times=20
output=sapply(1:sims, function(x) {
  N0=100
  N=vector(length = times)
  N[1] = N0
  lambda=rlnorm(times-1, meanlog = 0, sdlog = 0.1)
  for (t in 2:times) {
    N[t]=N[t-1]*lambda[t-1]
  }
  N
})
output
matplot(1:times, output, las=1, type = "l", log = "y")

data("sparrows")
