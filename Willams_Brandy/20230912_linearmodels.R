library(ggplot2)
library(MASS)

mtcars
?mtcars

#plot relationship between car wt and mpg using ggplot

ggplot(mtcars,mapping=aes(x=wt,y=mpg))+
  geom_point()

#use simple linear regression
lm(mpg~wt,data=mtcars)

#workflow:fit the model then look at summary output
fit=lm(mpg~wt,data=mtcars)
summary(fit)

#Display best fit line on scatterplot using ggplot
ggplot(mtcars,mapping=aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method="lm")

#play around with format
#method="lm" in geom_smooth means a linear model fit, but you can use other fit lines, like loess
ggplot(mtcars,mapping=aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method="lm", color="black", se=F)+#se=F removed shading
  theme_bw()+
  xlab("Weight")+ylab("Miles per Gallon")

#loess
ggplot(mtcars,mapping=aes(x=wt,y=mpg))+
  geom_point()+
  geom_smooth(method="loess", color="orange", se=F)+#se=F removed shading
  theme_bw()+
  xlab("Weight")+ylab("Miles per Gallon")

#using generalized linear models (glm) instead of lm
gfit=glm(mpg~wt, family=gaussian, data=mtcars)
summary(gfit)

#use "vs" variable
mtcars$vs

ggplot(data=mtcars,mapping=aes(x=factor(vs),y=mpg)) +
  geom_boxplot()

#Run ANOVA using aov()
aov.fit=aov(mpg~factor(vs), data=mtcars)
summary(aov.fit)

#run the same model as a linear model, but it'll give you dif sets of coefficients
lm.fit=lm(mpg~factor(vs), data=mtcars)
summary(lm.fit)
#BUT, you can call the ANOVA results from a lm fit
anova(lm.fit)

#linear model with multiple predictor variables
lm.fit2=lm(mpg~wt+factor(vs),data=mtcars)
anova(lm.fit2)

#look at interaction effect visualy
ggplot(data=mtcars,mapping=aes(x=wt, y=mpg, color=factor(vs)))+
  geom_point() +
  geom_smooth(method="lm")






