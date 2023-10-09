############ Bowden worked example ###############
# get the data
boloria <- read.csv("data/boloria.csv")
colias <- read.csv("data/colias.csv")
head(boloria)
head(colias)

#load packages
library(tidyverse)
install.packages("cowplot")
library(cowplot)

################### Recreate figure 1 ######################
#organize the yearly climate data
year.dat <- boloria %>%
  group_by(year) %>%
  summarise(snow=mean(snow), mayjun=mean(mayjun), mayaug.1=mean(mayaug.1))

#plot snow melt day of the year (DOY) across years (panel a)
p1 <- ggplot(year.dat, aes(x=year, y=snow)) +
  geom_point() +
  geom_smooth(method="lm", se=F, color="black") +
  theme_cowplot() +
  labs(y="Snowmelt (DOY)", x-"Year")

#plot may june temperature of current year across time (panel b)
p2 <- ggplot(year.dat, aes(x=year, y=mayjun)) +
  geom_point() +
  geom_smooth(method="lm", se=F, color="black") +
  theme_cowplot()+
  labs(y=expression(paste("Average Temperature"["t"], " ", (~degree * C))), x="year")

#plot may august temperature of previous year across time (panel c)
p3 <- ggplot(year.dat, aes(x=year, y=mayaug.1)) +
  geom_point() +
  geom_smooth(method="lm", se=F, color="black") +
  theme_cowplot()

#now plot them as three panels arranged vertically
plot_grid(p1, p2, p3, align="v", nrow=3)

################### Fit linear models to climate data ##############
fit.snow <- lm(snow~year, data=year.dat)
summary(fit.snow)

fit.mayjun <- lm(mayjun~year, data=year.dat)
summary(fit.mayjun)

######## Recreate figure 2
#year.dat summarizes climate variables for each year
#colias and boloria are species
#getting average and standard error of wing length for each sex of each species for each year
wl.colias <- colias %>% group_by(year, sex) %>% summarize(mean_se(WL))
wl.boloria <- boloria %>% group_by(year, sex) %>% summarize(mean_se(WL))

p2.a <- ggplot(wl.colias, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(pch=21, aes(fill=sex), size=3.5) +
  theme_cowplot() +
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) +
  theme(legend.position="none")

p2.b <- ggplot(wl.boloria, aes(x=year, y=y, group=sex)) +
  geom_path() +
  geom_point(pch=21, aes(fill=sex), size=3.5) +
  theme_cowplot() +
  scale_fill_manual(values=c("black", "white")) +
  geom_errorbar(aes(ymin=ymin, ymax=ymax)) +
  theme(legend.position="none")

# for figure 2 panels c and d, we need to merge the yearly winglength data and yearly climate data. We can do that using a "join" function.
wl.colias
wl.colias <- left_join(wl.colias, year.dat, join_by(year==year))
wl.boloria <- left_join(wl.boloria, year.dat, join_by(year==year))

p2.c <- ggplot(wl.colias, aes(x=mayaug.1, y=y, group=sex)) +
  geom_point(aes(fill=sex), pch=21, size=3) +
  scale_fill_manual(values=c("black", "white")) +
  geom_smooth(method="lm", se=F, color="black") +
  theme_cowplot()

p2.d <- ggplot(wl.boloria, aes(x=mayaug.1, y=y, group=sex)) +
  geom_point(aes(fill=sex), pch=21, size=3) +
  scale_fill_manual(values=c("black", "white")) +
  geom_smooth(method="lm", se=F, color="black") +
  theme_cowplot()

plot_grid(p2.a, p2.b, p2.c, p2.d, nrow=2)
