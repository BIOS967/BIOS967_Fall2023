#intro to stat
library(ggplot2)
library(MASS)
?mtcars #what is in the data
mtcars

#using ggplot for visualizing the relationship between wt and mpg
ggplot(mtcars, mapping=aes(x=wt, y=mpg))+
  geom_point()

#using linear regression
lm(mpg~wt, data=mtcars)

#worflow: fit the model
lm.fit=lm(mpg~wt, data=mtcars)
summary(lm.fit)

#display best fit line on ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg))+
  geom_point()+
  geom_smooth(method ="lm",color="green", se=F)+ #se=F remove the confidence interval shade. method = lm means linear model, you can also use "loess" which means local regression
  theme_bw() +
  xlab("Weight (kg)")+
  ylab("Miles per gallon")


#GLM as generalized linear model
glm.fit= glm(mpg~wt, data = mtcars, family=gaussian)
summary(glm.fit)


#let's use the "vs" variable
class(mtcars$vs)
class(factor(mtcars$vs))
ggplot(data=mtcars, mapping = aes(x=factor(mtcars$vs), y=mpg))+
  geom_boxplot()

#running ANOVA
aov(mpg~factor(mtcars$vs), data = mtcars)

aov.fit = aov(mpg~factor(mtcars$vs), data = mtcars)
summary(aov.fit)

lm.fit2 = lm(mpg~factor(mtcars$vs), data = mtcars)
summary(lm.fit2)

#You can call anova result from lm
anova(lm.fit2)
lm.fit3=lm(mpg~wt+factor(vs), data = mtcars)
anova(lm.fit3)

#interaction effect between two variables
lm.fit3=lm(mpg~wt*factor(vs), data = mtcars)
anova(lm.fit3)

#lets look at the interaction effect graphically
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg, color = factor(vs)))+
  geom_point()+
  geom_smooth(method = "lm")
