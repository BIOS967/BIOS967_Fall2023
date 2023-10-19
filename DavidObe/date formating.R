install.packages("lubridate")
library(lubridate)
library(tidyverse)
presidential
presidential$end-presidential$start

#this is a way to change character to number using date as example. So we changed the intial data into a csv file.
write.csv(presidential, "presidential.csv")
pres.dat = read.csv("presidential.csv")
pres.dat
class(pres.dat$start)

##convert to a date formart
new.start=as.Date(pres.dat$start, format = "%Y-%m-%d")
new.end=as.Date(pres.dat$end, format = "%Y-%m-%d")
new.end-new.start

#lubridate
ymd(pres.dat$start)
ymd(pres.dat$end)
ymd(pres.dat$end)-ymd(pres.dat$start)

#for nonamerican date
mdy("05/17/1978")
as.Date("05/17/1978", format="%m/%d/%Y")

#ymd=year, month, day; mdy= month, day, year; dmy=day, month, year
filename="data_20220927.csv"
#extract substring by character numbers
#base R
a=substr(filename, start=6, stop = 13)
as.Date(a, format = "%Y%m%d")

#tidyverse
str_sub(filename, start = 6, end = 13) %>% ymd()

#using another format known as gsub
#base R
d=gsub("data_", "", filename)
b=gsub(".csv", "", a)
b

#tidyverse
filename %>%
  str_replace("data_", "") %>%
  str_replace(".csv", "") %>%
  ymd()
list.files("data", pattern = ".csv")

## example using WHO TB dataset
who
head(who)
?who
#isolating important files
who_long=who %>%
  pivot_longer(c(-country, -iso2, -iso3, -year))
who_long %>% pull(name)%>% unique()

#how to extract information from data
#can bet sex as the 8th character
who_long %>% pull(name)%>% str_sub(start=8, end = 8)

#creating variable called sex
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))

#get the method of diagnosis
who_long %>% pull(name)%>% str_sub(start = 4, end = 6)%>%
  str_replace("_","")
#add new variables to who_long
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))%>%
  mutate(method=str_sub(name, start=4, end = 6)%>%
           str_replace("_", ""))

#get age class
who_long%>% pull(name) %>%
  str_sub(start = 9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+") %>%
  as.factor())



who_use=who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))%>%
  mutate(method=str_sub(name, start=4, end = 6)%>%
           str_replace("_", ""))%>%
  mutate(age=  str_sub(name, start = 9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "15-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>%
           as.factor())

ggplot(who_use %>% filter(iso3=="USA") %>% filter(method=="sp") %>% filter(sex=="m"), aes(x=year, y=value, color=age))+
  geom_point()+
  geom_line()