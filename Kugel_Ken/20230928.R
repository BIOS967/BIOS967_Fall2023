# September 28th 2023
# Plotting Change of Butterfly size with Climate Change
# Lets recreate publication quality figures!


#Libraries

library(tidyverse)
library(cowplot)

boloria= read.csv("data/boloria.csv")
boloria

colias= read.csv("data/colias.csv")
colias

#Figure 1: Plotting three graphs in one panel
  #snow melt over years

year.dat =boloria %>% group_by(year) %>% summarise(snow=mean(snow), mayjun= mean(mayjun), mayaug.1=mean(mayaug.1))

ggplot(year.dat, aes(x=year, y=snow))+
  geom_point()

#Now lets make it quality

p1= ggplot(year.dat, aes(x=year, y=snow))+
  geom_point()+
  geom_smooth(method="lm", se=F, color="black")+
  theme_cowplot()+
  labs(y="Snowmelt (DOY)", x="Year")

p2= ggplot(year.dat, aes(x=year, y=mayjun))+
  geom_point()+
  geom_smooth(method="lm", se=F, color="black")+
  theme_cowplot()+
  labs(y=expression(paste("Average Temperature"["t"]," ",(~degree*C)))) #Come back to this

p3= ggplot(year.dat, aes(x=year, y=mayaug.1))+
  geom_point()+
  geom_smooth(method="lm", se=F, color="black")+
  theme_cowplot()


#Now plot them as three panals vertically
plot_grid(p1,p2,p3, align = "V", nrow = 3)


#fit linear models to climate data
fit.snow = lm(snow~year, data = year.dat)
summary(fit.snow)

fit.mayjun=lm(mayjun~year, data = year.dat)
summary(fit.mayjun)

fit.mayaug.1 = lm(mayaug.1~year, data= year.dat)
summary(fit.mayaug.1)


#Figure 2

#Start by getting the average and std error for each sex of each species of each year

wl.colias=  colias %>% group_by(year, sex) %>% summarise(mean_se(WL))

p2a=ggplot(wl.colias, aes(x=year, y=y, group = sex))+
  geom_errorbar(aes(ymin=ymin, ymax=ymax))+
  geom_path()+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values = c("black","white"))+
  theme_cowplot()+
  theme(legend.position = "none")

wl.boloria= boloria %>% group_by(year,sex) %>%  summarise(mean_se(WL))

p2b=ggplot(wl.boloria, aes(x=year, y=y, group = sex))+
  geom_errorbar(aes(ymin=ymin, ymax=ymax))+
  geom_path()+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values = c("black","white"))+
  theme_cowplot()+
  theme(legend.position = "none")

#for figure 2 panels c and d, we need to put together the WL data with the Climate data
#We have each of them, lets merge it: "join"

wl.climate.colias =left_join(wl.colias, year.dat)
wl.climate.colias

ggplot(wl.climate.colias, aes(x=mayaug.1,y=y, group=sex))+
  geom_point(aes(fill=sex),pch=21)+
  scale_fill_manual(values = c("black","white"))+
  theme_cowplot()+
  theme(legend.position = "none")+
  geom_smooth(method="lm",se=F, color="black")
