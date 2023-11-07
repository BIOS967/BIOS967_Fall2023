## batch processing

library(RColorBrewer)
library(ggplot2)
library(ggmap)
library(mapproj)
library(dplyr)
library(lubridate)
library(stringr)

list.dirs() #lists all the folders that exist on repository
list.files() #lists folder filenames, not in terms of path
list.files("data") #lists all the files in the data folder
list.files("data", pattern=".csv") #shows me all the files in data folder with csv form
list.files("data/Flack et al_Biology Letters/") #type data/ then press "tab"
list.files("data/Flack et al_Biology Letters/R1/") #step by step
list.files("data/Flack et al_Biology Letters/R1/A_A35/") #step by step
list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.name=T) #gives you full relative pathname to csv files

#write a script to just import all 6 csv files at once


#you can batch inport multiple datasets by using lapply and a set of pathnames to the data
dats.R1A35 = lapply(list.files("data/Flack et al_Biology Letters/R1/A_A35/", full.name=T), function(x) read.csv(x)) #route 1 for individual A35
#lapply takes a list of things, applies some function, result is organized as list

#we've just uploaded 6 datasets and organized it as a list

dats.R1A35
str(dats.R1A35)

#start by plotting one route
dats.R1A35 #list of six things
dats.R1A35[[1]] #gives you the first try of route one for this pigeon

ggplot(dats.R1A35[[1]], aes(x=Longitude, y=Latitude)) +
  geom_path() #plots the path of the pigeon for one route, the first try

ggplot(dats.R1A35[[6]], aes(x=Longitude, y=Latitude)) +
  geom_path() #plots the path of the pigeon for one route, the 6th try

#now let's combine both together!

bind_rows(dats.R1A35) #this combines the 6 data sets in the list into one dataset
nrow(bind_rows(dats.R1A35)) #counts how many rows there are

#plots all the flight paths for the 6 trials
#mutate converts date variable from character to date
ggplot(bind_rows(dats.R1A35) %>% mutate(Date=ymd(Date)), aes(x=Longitude, y=Latitude, color=Date, group=Date)) +
  geom_path(size=.5) +
  scale_color_gradient(low="black", high="pink")

#route2
dats.R2A35 = lapply(list.files("data/Flack et al_Biology Letters/R2/A_A35/", full.name=T), function(x) read.csv(x))
#route3
dats.R3A35 = lapply(list.files("data/Flack et al_Biology Letters/R3/A_A35/", full.name=T), function(x) read.csv(x))
bind_rows(list(dats.R1A35, dats.R2A35, dats.R3A35))
#nrow(bind_rows(list(dats.R1A35, dats.R2A35, dats.R3A35)))

#plots all of these routes together
ggplot(bind_rows(list(dats.R1A35, dats.R2A35, dats.R3A35)) %>% mutate(Date=ymd(Date)), aes(x=Longitude, y=Latitude, color=Date, group=Date)) +
  geom_path(size=.5) +
  scale_color_gradient(low="black", high="pink")

#if you sum distance variable for whole trial, you can get the distance that the bird flew
dats.R1A35[[1]]$Distance #lists all the distances the pigeon flies
sum(dats.R1A35[[1]]$Distance) #calculates total distance by summing Distance variable

sapply(dats.R1A35, function(x) sum(x$Distance)) #calculates the total distances for route 1

sapply(list(dats.R1A35, dats.R2A35, dats.R3A35),
       function(y) sapply(y, function(x) sum(x$Distance))) #calculates the total distances for each route!!! bro

fnames <- list.files("data/Flack et al_Biology Letters/R1/A_A35/")

group <- str_sub(fnames, start=1, end=1) #selects which specific characters to turn into a variable from fnames
id <- str_sub(fnames, start=3, end=5)
route <- str_sub(fnames, start=7, end=8)
trial <- str_sub(fnames, start=10, end=11)
distances <- sapply(dats.R1A35, function(x) sum(x$Distance))

dat <- data.frame(group, id, route, trial, distances) #creates a data frame

ggplot(dat, aes(x=trial, y=distances, group=group)) +
  geom_point() +
  geom_line()