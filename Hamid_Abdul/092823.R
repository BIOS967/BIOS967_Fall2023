#09282023


#bowden worked exapmle

boloria=read.csv("../data/boloria.csv")
boloria

colias=read.csv("../data/colias.csv")
colias

library(tidyverse)
install.packages("tidyverse")
install.packages("cowplot")
library(tidyverse)
library(cowplot)
#organize the yearly climate data
year.dat=boloria %>% group_by(year) %>% summarise(snow=mean(snow), mean.mayjun=mean(mayjun), mean.mayaug=mean(mayaug.1))

#plot snow melt day of year across years
p1=ggplot(year.dat, aes(x=year, y=snow)) +
  geom_point() +
  geom_smooth(method="lm", se=F, color="black") +
  theme_bw() +
  labs(y="snowmelt(DOY)", x=)
p1

#plot may-june temprature of current year across
p2=ggplot(year.dat, aes(x=year, y=mayjun)) +
  geom_point() +
  geom_smooth(method="lm", se=F, color="black") +
  theme_bw() +
  labs(y=expression(paste("Average Temprature"[t]," ", (~degree*C))))
p2


#plot may-june temprature of current year across
p3=ggplot(year.dat, aes(x=year, y=mayaug.1)) +
  geom_point() +
  geom_smooth(method="lm", se=F, color="black") +
  theme_bw()
p3

rlang::last_trace()

#now plot 
plot_grid(p1,p2,p3, align="v, nrow=3")


#figure 2

year.dat
colias
boloria

wl.colias=colias%>%group_by(year, sex) %>% summarise(mean_se(WL))
wl.boloria=boloria%>%group_by(year, sex) %>% summarise(mean_se(WL))


p2.a=ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) +
  theme_bw() +
  theme(legend.position="none")
p2.a


p2.b=ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) +
  theme_bw() +
  theme(legend.position="none")
p2.b

#to merge together climate and winglength data

year.dat
wl.colias


wl.colias=left_join(wl.colias, year.dat, by=join_by(year==year))

ggplot(wl.colias, aes(x=mayaug.1, y=y, group=sex))
