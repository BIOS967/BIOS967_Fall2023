#20230921
library(ggplot2)
library(MASS)

mtcars
?mtcars

#plot relationship between weight of car and mpg
#using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point()
#use simple linear regression
lm(mpg~wt, data=mtcars)

#workflow: fit the model, then look at summary output
fit=lm(mpg~wt, data=mtcars)
summary(fit)

#display best fit line on scatterplot using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm")

#playing around with figure format
#method="lm"in the geom_smooth() function means use a linear model fit line, But you can us other types of fit lines, like loess
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm", color="black", se=FALSE) +
  theme_bw() +
  xlab("weight") +
  ylab("Miles per gallon")


###using GLM instead of lm
gfit=glm(mpg~wt, family=gaussian, data=mtcars)
summary(gfit)
summary(fit)


#let's use vs variable -> code it as a factor
mtcars$vs
ggplot(data=mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()

#run ANOVA using aov()
aov.fit=aov(mpg~factor(vs), data=mtcars)
summary(aov.fit)

#you CAN run this same model as a lm,  but it will give you different sets of coeffocicients
lm.fit=lm(mpg~factor(vs), data=mtcars)
summary(lm.fit)

#But, you can call the ANOVA results from a linear model fit
anova(lm.fit)

#linear model with multiple predictor variables AND interactions
lm.fit2=lm(mpg ~ wt + factor(vs), data=mtcars )
anova(lm.fit2)
lm.fit3=lm(mpg ~ wt*factor(vs), data=mtcars )
anova(lm.fit3)

#let's look at the interaction effects visually
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")
#You just did ANCOVA!