# distributionsand populkation growth model

#getting random numbers from normal distribution

rnorm(100)
?rnorm

rnorm(100)
hist(r)

#make random sampling repeatable
set.seed(20)
r=rnorm(100)
hist(r)

#sample from unifrom distribution
u=runif(100)
hist(u)

#sample from the binomial distribution
# 10000 random coin flips, prob of getting either zero or one
b=rbinom(10000, 1, prob=c(0.5, 0.5))
b
sum(b)/length(b)


