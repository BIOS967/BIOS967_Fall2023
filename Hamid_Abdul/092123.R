#Class 09212023
library(ggplot2)
library(MASS)
mtcars
?mtcars

#plot relationship between weight of car and mpg using ggplot

ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point()

#use a simple linear regression
lm(mpg~wt, data=mtcars)

#workflow : fit the model , then look at summery output
fit=lm(mpg~wt, data=mtcars)
summary(fit)

#display best fit line on scatterplot using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm")

#play around with figure format
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm", color='cyan', se=T) +
  theme_bw() +
  xlab("Weight") +
  ylab("Miles Per Gallon")

#method="lm" in geom_smooth function means use a linear model fit line but you can use other types of fit lines, like loess
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="loess", color='cyan', se=T) +
  theme_bw() +
  xlab("Weight") +
  ylab("Miles Per Gallon")

#suing GLM (Gernalized linear model) insted of LM
gfit=glm(mpg~wt, family=gaussian, data=mtcars)
summary (gfit)

#let's use th eVS Variable
mtcars$vs
ggplot(data=mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()

#run ANOVA using aov()
aov.fit=aov(mpg~factor(vs),data=mtcars)
summary(aov.fit)

#you can run this same model as a linear model lm(), but it will give you different set of coefficients

lm.fit=lm.fit=aov(mpg~factor(vs),data=mtcars)
summary(lm.fit)

#BuT, you can call the ANOVA results from a linear model fit
anova(lm.fit)

glm.mod2=glm(mpg~factor(vs), data=mtcars, family="gaussian")
anova(glm.mod2, test="F")

# linear model with multiple predictor variable and interactions

lm.fit2=lm(mpg~wt+factor(vs), data=mtcars)
anova(lm.fit2)

# linear model with multiple predictor variable and interactions

lm.fit3=lm(mpg~wt*factor(vs), data=mtcars)
anova(lm.fit3)


#lets look at the interaction effect visually
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")
