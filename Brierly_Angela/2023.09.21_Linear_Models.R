## 2023.09.21  LINEAR MODELS IN R

library(ggplot2)
library(MASS)

mtcars  #dataset
?mtcars  #gives details of the dataset

# plot relationship between wight of car and mpg UsING GGPLOT

ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point()

# use SIMPLE LINEAR REGRESSION
lm(mpg~wt, data=mtcars)

# Workflow-FIT THE MODEL, then look at SUMMARY OUTPUT
lm.mod=lm(mpg~wt, data=mtcars)
summary(lm.mod)

# Display BEST FIT LINE on a SCATTERPLOT using ggplot
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

# Play aroudn with FIGURE FORMAT
# method="lm" is geom_smooth() function means use a linear model fit line.
# But other fit lines, like '"loess" are available.
ggplot(mtcars, mapping=aes(x=wt, y=mpg)) +
  geom_point() +
  geom_smooth(method = "lm", color="red", se=F)  +   #se=F remove or add the shading aroudn the line
  theme_bw() +
  xlab("Weight") +
  ylab("Miles per Gallon")


#_______________________________________________________________
## Using "GLM" GENERALIZED LINEAR MODEL instead of "lm"

gl.model=glm(mpg~wt, family = gaussian, data=mtcars)
summary(gl.model)


## ANOVA and converting data into a FACTOR
mtcars$vs  # look at a BINARY variable on dataset "mtcars", but I want to convert it into a FACTOR

ggplot(data = mtcars, mapping = aes(x=factor(vs), y=mpg)) +
  geom_boxplot()


##run ANOVA using "aov()" ...the anova() function is used for diff context)
aov.model=aov(mpg~factor(vs), data=mtcars)
summary(aov.model)

#you can run the same model as a linear model lm(), but it will give you diff sets of coefficients.
lm.model=lm(mpg~factor(vs), data=mtcars)
summary(lm.model)

# BUT, you can CALL the ANOVA results from a linear model fit
anova(lm.model)


##LINEAR model with MULTIPLE predictor variables (i.e. weight+engine)
lm.model2=lm(mpg~wt+factor(vs), data=mtcars)
anova(lm.model2)

lm.model3=lm(mpg~wt*factor(vs), data=mtcars)
anova(lm.model3)

# INTERACTION EFFECT- how weight effects mpg, depends on type of engine
# ANALYSIS OF COVARIANCE!!!!!
ggplot(data=mtcars, mapping = aes(x=wt, y=mpg, color=factor(vs))) +
  geom_point() +
  geom_smooth(method="lm")
