library(tidyverse)
library(lubridate)
install.packages("lubridate")
library(tidyverse)
library(lubridate)

presidential

presidential$end-presidential$start

write.csv(presidential, "presidential.csv")

pres.dat=read.csv("presidential.csv")
pres.dat

class(pres.dat$start)
pres.dat$end-pres.dat$start

##convert dates-as-characters into date formant
new.start=as.Date(pres.dat$start, format="%Y-%m-%d")
new.end=as.Date(pres.dat$end, format="%Y-%m-%d")
new.end-new.start

as.Date(pres.dat$start, format="%Y-%m-%d") #need to get the format argument right

#lubridate version
ymd(pres.dat$start)
ymd(pres.dat$end)-ymd(pres.dat$start)

ymd("20230809")
mdy("05/18/1978") #to deal with the stupid American way of coding month/date/year
dmy("05/04/1978") #this would be wrong if I meant May 4, 1978
as.Date("05/17/1919", format="%m/%d/%Y")

### parsing
filename="data_20220927.csv"

#extract substring by character numbers

#base R
a=substr(filename, start=6, stop=13)
as.Date(a,format="%Y%m%d")

#tidyverse way (using stringr package)
str_sub(filename, start=6, end=13) %>% ymd()


#solution 2: replace the info I don;t want with blanks

#base R: use gsub()
a=gsub("data_", "", filename)
b=gsub(".csv", "", a)
b

#tidyverse may: use str_replace()
filename %>%
  str_replace("data_", "") %>%
  str_replace(".csv", "") %>%
  ymd()

list.files("data", pattern=".csv")

### example using WHO TB dataset
who
?who

who_long=who %>%
  pivot_longer(c(-country, -iso2, -iso3, -year))
who_long %>% pull(name) %>% unique()

# can get the sex as the 8th character of the code
who_long %>% pull(name) %>% str_sub(start = 8, end = 8)

# use this to create a new variable for sex
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))

#get the method of diagnosis
who_long %>% pull(name) %>%
  str_sub(start=4, end=6) %>%
  str_replace("_", "")
# add new variable for method of diagnosis
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8)) %>%
  mutate(method=str_sub(name, start=4, end=6) %>%
           str_replace("_", ""))

#get age classes
who_long %>% pull (name) %>%
  str_sub(start=9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "1-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+") %>%
  as_factor()


#put it all together
who_use=who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8)) %>%
  mutate(method=str_sub(name, start=4, end=6) %>%
           str_replace("_", "")) %>%
  mutate(age= str_sub(name, start=9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "1-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>%
           as_factor())


ggplot(who_use %>% filter(iso3=="USA") %>% filter(sex=="m") %>% filter(method=="sp"), aes(x=year, y=value, color=age )) +
  geom_point() +
  geom_line()
