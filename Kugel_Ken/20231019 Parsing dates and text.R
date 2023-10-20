#Ken kugel
#Oct 19th 2023

#Parsing Dates and Text

library(tidyverse) #stringr is in this package
library(lubridate)

presidential
#start and end dates are already recognized as date objects

presidential$end-presidential$start

write.csv(presidential, "Kugel_Ken/presidential.csv")


pres.dat=read.csv("Kugel_Ken/presidential.csv")

pres.dat
class(pres.dat$start)
#Well now it says that the dates are characters, NOT DATES!?!?!

#How do we convert to dates?!

#BASE R Method

new.start=as.Date(pres.dat$start, format = "%Y-%m-%d")
new.end=as.Date(pres.dat$end, format = "%Y-%m-%d")
new.end-new.start


#LUBRIDATE Method
lub.start=ymd(pres.dat$start)
lub.end=ymd(pres.dat$end)
lub.end-lub.start
#Date has to be in an intelegable mannor

mdy("10182023") #what if its in 'American' format??
#We have a function for that


#Theres also things in here for time as well
##############################################


#Text parsing
filename= "data_20220927.csv"
#date starts character #6 and ends at #13 (inclusive)
#lets extract character 6-13

#extract substring by character numbers
a=substr(filename, start = 6, stop = 13)
as.Date(a, format="%Y%m%d")

#tidyverse way with stringr package

str_sub(filename, start=6, end=13) %>% ymd() #with this we can pipe to ymd immediately!


#Another solution to this problem...
#We could remove anything that's not the date!

#base R: gsub

b= gsub("data_", "", filename)
c= gsub(".csv","", b)
c #then use as.date

#Tidyverse... str_replace()

filename %>% str_replace("data_", "") %>% str_replace(".csv","") %>% ymd()
#wow fast and easy!

#well what if we had a bunch of files???

list.files("data/", ".csv") #if we had a folder full of filenames... we could go through and do it all!


###############################

#Lets do a trial using WHO Tuberculosis data

who
#60 columns but only really needs 5! 56 columns are code for each subsection of patients. There is key info in the column names though.


#lets fix the format

long.who=who %>% pivot_longer(cols = 5:60)

long.who %>% pull(name) %>% unique()
#Now lets find a pattern

#Sex is always predictably at the 8th position
long.who %>% pull(name) %>% str_sub(start=8, end=8) #We can obtain the sex

#create a new variable in our csv
long.who %>%  mutate(sex= str_sub(name, start=8, end=8))

#method of diagnosis
long.who %>%  pull(name) %>% str_sub(start=4, end = 6) %>% str_replace("_","")
long.who %>%
  mutate(sex= str_sub(name, start=8, end=8)) %>%
  mutate(Method = str_sub(name, start=4, end = 6) %>%
           str_replace("_",""))

#Age
long.who %>% pull(name) %>%
  str_sub(start=9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+")#But these are characters, not factors...

long.who %>% pull(name) %>%
  str_sub(start=9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+") %>% as_factor()


long.who %>%
  mutate(sex= str_sub(name, start=8, end=8)) %>%
  mutate(Method = str_sub(name, start=4, end = 6) %>%
           str_replace("_","")) %>%
  mutate(Age= str_sub(name, start=9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "15-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>% as_factor())
long.who.extract=long.who %>%
  mutate(sex= str_sub(name, start=8, end=8)) %>%
  mutate(Method = str_sub(name, start=4, end = 6) %>%
           str_replace("_","")) %>%
  mutate(Age= str_sub(name, start=9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "15-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>% as_factor())
long.who.extract

ggplot(long.who.extract %>% filter(iso3=="USA") %>% filter(Method=="sp") %>% filter(sex=="m"), aes(x=year, y=value, color=Age))+
         geom_point()

