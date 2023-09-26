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