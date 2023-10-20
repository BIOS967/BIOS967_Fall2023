#Distributions and population growth model

#getting a set of 100 rando numbers from a normal distribution
rnorm(100)
?rnorm

r=rnorm(100)
hist(r)

#make the rando sampling repeatable
set.seed(20)
r=rnorm(100)
hist(r)

u=runif(100)
hist(u)

#Sample from binomial distribution
#do 100 iterations of 1 coin flip with equal prob. of getting 0 or 1
b=rbinom(100,1,prob=c(0.5,0.5))
b
sum(b)/length(b)
#or
rbinom(1,100,prob=c(0.5,0.5))#how many times it got one

library(RColorBrewer)
N0=100
lamda=1.5
t=0:10
N=N0*lamda^t
N

#plot geometric pop growth
plot(t,N,type="o",las=1)

#plot y-axis on log scale
plot(t,N,type="o",las=1, log="y")

#project pop at dif growth rates
N0=100
lambda=seq(0.6,1.4,0.20)
lambda
t=0:10

#now use sapply to calculate N across time (t) at different growth rates (lambda)
N=sapply(lambda,function(x)N0*x^t)
N

matplot(t,N,las=1)#plot the results in the matrix

matplot(t,N,las=1,type="o",pch=1:5)

matplot(t,N,las=1,type="o",pch=1:5, log="y")


hist(rnorm(1000))
hist(rlnorm(1000,meanlog=0,sdlog=0.1))

lambdas=rlnorm(1000,meanlog=0,sdlog=0.1)

#make a loop to simulate population
N0=100
times=20
N=vector(length=times)

#set initial pop size as N0
N[1]=N0
#let's use a static lambda
lambda=1.2
for(t in 2:times){
  N[t]=N[t-1]*lambda
}
N
plot(1:times,N,type="o",las=1)

#now create stochastic model
N0=100
times=20
N=vector(length=times)
N[1]=N0
#use a dist of lambdas

lambda=rlnorm(times-1,meanlog=0,sdlog=0.1)
#lets look at lambda
lambda

for(t in 2:times){
  N[t]=N[t-1]
}
N
plot(1:times,N,type="o",las=1)


sims=10
times=20
outmat=sapply(1:sims, function(x){
  N0=100
  N=vector(length=times)
  N[1]=N0
  lambda=rlnorm(times-1,meanlog=0,sdlog=0.1)
  for(t in 2:times){
     N[t]=N[t-1]*lambda[t-1]
  }
  N
})
outmat
matplot(1:times,outmat,las=1,type="l",log="y")
