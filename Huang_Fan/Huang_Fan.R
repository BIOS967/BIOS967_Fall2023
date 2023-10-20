#09-05-2023---------------------------------------------------------------------

#09-07-2023---------------------------------------------------------------------
errdat=read.csv("data/SampleData_w_errors.csv")
errdat
#look at structure of data
str(errdat)
#problemLsize is not a number here.
errdat$size

#problem: weight is not a number
errdat$weight

#this problem is caused by the inclusion of $N/A as value.
#solution: tell R that this is a missing value when importing the data
errdat=read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!","**"))
errdat
errdat$weight
mean(errdat$size, na.rm = T) #to calculate something from numeric vector with
#NAs, tell it to ignore NA using na.rm=T

#to remove column "X"
names(errdat)
names(errdat)=="X" #are any of the columns called "X"
which(names(errdat)=="X") #which column is called "X"
#give me the values for the column called "X" in df "errdat"
errdat[,which(names(errdat)=="X")]
#give me all the columns EXCEPT the one called "X"
dat=errdat[,which(names(errdat)!="X")]
dat

#let's remove any rows that is missing an individual ID
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2

#plotting basics:
plot(dat2$size,dat2$weight)#plot one continuous

plot(dat2$weight~dat2$size)#plot in 'formula'

plot(weight~size,data=dat2)
boxplot(weight~size,data=dat2)

#09-11-2023
eggs=read.csv("data/EggMeasurements_example.csv")
head(eggs)
unique(eggs$mass)
eggs=read.csv("data/EggMeasurements_example.csv", na.strings=".")
unique(eggs$mass)

#09-19-2023
#install.packages("ggplot2")
"
1. data:
2. aesthetics: How do the variables are related to each other
3. geom: Type of geometric object
4. scale: set of values that the variables will take
5. theme:
"
library(ggplot2)
#normal plot
plot(Sepal.Width~Sepal.Length,data=iris,xlab="Sepal Length",
     ylab="Sepal Width",las=1,col=iris$Species,pch=10)
#ggplot way
p1=ggplot(data=iris,mapping = aes(x=Sepal.Length,y=Sepal.Width,color=Species))+
  geom_point(size=2,pch=10,alpha=0.5)+
  scale_fill_brewer(palette="Paired")+
  theme_bw()+
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),legend.position = "none")+
  xlab("Sepal Length")+
  ylab("Sepal Width")+
  facet_grid(~Species)
ggsave("Huang_Fan/ggplot_facet.pdf",p1)

#09-21-2023 linear models
library(ggplot2)
#install.packages("MASS")
library(MASS)
"
numbers:
  continuous
  binary (0 or 1)
  counts
  preportion

factors (categories):

"
mtcars
fit=lm(mpg~wt,data=mtcars)
summary(fit)
ggplot(mtcars,mapping = aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method = "lm",color="black",se=F)+
  theme_bw()+
  xlab("weight")+
  ylab("miles per gallon")

ggplot(mtcars,mapping = aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method = "loess",color="black",se=F)+
  theme_bw()+
  xlab("weight")+
  ylab("miles per gallon")

ggplot(mtcars,mapping = aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method = "glm",color="black",se=F)+
  theme_bw()+
  xlab("weight")+
  ylab("miles per gallon")


mtcars$vs
ggplot(data=mtcars,mapping = aes(x=factor(vs),y=mpg))+
  geom_boxplot()

aov.fit=aov(formula=mpg~factor(vs),data=mtcars)
summary(aov.fit)

lm.fit=lm(formula=mpg~factor(vs),data = mtcars)
summary(lm.fit)

anova(lm.fit)

lm.fit2=lm(mpg~wt+factor(vs),data = mtcars)
anova(lm.fit2)

#09-26-2023
#install.packages("tidyverse")
#install.packages("wbstats")
library(wbstats)
library(tidyverse)


#using the billboard
billboard
?billboard

filter(billboard, artist=="Backstreet Boys, The")
billboard %>% filter(artist=="Backstreet Boys, The")

