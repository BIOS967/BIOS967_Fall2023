## Bowen worked example

boloria=read.csv("data/boloria.csv")
boloria

colias=read.csv("data/colias.csv")
colias

library(tidyverse)
library(cowplot)

install.packages("cowplot")

year.dat = boloria %>%
  group_by(year) %>%
  summarise (snow=mean(snow), mayjun=mean(mayjun), mayaug.1=mean(mayaug.1))
library(ggplot2)

p1=ggplot(year.dat, aes(x=year, y=snow)) +
  geom_point() +
  geom_smooth(method= "lm", se=F, color= "black")+
  theme_bw()
p1
#plot may-june temperature of current year across time (panel b)
p2=ggplot(year.dat, aes(x=year, y=mayjun)) +
  geom_point() +
  geom_smooth(method= "lm", se=F, color= "black")+
  theme_bw()
labs(y=expression(paste("average temperature"[t]," ", (~degree*C))))

#plot may-june temperature of current year across time (panel b)
p3=ggplot(year.dat, aes(x=year, y=mayjun)) +
  geom_point() +
  geom_smooth(method= "lm", se=F, color= "black")+
  theme_bw()

#now plot them as 3 panels, and
plot_grid(p1,p2,p3,align = "v", nrow =3)

#fit linear models to climate data
fit.snow=lm(snow~year, data = year.dat)
  summary(fit.snow)

fit.mayjun=lm(mayjun~year, data = year.dat)
summary(fit.mayjun)

## recreate figure 2
year.dat # climate variable for each year
colias
boloria

#getting average and standard error of wing length for each sex of each species fir each year

wl.colias=colias %>% group_by(year, sex) %>% summarise(mean_se(WL))

p1.b=ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path()+
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax))+
  theme_bw() +
  theme(legend.position = "none")

p2.b=ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path()+
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax))+
  theme_bw() +
  theme(legend.position = "none")
p2.b
#for figure 2 panels c and d, we need to merge together the yearly wing length data and yearly climate data. We can do that using a "join" function

year.dat
wl.colias

wl.colias=left_join(wl.colias, year.dat, by=join_by(year==year))


p2.d=ggplot(wl.colias,aes(x=mayaug.1, y=y, group=sex)) +
  geaom_point(aes(fill=sex),pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_smooth(method = "lm", se=F, color="black") +
  theme_bw()

plot_grid(p2.a, p2.c,p2.b, p2.d, nrow=2)

