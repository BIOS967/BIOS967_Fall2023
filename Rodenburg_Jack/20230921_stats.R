library(ggplot2)
library(MASS)

mtcars

#plot relationship between weight of car and mpg using ggplot

ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point()

#use a simple linear regression to test casuality

lm(mpg~wt, data=mtcars)

#workflow: fit the model, then look at summary output

fit <- lm(mpg~wt, data=mtcars)

summary(fit)

#display best fit line on scattter plot using ggplot
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

#play around with figure format
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method = "lm", color= "blue", se=T) + #se=F removes the shading
  xlab("Weight") +
  ylab("Miles per Gallon")

#method = lm in the geom_smooth() function means use a linear model fit line. But you can use other types of fit
#lines, such as loess ie method = "loess"

#using GLM (generalized linear model) instead of LM

gfit <- glm(mpg~wt, family = gaussian, data = mtcars)
summary(gfit)

#lets use the "vs" variable
mtcars$vs

ggplot(data=mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()

#run ANOVA using aov()
aov.fit = aov(mpg~factor(vs), data=mtcars)
summary(aov.fit)

#you CAN run this same model as a linear model lm(), but it will give you different sets of coefficients
lm.fit = lm(mpg~factor(vs), data=mtcars)
summary(lm.fit)

#BUT you can call the ANOVA results from a linear model fit
anova(lm.fit)

#Linear model with multiple predictor variables
lm.fit2 = lm(mpg~wt + factor(vs), data=mtcars) #compares mpg and wt, mpg and vs and their effect, F value means they're more correlated
anova(lm.fit2)

#Linear model with multiple predictor variables AND interactions
lm.fit3 = lm(mpg~wt*factor(vs), data=mtcars) #how wt effects mpg depends on the engine type
anova(lm.fit3)

ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")

#difference in slope of two lines is interaction effect, ANCOOVA is this type of multivariate