billboard %>% filter(artist=="Backstreet Boys, The"| artist=="N'Sync") %>% filter(wk1<50)

billboard %>% filter(artist=="Backstreet Boys, The" & wk1<50)

billboard %>% select(-artist, -date.entered)

#calculate the best rank in year 2000 for each artist
bb.summary=billboard %>%
  pivot_longer(cols=starts_with("wk"),names_to = "week",values_to = "rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarise(artist.best=min(rank),n.weeks=n())

bb.summary

library(ggplot2)
ggplot(bb.summary,aes(x=n.weeks,y=artist.best))+
  geom_point()


#create a new variable using mutate()
#calculate rank change between week1 and week 2 for each song
billboard %>%
  mutate(rank.diff=wk2-wk1)%>%
  select(artist,track,wk1,wk2,rank.diff)


#09-28-2023
boloria=read.csv("data/boloria.csv")
boloria

colias=read.csv("data/colias.csv")
colias

library(tidyverse)
#install.packages("cowplot")
library(cowplot)

year.dat=boloria %>% group_by(year) %>% summarise(snow=mean(snow),mayjun=mean(mayjun),mayaug.1=mean(mayaug.1))

p1=ggplot(year.dat,aes(x=year,y=snow))+
  geom_point()+
  geom_smooth(method = "lm",se=F,color="black")+
  theme_bw()

p2=ggplot(year.dat,aes(x=year,y=mayjun))+
  geom_point()+
  geom_smooth(method = "lm",se=F,color="black")+
  theme_bw()+
  labs(y=expression(paste("Average Temperature"["t"]," ",(~degree*C))))
p2


p3=ggplot(year.dat,aes(x=year,y=mayaug.1))+
  geom_point()+
  geom_smooth(method = "lm",se=F,color="black")+
  theme_bw()
p3

plot_grid(p1,p2,p3,align="v",nrow=3)

fit.snow=lm(snow~year,data=year.dat)
summary(fit.snow)

fit.mayjun=lm(mayjun~year,data=year.dat)
summary(fit.mayjun)

wl.colias=colias %>% group_by(year,sex) %>% summarise(mean_se(WL))
wl.boloria=boloria %>% group_by(year,sex) %>% summarise(mean_se(WL))


p2.a=ggplot(wl.colias,aes(x=year,y=y,group=sex))+
  geom_path()+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values=c("red","blue"))+
  geom_errorbar(aes(ymin=ymin,ymax=ymax))+
  theme_bw()+
  theme(legend.position = "none")

p2.b=ggplot(wl.boloria,aes(x=year,y=y,group=sex))+
  geom_path()+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values=c("red","blue"))+
  geom_errorbar(aes(ymin=ymin,ymax=ymax))+
  theme_bw()+
  theme(legend.position = "none")

wl.colias=left_join(wl.colias,year.dat,by=join_by(year==year))
p2.c=ggplot(wl.colias,aes(x=mayaug.1,y=y,group=sex))+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values=c("black","white"))+
  geom_errorbar(aes(ymin=ymin,ymax=ymax))+
  theme_bw()

wl.boloria=left_join(wl.boloria,year.dat,by=join_by(year==year))
p2.d=ggplot(wl.boloria,aes(x=mayaug.1,y=y,group=sex))+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values=c("black","white"))+
  geom_errorbar(aes(ymin=ymin,ymax=ymax))+
  theme_bw()

plot_grid(p2.a,p2.c,p2.b,p2.d,nrow=2)

#10-03-2023
#function
1:10
mean(1:10)
sum(1:10)/length(1:10)
#make this into a function
mean.custom=function(y)
{
  sum(y)/length(y)
}
#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length)#my own function
mean(iris$Sepal.Length)#R function
#if else statements
num=4
if (num %%2==0) {
  print("this number is even")
}
num=7
if (num %%2==0) {
  print("this number is even")
} else {
  print("this number is odd")
}

#make a custom function to tell if a number is even or odd
even.or.odd=function(num)
{
  if (num %%2==0)
  {
    print("this number is even")
  } else if (num%%2==1)
  {
    print("this number is odd")
  } else
  {
    print("this number is neither even nor odd")
  }
}
even.or.odd(4.1)


