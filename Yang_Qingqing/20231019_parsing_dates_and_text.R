#################### Parsing dates and text ############################

library(lubridate)
library(tidyverse)
library(ggplot2)


presidential #uses date objects
presidential$end-presidential$start #gives time differences

write.csv(presidential, "presidential.csv")
pres.dat <- read.csv("presidential.csv")
class(pres.dat$start) #it's classified as a character, not a date
pres.dat$end-pres.dat$start #doesn't work anymore. You also can't plot it without making it a date.

#convert dates-as-characters into date format
#in base R
new.start <- as.Date(pres.dat$start, format="%Y-%m-%d") #need to get the format argument right
new.end <- as.Date(pres.dat$end, format="%Y-%m-%d")
#Now,
new.end-new.start

#in lubridate
ymd(pres.dat$start)
ymd(pres.dat$end)-ymd(pres.dat$start)
mdy("05/17/1978") #for american format with month/date/year
#you can deal with american format with base R
as.Date("05/17/1978", format="%m/%d/%Y")

############### Parsing text #################
#solution 1: extract the date
#in base R
filename <- "data_20220927.csv" #date is on the 6-13th characters
#extract substring by character numbers
a <- substr(filename, start=6, stop=13)
as.Date(a, format="%Y%m%d")

#tidyverse way, using the stringr package and piped to ymd()
str_sub(filename, start=6, end=13) %>% ymd()

#solution 2: replace unneeded information with blanks
#in base R, use gsub()
a <- gsub("data_", "", filename) #remove data_
b <- gsub(".csv", "", a)
as.Date(b, format="%Y%m%d")

#in tidyverse, use str_replace()
filename %>%
  str_replace("data_", "") %>%
  str_replace(".csv","") %>%
  ymd()


list.files("data", pattern=".csv")


#example using WHO tuberculosis data
who

who_long <- who %>%
  pivot_longer(c(-country, -iso2, -iso3, -year))

who_long %>% pull(name) %>% unique() #unique values of name

#sex is the 8th digit
who_long %>% pull(name) %>% str_sub(start=8, end=8)

#use this to create a new variable for sex
who_long %>%
  mutate(name, sex= str_sub(name, start=8, end=8))

#get the method of diagnosis
who_long %>%
  pull(name) %>%
  str_sub(start=4, end=6) %>%
  str_replace("_", "") #replace the _ with a blank

#add new variable for method of diagnosis
who_long %>%
  mutate(name, sex= str_sub(name, start=8, end=8)) %>%
  mutate(method=str_sub(name, start=4, end=6) %>%
           str_replace("_", ""))


#look at age
who_long %>% pull(name) %>% unique() #age class can be 2, 3, or 4 numbers.
who_long %>% pull(name) %>% str_sub(start=9) #don't give it an end and it'll give you all the rest of the digits
who_long %>%
  pull(name) %>%
  str_sub(start=9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+")
#this gives you a bunch of characters, but you want them to be organized as factors
who_long %>%
  pull(name) %>%
  str_sub(start=9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+") %>%
  as_factor()

#put it all together
who_use <- who_long %>%
  mutate(name, sex= str_sub(name, start=8, end=8)) %>%
  mutate(method=str_sub(name, start=4, end=6) %>%
           str_replace("_", "")) %>%
  mutate(age=str_sub(name, start=9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "15-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>%
           as_factor())
ggplot(who_use %>% filter(iso3=="USA") %>% filter(method=="sp") %>% filter(sex=="m"), aes(x=year, y=value, color=age)) +
  geom_point()+
  geom_line()



