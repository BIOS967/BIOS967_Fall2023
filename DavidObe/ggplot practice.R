library(ggplot2)
library(MASS)
?mtcars
head(mtcars)
plot(mpg~wt, data = mtcars, pch=19)
lm(mpg~wt, data = mtcars)
lm.mod=lm(mpg~wt, data = mtcars)
summary(lm.mod)
ggplot(mtcars, aes(x=wt, y=mpg))+geom_point()+geom_smooth(method = "lm")
ggplot(mtcars, aes(x=wt, y=mpg))+ geom_point(size=4, color="tomato")+geom_smooth(method="lm", se=FALSE, color="tomato")+theme_classic()+ylab("Miles Per Gallon") + xlab("Vehicle Weight")
lm.mod = lm(mpg~wt, data = mtcars) #fit the linear model
xv=seq(min(mtcars$wt), max(mtcars$wt), length=2) #set a series of values along the x-axis
yv= predict(lm.mod, data.frame(wt=xv)) #`use predict() to get what the y-axis value should be along each of those x-axis values`
plot(mpg~wt, data=mtcars, pch=19) #plot the scatterplot
line(xv,yv) #add the fit line
lm.fit=lm(mpg~wt, mtcars)
glm.fit=glm(mpg~wt, mtcars, family = "gaussian")
summary(lm.fit)
summary(glm.fit)
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method = "glm", method.args=list(family="gaussian"))
#ANOVA
class(mtcars$vs)
class(factor(mtcars$vs))
plot(mpg~factor(vs), data=mtcars)
ggplot(mtcars, aes(x=factor(vs), y=mpg)) +
  geom_boxplot()
aov.mod = aov(mpg~factor(vs), data = mtcars)
summary(aov.mod)
lm.mod2 = lm(mpg~factor(vs), data=mtcars)
lm.mod2
summary(lm.mod2)
aov(lm.mod2)
anova(lm.mod2)
glm.mod2=glm(mpg~factor(vs), data=mtcars, family = "gaussian")
anova(glm.mod2, test = "F")
#multivariate predictions
ggplot(mtcars, aes(x=wt, y=mpg, color=factor(vs)))+
  geom_point()+
  scale_color_discrete(name="Engine Shape", labels=c("v-shape", "straight"))+
  ylab("Miles per Gallon")+
  xlab("Vehicle Weight")
theme_bw()+
  geom_smooth(method = "lm")

lm.mod3=lm(mpg~wt + factor(vs), data=mtcars)
anova(lm.mod3)
lm.mod4=lm(mpg~wt*factor(vs), data = mtcars)
anova(lm.mod4)


#Logistic regression
diamonds
diamonds$expensive=diamonds$price>= 10000
diamonds$expensive = diamonds$expensive + 0
glm.fit = glm(expensive~carat, data=diamonds)
summary(glm.fit)
anova(glm.fit, test = "F")
#how to visualize regression
ggplot(diamonds, aes(x=carat, y=expensive+0)) +
  geom_point() +
  geom_smooth(method = "glm", method.args = list(family="binomial"))

head(snails)
count.fit=glm(Deaths~Temp, data=snails, subset=which(Exposure>=3), family="poisson")
summary(count.fit)

ggplot(snails[which(snails$Exposure>=3),], aes(x=Temp, Deaths)) +
  geom_count() +
  geom_smooth(method = "glm", method.args=list(family="poisson"))

prop.fit=glm(cbind(Deaths, N)~Temp, data=snails, subset=which(Exposure>=3), family = binomial(link="logit"))
summary(prop.fit)
