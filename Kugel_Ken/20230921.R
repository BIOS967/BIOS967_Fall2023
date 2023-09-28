# September 21st 2023
# Ken Kugel

# Linear Models
# Intro on how to do stats on R (Not an intro to stats)

#Packages Needed:

#install.packages(ggplot2)
library(ggplot2)
#install.packages(MASS)
library(MASS)

#Generally data you will have: Numbers and Factors
# Factors are categories
# Numbers can be continuous, bivariate/binary, counts of things, proportions of things

# Different data has different expectations (ie- continuous is expected to be normal curve; etc)
# X axis = independent or predictor variable
# y axis = dependent or response variable

#continuous vs binary --> logistic regression

# categorical or factor vs continuous --> ANOVA or t-test

mtcars
#Plot relationship between weight of car and mpg
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg))+
  geom_point()

#use a simple linear regression
lm(formula = mpg~wt,data= mtcars)

#Workflow: fit the model, then look at summary output

fit=lm(formula = mpg~wt,data= mtcars)

summary(fit)

#Now lets visualize the linear model on our graph

ggplot(mtcars, mapping = aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method="lm")

#now lets play

ggplot(mtcars, mapping = aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method="lm",color="red",se=F)+
  theme_bw()+
  xlab("Weight")+
  ylab("MPG")

#Different type of fit line
ggplot(mtcars, mapping = aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method="loess",color="red",se=F)+
  theme_bw()+
  xlab("Weight")+
  ylab("MPG")

#lm function can only handle continuous vs continuous
#Luckily we can use glm (generalized linear model)

gfit=glm(mpg~wt,family= gaussian ,data=mtcars)
summary(gfit)


#Now lets do an ANOVA
str(mtcars$vs)

ggplot(data=mtcars,mapping=aes(x=vs, y=mpg))+
  geom_boxplot()

ggplot(data=mtcars,mapping=aes(x=factor(vs), y=mpg))+
  geom_boxplot()
#Can we change the 0 and 1 here?

#Run ANOVA using aov()
aov.fit =aov(mpg~factor(vs), data= mtcars)
summary(aov.fit)

#You CAN run a same model as a linear model, but it will give you different sets of coefficients
lm.fit=lm(mpg~factor(vs), data= mtcars)
summary(lm.fit)


#BUT you can call ANOVA results from a linear model
anova(lm.fit)


#Linear model with multiple predictor variables
lm.fit2=lm(mpg~wt+factor(vs), data= mtcars)
anova(lm.fit2)

#Interaction effects
lm.fit3=lm(mpg~wt*factor(vs), data= mtcars)
anova(lm.fit3)

#But what does this interaction effect look like???

ggplot(data=mtcars, mapping=aes(x=wt,y=mpg, color=factor(vs)))+
  geom_point()

ggplot(data=mtcars, mapping=aes(x=wt,y=mpg, color=factor(vs)))+
  geom_point()+
  geom_smooth(method="lm")  #interaction effect is basically the difference in the slope of the two lines!