#make a custom function to tell if a number is even or odd
even.or.odd=function(num)
{
  if (isFALSE(all.equal(num, as.integer(num))))
  {
    print("this is not an integer")
  }
  else if (num %%2==0)
  {
    print("this number is even")
  } else
  {
    print("this number is odd")
  }
}
even.or.odd(4)

#example: custom function for averages
#this version does not have a default type
average=function(x,type)
{
  if (type=="grithmetric") {
    sum(x)/length(x)
  } else if (type=="geometric")
  {
    prod(x)^(1/length(x))
  }
}
average(1:10,type="grithmetric")

#creat a default type

average=function(x,type="geometric")
{
  if (type=="grithmetric") {
    sum(x)/length(x)
  } else if (type=="geometric")
  {
    prod(x)^(1/length(x))
  }
}
average(1:10)


#05-10-2023
#apply functions and loops

#create an example function
mult.2=function(x) x*2
mult.2(1242)

#use sapply() to apply this function to a set of numbers

#take integers from 1 to 5, and multiply each by 2
sapply(1:5,mult.2)

v=c(1,2,3)

sapply(1:5, function(x) x*v)

lapply(1:5, function(x) x*v)

iris.list=split(iris, iris$Species)
iris.list
spp.mods=lapply(iris.list, function(x) lm(Petal.Length~Sepal.Length, data=x))
spp.mods
spp.mods.summary=lapply(spp.mods, function(x) summary(x))
spp.mods.summary
sapply(spp.mods.summary, function(x) x$coefficients[2,1])


m=matrix(1:20, nrow=5, byrow=TRUE)
m
apply(m,1,sum) #sum the rows
apply(m,2,sum) #sum the columns
apply(m,1,function(x) x)
apply(m,2,function(x) x)

apply(m,c(1,2),function(x) x)

library(ggplot2)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~Species)

times=5
m=matrix(nrow=times,ncol=10)
for (i in 1:times)
{
  m[i,]=(1:10)*i
}
m

sample(1:10, 10, replace = T)

obs.mean=mean(mtcars$mpg)

samp.mean=vector(length = 100)

samp.mean
obs.mean

hist(samp.mean)
abline(v=obs.mean,col="red")

#10-10-2023
rnorm(100)

r=rnorm(100)
hist(r)

#make the random sample repeatable
set.seed(20)
r=rnorm(100)
hist(r)

u=runif(100)
hist(u)

#sample from binomial distribution
#do 100 iterations of 1 coin flip with equal probability of getting 0 or 1
b=rbinom(100,1,prob = c(0.5,0.5))
b
sum(b)/length(b)


set.seed(2)
flip=100
coin4=rbinom(100, 1, prob=0.25)
table(coin4)

set.seed(2)
flips=100
coin2=rbinom(10, flips, prob=0.5)
coin2

#install.packages("primer")
#install.packages("RColorBrewer")
library(primer)
library(RColorBrewer)

N0 = 100
lambda = 1.5
t = 0:10
N = N0 * lambda^t
round(N, 0)
plot(t, N, type = "o", pch = 19, las = 1)
plot(t, N, type = "o", log = "y", pch = 19, las = 1)

layout(matrix(c(1, 2), nrow = 2))
par(mar = c(0.5, 4, 4, 4))
plot(t, N, type = "o", pch = 19, las = 1, xaxt = "n", main = "Population Growth on Two Scales")
axis(side = 1, labels = F)
par(mar = c(4, 4, 0.5, 4))
plot(t, N, type = "o", log = "y", pch = 19, las = 1)

layout(matrix(c(1, 2), nrow = 1))
par(mar = c(4, 4, 2, 0.5))
plot(t, N, type = "o", pch = 19, las = 1)

par(mar = c(4, 4, 2, 0.5))
plot(t, N, type = "o", log = "y", pch = 19, las = 1)
axis(side = 2, labels = F)

