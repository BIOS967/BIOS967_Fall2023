#batch processing

list.dirs()

list.files()

#list all files in "data" folder
list.files("data")
#list all files in "data" folder that contains ".csv"
list.files("data", pattern=".csv")

list.files("data/Flack et al_Biology Letters/")

list.files("data/Flack et al_Biology Letters/R1")

list.files("data/Flack et al_Biology Letters/R1/A_A35/")

list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.name=T)

#you can batch import multiple datasets by using lapply and a set of pathnames to the data.
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
head(dats.R1A35[[3]])

ggplot(dats.R1A35[[1]], aes(x=Longitude, y=Latitude)) +
  geom_path()

ggplot(dats.R1A35[[2]], aes(x=Longitude, y=Latitude)) +
  geom_path()

ggplot(dats.R1A35[[6]], aes(x=Longitude, y=Latitude)) +
  geom_path()

#combine the 6 datasets in the list into one dataset
bind_rows(dats.R1A35)

ggplot(bind_rows(dats.R1A35) %>% mutate(Date=ymd(Date)), aes(x=Longitude, y=Latitude, color=Date, group=Date)) +
  geom_path() +
  scale_color_gradient(low="gold", high="red")

#get Route 2 for the same individual
dats.R2A35=lapply(list.files("data/Flack et al_Biology Letters/R2/A_A35/", full.name=T), function(x) read.csv(x))

#get Route 3 for the same individual
dats.R3A35=lapply(list.files("data/Flack et al_Biology Letters/R3/A_A35/", full.name=T), function(x) read.csv(x))

bind_rows(list(dats.R1A35, dats.R2A35, dats.R3A35))

ggplot(bind_rows(list(dats.R1A35, dats.R2A35, dats.R3A35)) %>% mutate(Date=ymd(Date)), aes(x=Longitude, y=Latitude, color=Date, group=Date)) +
  geom_path() +
  scale_color_gradient(low="gold", high="red")

#we can calculate the distance that a bird travelled in a trial by summing the "Distance" variable
sum(dats.R1A35[[1]]$Distance)

sapply(dats.R1A35, function(x) sum(x$Distance))

sapply(list(dats.R1A35,dats.R2A35, dats.R3A35), function(y) sapply(y, function(x) sum(x$Distance)))
