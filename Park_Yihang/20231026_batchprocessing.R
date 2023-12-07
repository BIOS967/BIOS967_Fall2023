#batch processing

list.dirs()

list.files()

#list all files in "data" folders
list.files("data")
#list all files in "data" folder that contains ".csv"
list.files("data", pattern=".csv")

#put data/, and press tab to show the lists of the files
list.files("data/Flack et al_Biology Letters/")

list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.name=T)

#you can batch import multiple datasets by using lapply and a sey of pathnames to the data
dats.R1A35=lapply(list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.name=T), function(x) read.csv(x))

dats.R1A35
str(dats.R1A35)

library(RColorBrewer)
library(ggplot2)
library(ggmap)
library(mapproj)
library(dplyr)
library(lubridate)

## start by plotting one route
dats.R1A35[[1]]
ggplot(dats.R1A35[[1]], aes(x=Longitude, y=Latitude)) +
  geom_path()

ggplot(dats.R1A35[[2]], aes(x=Longitude, y=Latitude)) +
  geom_path()
ggplot(dats.R1A35[[3]], aes(x=Longitude, y=Latitude)) +
  geom_path()

ggplot(dats.R1A35[[6]], aes(x=Longitude, y=Latitude)) +
  geom_path()

#combine the 6 datasets in the list into one dataset
nrow(bind_rows(dats.R1A35))

ggplot(bind_rows(dats.R1A35) %>% mutate(Date=ymd(Date)), aes(x=Longitude, y=Latitude, color=Date, group=Date)) +
  geom_path()+
  scale_color_gradient(low="gold", high="red")

#get route2 to for the same individual
dats.R2A35=lapply(list.files("data/Flack et al_Biology Letters/R2/A_A35/", full.name=T), function(x) read.csv(x))
#get route 3 to for the same individual
dats.R3A35=lapply(list.files("data/Flack et al_Biology Letters/R3/A_A35/", full.name=T), function(x) read.csv(x))

bind_rows(list(dats.R1A35, dats.R2A35, dats.R3A35))

ggplot(bind_rows(dats.R1A35, dats.R2A35, dats.R3A35) %>% mutate(Date=ymd(Date)), aes(x=Longitude, y=Latitude, color=Date, group=Date)) +
  geom_path()+
  scale_color_gradient(low="gold", high="red")

#we can calculate the distance that a bird travelled in a trial by summing the "Distance" variable
sum(dats.R1A35[[1]]$Distance)

sapply(dats.R1A35, function(x) sum(x$Distance))
sapply(list(dats.R1A35, dats.R2A35, dats.R3A35), function(y) sapply(y, function(x) sum(x$Distance)))

##
fnames=list.files("data/Flack et al_Biology Letters/R1/A_A35/")

library(stringr)
group=str_sub(fnames, start=1, end=1)
id=str_sub(fnames, start=3, end=5)
route=str_sub(fnames, start=7, end=8)
trial=str_sub(fnames, start=10, end=11)

distances=sapply(dats.R1A35, function(x) sum(x$Distance))
distances

dat=data.frame(group, id, route, trial, distances)
ggplot(dat, aes(x=trial, y=distances, group=group)) +
  geom_point() +
  geom_line()
