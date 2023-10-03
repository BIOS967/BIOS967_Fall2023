#Bowden worked example
boloria=read.csv("data/boloria.csv")
boloria

colias=read.csv("data/colias.csv")
colias
library(tidyverse)
library(cowplot)

#group repetative variables
year.dat=boloria %>% group_by(year) %>% summarise(snow=mean(snow),mayjun=mean(mayjun),
  mayaug.1=mean(mayaug.1))

#plot snow melt DOY across years
p1=ggplot(year.dat,aes(x=year,y=snow))+
  geom_point() +
  geom_smooth(method ="lm", se=F, color="black") +
  theme_cowplot()
p1#name plots

#plot may-jun temp of current yr across time
p2=ggplot(year.dat,aes(x=year,y=mayjun))+
  geom_point() +
  geom_smooth(method ="lm", se=F, color="black") +
  theme_cowplot()
p2
#add lables
p2=ggplot(year.dat,aes(x=year,y=mayjun))+
  geom_point() +
  geom_smooth(method ="lm", se=F, color="black") +
  theme_cowplot()+
  labs(y=expression(paste("Average Temperature" ["t"],"",(~degree*C))))

p2

#Plot may-jun temp of current yr across time
p3=ggplot(year.dat,aes(x=year,y=mayaug.1))+
  geom_point() +
  geom_smooth(method ="lm", se=F, color="black") +
  theme_cowplot()
p3

#Now plot them as 3 panels, arranged vertically
plot_grid(p1,p2,p3, align="V", nrow=3)

#fit linear models to climate data
fit.snow=lm(snow~year,data=year.dat)
summary(fit.snow)

fit.mayjun=lm(mayjun~year,data=year.dat)
summary(fit.mayjun)

#recreate figure 2
year.dat#climate variable for ea yr
colias
boloria

#getting avg and stderror of wing length for ea sex of ea species for ea yr

colias %>% group_by(year,sex) %>% summarise(mean_se(WL))

