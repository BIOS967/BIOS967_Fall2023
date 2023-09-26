#September 21st, 2023
library(ggplot2)
library(MASS)

mtcars

#plot relationship between weight of car and mpg using ggplot

ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point()

#use a simple linear regression
lm(mpg~wt, data=mtcars)

#workflow: 1) fit the model, 2) then look at summary output
fit=lm(mpg~wt, data=mtcars)
summary(fit)

#display best fit line on scatterplot using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method='lm')

#play around with figure format
#se = F removes the shading for the standard error around the line
#methods = "lm" in the geom_smooth() function means use a linear model fit line. But you can use other types of fit lines, like loess
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method='lm', color="black", se=FALSE) +
  theme_bw() +
  xlab("Weight") +
  ylab("Miles per Gallon")

#Using GLM (generalized linear model) instead of LM
gfit=glm(mpg~wt, family=gaussian, data=mtcars)
summary(gfit)

#let's use the "vs" variable
mtcars$vs

ggplot(data=mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()

#run ANOVA using aov()
aov.fit=aov(formula=mpg~factor(vs), data=mtcars)
aov.fit
summary(aov.fit)

#you CAN run this same model as a linear model lm(), but it wil give you different sets of coefficients
lm.fit=lm(formula=mpg~factor(vs), data=mtcars)
summary(lm.fit)

#BUT, you can call the ANOVA results from a linear model fit
anova(lm.fit)

#linear model with multiple predictor variables
lm.fit2=lm(mpg~wt+factor(vs), data=mtcars)
anova(lm.fit2)

#linear model with multiple predictor variables AND interactions
lm.fit3=lm(mpg~wt*factor(vs), data=mtcars)
anova(lm.fit3)

#let's look at the interaction effect visually
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")
