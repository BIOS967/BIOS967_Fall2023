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

