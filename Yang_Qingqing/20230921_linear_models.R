#September 21, 2023

library(ggplot2)
library(MASS)

#Motor trend car road tests
mtcars
?mtcars
#plot relationship between car weight vs mpg using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point()

#use a simple linear regression to model mpg using car weight
lm(mpg~wt, data=mtcars)

#workflow: fit the model and then look at summary output
fit <- lm(mpg~wt, data=mtcars)
summary(fit)

#display best fit line on scatterplot using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="lm") #by default, ggplot gives best fit line and confidence interval

#mess with figure format
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point(color="cadetblue1") +
  geom_smooth(method="lm", color="cyan1", fill="darkturquoise", se=T) + #se=F removes the standard error around the line
  theme_dark() +
  xlab("Weight") +
  ylab("Mileage")

#methods="lm" in the geom_smooth() function means use a linear model fit line, but you can use other types of fit lines like loess
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method="loess") +
  theme_bw() +
  xlab("Weight") +
  ylab("Miles per gallon")

#Using GLM (generalized linear model) instead of LM
gfit <- glm(mpg~wt, family = gaussian, data = mtcars)
summary(gfit)


#try ANOVA
#use the "vs" variable for engine shape
mtcars$vs #0 is v-shaped and 1 is straight
#plot how mpg differs between engine types
#we need to treat vs as a factor
ggplot(data=mtcars, mapping=aes(x=factor(vs), y=mpg)) +
  geom_boxplot()
#run ANOVA to test the difference in mileage between engine shapes
aov.fit <- aov(mpg~factor(vs), data=mtcars)
summary(aov.fit)

#you can run this as a linear model, but it will give different coefficients
lm.fit <- lm(mpg~factor(vs), data=mtcars)
summary(lm.fit) #get same p value with different coefficients

#but you can call the ANOVA results from a linear model fit
anova(lm.fit) #same results as with aov


#linear models with multiple predictor variables and interactions (weight and type of engine)
lm.fit2 <- lm(mpg~wt+factor(vs), data=mtcars)
anova(lm.fit2)
#with the interaction
lm.fit3 <- lm(mpg~wt*factor(vs), data=mtcars)
anova(lm.fit3)

#let's look at the interaction effect visually
ggplot(data=mtcars, mapping=aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")
#this does analysis of covariance