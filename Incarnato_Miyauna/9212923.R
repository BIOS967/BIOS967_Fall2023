#september 21, 2023

#you have two kinds of data: Numbers(contiunous, binary, counts, proportion)
# and Factors/catergories

library(ggplot2)
library(MASS)
mtcars

#plot relationship b/t weight and and mpg using ggplot

ggplot(mtcars,mapping=aes(x=wt, y=mpg))+
  geom_point()
#use simple linear regression
lm(mpg~wt, data=mtcars)

#workflow:fit the model, check output
fit=lm(mpg~wt, data=mtcars)
summary(fit)

#display bes tfit line on scatterplot using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="loess", color="pink", se=FALSE) +
  theme_bw() +
  xlab("Weight") +
  ylab("Miles per Gallon")

#using GLM
gift=glm(mpg~wt,family=gaussian, data=mtcars)
summary(gift)

#anova
mtcars$vs

ggplot(data=mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()

#run anova using aov()
aov.fit=aov(mpg~factor(vs), data=mtcars)
summary(aov.fit)

#or...
lm.fit=lm(formula=mpg~factor(vs), data=mtcars)
summary(lm.fit)

#call anova results from linear fit
anova(lm.fit)

#linear model with multiple predictor variables
lm.fit2=lm(mpg~wt+factor(vs), data=mtcars)
anova(lm.fit2)

#above and interactions
lm.fit3=lm(mpg~wt*factor(vs), data=mtcars)
anova(lm.fit3)

#visulization of the interactions
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")
