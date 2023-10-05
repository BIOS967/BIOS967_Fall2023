#apply functions and loops
#create an ex function
mult.2=function(x)x*2
mult.2(1242)

#use sapply() to apply this function to a set of numbers
#take integers from 1-5 amd multiply ea by 2
sapply(1:5,mult.2)

#or you can define the function within the sapply funciton
sapply(1:5,function(x)x*2)

#sapply vs lapply is just output format
#s-simplified (vector), L-list
lapply(1:5,function(x)x*2)

##use sapply to apply a function that generates more than just a vector

v=c(1:3)
sapply(1:5,function(x)x*v)

lapply(1:5,function(x)x*v)

##USe sapply and lapply to run linear ,odels on multiple datasets
iris
iris.split=split(iris,iris$Species)
iris.split
class(iris.split)

spp.mods=lapply(iris.split,function(x) lm(Petal.Length~Sepal.Length,data=x))
spp.mods

summary(spp.mods[[1]])#results



