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

spp.mods.summary=lapply(spp.mods,function(x)summary(x))

#Get the slope of relationship of ea model
str(spp.mods.summary[[1]])#look at the structure of summary output
spp.mods.summary[[1]]$coefficients
spp.mods.summary[[1]]$coefficients[2,1]#goal number

slopes=sapply(spp.mods.summary,function(x)x$coefficients[2,1])
slopes

#Alt+shift+ arrow to duplicate lines of code

#visualize relationship betweem pertal length and sepal length for ea species
library(ggplot2)
ggplot(iris,aes(x=Sepal.Length,y=Petal.Length,color=Species))+
  geom_point()+
  geom_smooth(method="lm")+
  facet_wrap(~Species)


##For-loops()
for(i in 1:5)print(i*2)

v=vector(length=5)
v
for(i in 1:5)v[i]=i*2 #gives us i= 1,2,3,4,5,6
v
for(i in 1:5)v[i]=(i+1)*2 #to fix, now i=2,3,4,5
v

times=5
m=matrix(nrow=times,ncol=10)
for(i in 1:times)m[i,]=(1:10*i)
m

#while-loop
j=1
while(j<10){
  print(j)
  j=j+1
}
j

j=1
while(j<20){
  if(j==10) print("10!")else print(j)
  j=j+1
}



#Random Sampling

sample(1:10,1) #gives 1 number between 1 &10
sample(1:10,10) #gives 10 numbers between 1 &10
sample(1:10,10, replace=TRUE) #gives 10 numbers between 1 &10, and allows re-draw, "BOOTSTRAPPING- sampling with replacement




obs.mean=mean(mtcars$mpg)

samp.mean=vector(length=100)
for(i in 1:100){
  samp=sample(1:length(mtcars$mpg),25)#randomly pick 35 numbers betweem 1 and 32 (numner of cars)
  samp.mean[i]=mean(mtcars$mpg[samp])#pick the cars assigned by samp and take the mean mpg
}
samp
samp.mean

obs.mean

hist(samp.mean)#make a histogram of subsample means

abline(v=obs.mean,col='red')#draw a red line where obs mean was


