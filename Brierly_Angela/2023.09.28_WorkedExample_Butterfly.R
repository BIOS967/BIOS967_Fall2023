# 2023.09.28_  Worked example: Bowden butterfly data

boloria=read.csv("data/boloria.csv")
boloria

colias=read.csv("data/colias.csv")
colias

library(tidyverse)
library(cowplot)
# organize the yearly climate data
year.dat=boloria %>%
  group_by(year) %>%
  summarise(snow=mean(snow), mayjun=mean(mayjun), mayaug.1=mean(mayaug.1))

# plot snowmelt day of year (DOY) across years (panel a)
p1=ggplot(year.dat, aes(x=year, y=snow)) +
  geom_point() +
  geom_smooth(method = "lm", se=F, color="black") +
  theme_bw() +
  labs(y="Snowmelt (DOY)", x="Year")
p1

# ploy may-june temperature of current year across time (panel b)
p2=ggplot(year.dat, aes(x=year, y=mayjun)) +
  geom_point() +
  geom_smooth(method = "lm", se=F, color="black") +
  theme_bw() +
  labs(y=expression(paste("Average Temperature"["t"],"", (~degree*C))), x="Year")
p2

# plot may-augtemperature of current year across time (panel c)
p3=ggplot(year.dat, aes(x=year, y=mayaug.1)) +
  geom_point() +
  geom_smooth(method = "lm", se=F, color="black") +
  theme_bw() +
  labs(y=expression(paste("Average Temperature" ["t-1"],"", (~degree*C))), x="Year")
p3

# now plot all three plots
plot_grid(p1, p2, p3, nrow=3)

# fit linear models to climate data
fit.snow=lm(snow~year, data= year.dat)
summary(fit.snow)

fit.mayjun= lm(mayjun~year, data= year.dat)
summary(fit.mayjun)

fit.mayaug.1=lm(mayaug.1~year, data= year.dat)
summary(fit.mayaug.1)

## Recreate FIGURE 2
 year.dat #climate variable for each year
colias
boloria

#getting average and standard error of wind length for each sex of each species for each year. This generates the values for our error bars and stuff we'll add later.

wl.colias=colias %>%
  group_by(year, sex) %>%
  summarise(mean_se(WL))

# lets plot it
p2.b=ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values = c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) +
  theme_bw() +
  theme(legend.position = "none")
p2.b

# for Figure 2 panels c and d, we need to merge together the yearly winglength data and yearly climate data. We cna do that using a "JOIN" fucntion.
year.dat
wl.colias

wl.colias=left_join(wl.colias, year.dat, by=join_by(year==year))
# SOMETHING IS WRONG WITH THE ONE BELOW--SEE Dai's Module!!!
p2.c= ggplot(wl.colias, aes(x=mayaug.1, y=y, group=sex)) +
  geom_point(aes(fill=sex), pch=21) +
  scale_fill_manual(values = c("black", "white")) +
  geom_smooth(method = "lm", se=F, color="black") +
  theme_bw()
p2.c


