#Working with boloria and colias data
boloria=read.csv("data/boloria.csv")
boloria

colias=read.csv("data/colias.csv")
colias
library(tidyverse)
library(cowplot)
install.packages("cowplot")

#summerise data

year.dat=boloria %>% group_by(year) %>% summarise(snow=mean(snow), mayjun=mean(mayjun), mayaug.1=mean(mayaug.1))
year.dat

#ploting the data day of year across year
p1=ggplot(year.dat, aes(x=year, y=snow)) +
  geom_point()+
  geom_smooth(method = "lm", se=F, color="black")+
  theme_cowplot() + labs(y="snowmelt (DOY)", x=year)
p1
#ploting the data of temperature across time
p2=ggplot(year.dat, aes(x=year, y=mayjun)) +
  geom_point()+
  geom_smooth(method = "lm", se=F, color="black")+
  theme_cowplot()
p2

p3=ggplot(year.dat, aes(x=year, y=mayaug.1)) +
  geom_point()+
  geom_smooth(method = "lm", se=F, color="black")+
  theme_cowplot()+
labs(y=expression(paste("Average Temperature"["t"], " ", (~degree*C))))
p3

plot_grid(p1,p2,p3, align = "v", nrow = 3)

#linear model for climate data
fit.snow= lm(snow~year, data=year.dat)
summary(fit.snow)

fit.mayjun=lm(mayjun~year, data = year.dat)
summary(fit.mayjun)

#climate variable for each year
year.dat #climate variable for each year

#average and SE of wing length for each sex
WL.colias= colias %>% group_by(year, sex) %>% summarise(mean_se(WL))

p2.c=ggplot(WL.colias, aes(x=year, y=y, group=sex))+
  geom_path()+
  geom_point(pch=21, aes(fill=sex))+
  scale_fill_manual(values=c("black", "white"))+
  geom_errorbar(aes(ymin=ymin, ymax=ymax))+
  theme_bw()+
  theme(legend.position = "none")

WL.boloria= boloria %>% group_by(year, sex) %>% summarise(mean_se(WL))
p2.b=ggplot(WL.boloria, aes(x=year, y=y, group=sex))+
  geom_path()+
  geom_point(pch=21, aes(fill=sex))+
  scale_fill_manual(values=c("black", "white"))+
  geom_errorbar(aes(ymin=ymin, ymax=ymax))+
  theme_bw()+
  theme(legend.position = "none")
p2.b

#for 2 panels c and d, we need to put together the yearly winglength data. If data has something income, we can use left join or right join
wl.colias=left_join(WL.colias, year.dat, join_by(year==year))
p2c.1=ggplot(wl.colias, aes(x=mayaug.1, y=y, group=sex))+
  geom_point(aes(fill=sex), pch=21)+
  scale_fill_manual(values=c("black", "white")) +
  geom_smooth(method = "lm", se=F, color="black")+
  theme_bw()
