##September21,2023

library(gglot2)
#install.packages("MASS")
library(MASS)

mtcars
?mtcars

#plot relationship between weight of car mpg
#using ggplot

ggplot(mtcars, mapping=aes(x=wt, y=mpg))+
  geom_point

#use simple linear regression
lm(mpg~ wt, data =mtcars)

#workflow: fit the model, the look at summary output
fit=lm(mpg~wt, data =mtcars)
summary(fit)

#display best fit line on scatter plot using ggplot
library(ggplot2)
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm", color="black", se=F) +
  theme_bw() +
  xlab("Weight") +
  ylab("Miles per Gallon")

##using GLM (generalized linear model) instead of LM
gfit=glm(mpg~wt, family=gaussian, data =mtcars)
summary(gfit)

#let's use the "vs" variable
mtcars$vs

ggplot(data =mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()

#run ANOVA using aov ()
aov.fit=aov(formula=mpg~factor(vs), data =mtcars)
summary(aov.fit)

#you CAN run this same model as a linear model lm(), but it will give you different sets of coefficients
lm.fit=lm(formula=mpgfactor(vs), data =mtcars)
summary(lm.fit)

#b=But, you can call the ANOVA results from a linear model fit
anova(lm.fit)

#linear model with multiple predictor variables

lm.fit2=lm(mpg~wt+factor(vs), data=mtcars)
anova(lm.fit2)

#linear model with multiple predictor variables AND interactions
lm.fit3=lm(mpg~wt*factor(vs), data =mtcars)
anova(lm.fit3)

#let's look at the interaction effect visually
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")

