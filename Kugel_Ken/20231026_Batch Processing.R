# Ken Kugel
# Oct 26th 2023

# Batch Processing



#Libraries

library(RColorBrewer)
library(ggplot2)
#install.packages("ggmap")
library(ggmap)
#install.packages("mapproj")
library(mapproj)
library(dplyr)
library(lubridate)
library(stringr)

#list.dirs()
#list.files()
#list.files("data")
#list.files("data", pattern = ".csv")
#list.files("data/Flack et al_Biology Letters")

list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.names = T)

#script to import all 6 CSV files at once

dats.R1A35=lapply(list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.names = T), function(x) read.csv(x))

#dats.R1A35 #output is 6 dataframes


#Lets plot this route
dats.R1A35[[1]]

ggplot(dats.R1A35[[1]], aes(x=Longitude, y= Latitude))+
  geom_path()
ggplot(dats.R1A35[[2]], aes(x=Longitude, y= Latitude))+
  geom_path()
ggplot(dats.R1A35[[3]], aes(x=Longitude, y= Latitude))+
  geom_path()
ggplot(dats.R1A35[[4]], aes(x=Longitude, y= Latitude))+
  geom_path()
ggplot(dats.R1A35[[5]], aes(x=Longitude, y= Latitude))+
  geom_path()
ggplot(dats.R1A35[[6]], aes(x=Longitude, y= Latitude))+
  geom_path()

#Lets make a combined map of this individual!
  #We could use base R and make a blank plot then add layers
  #Orrrrr the ggplot method... Combine the datasets and graph      by a factor (ie-date or attempt #)

a= bind_rows(dats.R1A35)

ggplot(a, aes(x=Longitude, y= Latitude, color= factor(Date)))+
  geom_path()

#Why mutate rather than just factor?? Maybe because its still not treating as a date? But does it really matter?



#What if we want to do this for multiple Routes?

dats.R2A35=lapply(list.files("data/Flack et al_Biology Letters/R2/A_A35/", full.names = T), function(x) read.csv(x))

dats.R3A35=lapply(list.files("data/Flack et al_Biology Letters/R3/A_A35/", full.names = T), function(x) read.csv(x))

a2=bind_rows(dats.R2A35)
a3=bind_rows(dats.R3A35)

A35_Routes=bind_rows(list(a,a2,a3))

ggplot(A35_Routes, aes(x=Longitude, y= Latitude, color= factor(Date)))+
  geom_path()


#What if we want to count distance each bird flew? Well they give us distance, we could sum it??
dats.R1A35[[1]]$Distance
sum(dats.R1A35[[1]]$Distance)


sapply(list(dats.R1A35, dats.R2A35, dats.R3A35),function(y) sapply(y, function(x) sum(x$Distance)) )
#distance of each replicate of each route


# Well Hey, each file name has a lot of info in it.

list.files("data/Flack et al_Biology Letters/R3/A_A35/", full.names = T)
fnames=list.files("data/Flack et al_Biology Letters/R3/A_A35/")

str_sub(fnames, start=1, end = 1)
group=str_sub(fnames, start=1, end = 1)

id=str_sub(fnames, start=3, end = 5)

route=str_sub(fnames, start=7, end = 8)

trial_numb=str_sub(fnames, start=10, end = 11)

distances= sapply(dats.R1A35, function(x) sum(x$Distance))

distances
dat= data.frame(group, id, route, trial_numb, distances)

ggplot(dat, aes(x= trial_numb, y= distances, group=group))+
  geom_point()+
  geom_line()
