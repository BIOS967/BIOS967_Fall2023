# October 10th 2023

#Distributions and Population Modeling


#Getting set of 100 random numbers from a normal dist.
rnorm(100)

r = rnorm(1000)
hist(r)


#What if we want to get a repeatable random sampling?
set.seed(20)
r = rnorm(100)
hist(r)

u=runif(100)
hist(u)

b=rbinom(n = 10000000,size = 1,prob = 0.5)
hist(b)
mean(b)


#Population Growth Model

library(knitr)
#install.packages("primer")
library(primer)
library(RColorBrewer)

N0=100
lambda= 1.5
t=0:10
N=N0*lambda^t
round(N,0)
#plot exponential growth
plot(t,N, type="o", las=1, pch=19)

#plotting on log scale
plot(t,N,type="o", las=1, pch=19, log="y")


#What if we want to compare different population growth rates
N0=100
lambda= seq(0.6,1.4,0.2)
t=0:10
N= sapply(lambda, function(x) N0*x^t)
N
N[,1]
plot(N[,1])

#plot a matrix worth of info
matplot(t, N, las = 1, pch=1:5, type="o", log = "y")


##Stochastic growth model using rnorm as the random growth rate

hist(rnorm(1000))

hist(rlnorm(1000, meanlog = 0, sdlog = 0.1))

set.seed(2)
lamb=rlnorm(1000, meanlog = 0, sdlog = 0.1)

#make loop to simulate population
N0=100
times=20
N=vector(length=times)
N
#set initial population as N0

N[1]=N0
#static lamb
#lamb=1.2
set.seed(2)
lamb=rlnorm(times-1, meanlog = 0, sdlog=0.1)
for(t in 2:times){
  N[t]=N[t-1]*lamb[t-1]

}
N
plot(1:times,N, type="o",las=1)
lamb


#multiple simulations at once

set.seed(2)
sims=10
times=20
outmatrix<-sapply(1:sims, function(x){

  N0=100
  N=vector(length=times)
  N[1]=N0
  lamb=rlnorm(times-1, meanlog = 0, sdlog=0.1)
  for(t in 2:times){
    N[t]=N[t-1]*lamb[t-1]

  }
  N
})
outmatrix

matplot(1:times, outmatrix, las=1, type="l", log="y")