N0 = 100
lambda = seq(0.6, 1.4, 0.2)
t = 0:10
N = sapply(lambda, function(lambda) N0 * lambda^t)
N
matplot(t, N, las = 1)

colors = brewer.pal(5, "Set1")
matplot(t, N, type = "o", las = 1, pch = 1:5, col = colors, lty = 1:5)
legend("topleft", legend = c("0.6", "0.8", "1", "1.2", "1.4"),
       title = "lambda", pch = 1:5, lty = 1:5, col = colors, cex = 0.8)

colors = brewer.pal(5, "Set1")
matplot(t, N, type = "o", las = 1, pch = 1:5, col = colors, lty = 1:5,
        log = "y", yaxt = "n")
marks = c(1, 5, 10, 50, 100, 500, 1000)
axis(side = 2, at = marks, labels = format(marks, drop0trailing = TRUE),
     las = 1)
legend("bottomleft", legend = c("0.6", "0.8", "1", "1.2", "1.4"),
       title = "lambda", pch = 1:5, lty = 1:5, col = colors, cex = 0.8)


N0 = 100  #initial population size
times = 20  #number of years into the future
N = vector(length = times)  #empty vector to store pop. sizes
N[1] = N0  #initial population size should be the first N
lambda = 1.2  #growth rate
# start loop: Take previous year's N and multiply by lambda
for (t in 2:times) {
  N[t] = N[t - 1] * lambda
}
plot(1:times, N, type = "o", las = 1)

# multiple simulations
set.seed(2)
sims = 10
times=20
outmat = sapply(1:sims, function(x) {
  times = 20
  N0 = 100
  N = vector(length = times)
  N[1] = N0
  lambda = rlnorm(times - 1, meanlog = 0, sdlog = 0.1)
  for (t in 2:times) {
    N[t] = N[t - 1] * lambda[t - 1]
  }
  N
})
matplot(1:times, outmat, type = "l", las = 1, ylab = "Population Size",
        xlab = "Years")
abline(h = 100, lty = 2)


#10-19-2023
library(lubridate)
library(tidyverse)

presidential

presidential$end-presidential$start

write.csv(presidential,"./Huang_Fan/presidential.csv")

pres.dat=read.csv("./Huang_Fan/presidential.csv")
pres.dat

class(pres.dat$start)
pres.dat$end-pres.dat$start

##convert datas-as-characters into date format
new.start=as.Date(pres.dat$start,format = "%Y-%m-%d")
new.end=as.Date(pres.dat$end,format = "%Y-%m-%d")
new.end-new.start

as.Date(pres.dat$start,format = "%y-%m-%d")

#lubridate version
ymd(pres.dat$start)
ymd(pres.dat$end)-ymd(pres.dat$start)

as.Date("05/17/1978",format="%m/%d/%Y")

filename="data_20220927.csv"

a=gsub("data_","",filename)
b=gsub(".csv","",a)
b

filename %>%
  str_replace("data_","") %>%
  str_replace(".csv","") %>%
  ymd()

who
head(who)
?who
#isolating important files
who_long=who %>%
  pivot_longer(c(-country, -iso2, -iso3, -year))
who_long %>% pull(name)%>% unique()

#how to extract information from data
#can bet sex as the 8th character
who_long %>% pull(name)%>% str_sub(start=8, end = 8)

#creating variable called sex
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))

#get the method of diagnosis
who_long %>% pull(name)%>% str_sub(start = 4, end = 6)%>%
  str_replace("_","")
#add new variables to who_long
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))%>%
  mutate(method=str_sub(name, start=4, end = 6)%>%
           str_replace("_", ""))

#get age class
who_long%>% pull(name) %>%
  str_sub(start = 9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+") %>%
  as.factor()

who_use=who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))%>%
  mutate(method=str_sub(name, start=4, end = 6)%>%
           str_replace("_", ""))%>%
  mutate(age=  str_sub(name, start = 9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "15-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>%
           as.factor())

ggplot(who_use %>% filter(iso3=="USA") %>% filter(method=="sp") %>% filter(sex=="m"), aes(x=year, y=value, color=age))+
  geom_point()+
  geom_line()

