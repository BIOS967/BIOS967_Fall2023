##Bowden worked example##
## Butterfly body size vs. climate change ##

boloria = read.csv("data/boloria.csv") #../data/boloria will fix the problem if we're not nested in the right folder, this sends R backwards
#boloria

colias = read.csv("data/colias.csv")
#colias

library(tidyverse)
library(cowplot)

#this separates the data we want, creating means from the tables)
#organize the yearly climate data

year.dat = boloria %>%
  group_by(year) %>%
  summarize(snow = mean(snow), mayjun = mean(mayjun), mayaug.1 = mean(mayaug.1))

#FIGURE 1

#plot snowmelt day of year (DOY) across years
p1 <- ggplot(year.dat, aes(x = year, y = snow)) +
  geom_point() + #puts the points on the graph
  #geom_smooth(method="lm") #puts the line of best fit
  geom_smooth(method="lm", se=F, color="black") + #puts the line of best fit
  #theme_cowplot() #sets the theme, cowplot is simple
  theme_bw() +
  labs(y="Snowmelt (DOY)", x = "Year")
p1

#plot may through june temperature of current year across time
p2 <- ggplot(year.dat, aes(x = year, y = mayjun)) +
  geom_point() + #puts the points on the graph
  #geom_smooth(method="lm") #puts the line of best fit
  geom_smooth(method="lm", se=F, color="black") + #puts the line of best fit
  #theme_cowplot() #sets the theme, cowplot is simple
  theme_bw() +
  labs(y=expression(paste("Average Temperature" ["t"], " ", (~degree*C))))
p2
#paste function allows you to paste together multiple characters paste("a", "c", sep="-") will return "a-c"

#plot may through june temperature of previous year across time
p3 <- ggplot(year.dat, aes(x = year, y = mayaug.1)) +
  geom_point() + #puts the points on the graph
  #geom_smooth(method="lm") #puts the line of best fit
  geom_smooth(method="lm", se=F, color="black") + #puts the line of best fit
  #theme_cowplot() #sets the theme, cowplot is simple
  theme_bw() +
  labs(y=expression(paste("Average Temperature" ["t"], " ", (~degree*C))))
p3

#plot them as 3 panels arranged vertically
plot_grid(p1, p2, p3, align="v", nrow=3)

#fit linear model to climate data
fit.snow=lm(snow~year, data=year.dat)
summary(fit.snow)

fit.mayjun=lm(mayjun~year, data=year.dat)
summary(fit.mayjun)


#FIGURE 2
year.dat #climate variables for each year
colias #species data
boloria #species data

#getting average and standard error of wing length for each sex of each species for each year
wl.colias = colias %>%
  group_by(year, sex) %>%
  summarize(mean_se(WL)) #summarize(mean_se(WL)) calculates mean and standard error at same time

p2.a <- ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(aes(fill=sex), pch=21) + #plots the points
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) + #we defined error bars in summarize(mean_se(WL)
  theme_bw() + theme(legend.position="none") #creates a theme and removes the legend

#p2.a

wl.boloria = boloria %>%
  group_by(year, sex) %>%
  summarize(mean_se(WL)) #summarize(mean_se(WL)) calculates mean and standard error at same time

p2.b <- ggplot(wl.boloria, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(aes(fill=sex), pch=21) + #plots the points
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) + #we defined error bars in summarize(mean_se(WL)
  theme_bw() + theme(legend.position="none") #creates a theme and removes the legend

p2.b

#for figure 2 panels c and d, we need to merge together theyearly winglength data and yearly climate data. We can do that using a "join" funciton

year.dat
wl.colias
#creates a data frame that has "all of it" winglength mean, standard error, and climate variable, all for that year
wl.colias2 = left_join(wl.colias, year.dat, by=join_by(year==year))

p2.c <- ggplot(wl.colias2, aes(x=mayaug.1, y=y, group=sex)) +
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_smooth(method="lm", se=F, color="black") +
  theme_bw()

wl.boloria2 = left_join(wl.boloria, year.dat, by=join_by(year==year))

p2.d <- ggplot(wl.boloria2, aes(x=mayaug.1, y=y, group=sex)) +
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_smooth(method="lm", se=F, color="black") +
  theme_bw()

plot_grid(p2.a, p2.c, p2.b, p2.d, nrow=2)