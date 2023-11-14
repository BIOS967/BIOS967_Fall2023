##parsing dates and text

library(tidyverse)
library(lubridate)

presidential

(presidential$end - presidential$start) / 365.25

write.csv(presidential, "presidential.csv")

pres.dat <- read.csv("presidential.csv")
pres.dat

class(pres.dat$start) #thiinks it's a character

#(pres.dat$end - pres.dat$start) / 365.25 #can't do calculation, thinks this is a string of characters, not dates

### CONVERT DATE-AS-CHARACTER INTO DATE FORMAT

new.start <- as.Date(pres.dat$start, format = "%Y-%m-%d")
new.end <- as.Date(pres.dat$end, format = "%Y-%m-%d")

new.end - new.start

## LUBRIDATE VERSION

ymd(pres.dat$start)
ymd(pres.dat$end) - ymd(pres.dat$start)

ymd("20230809")
#ymd("04/28/1994") can't do this one
mdy("04/28/1994") #to deal with american way of coding dates

as.Date("04/28/1994", format = "%m/%d/%Y")


### PARSING TEXT
filename <- "data_20220927.csv"

#extracting a date from a character string
#base R (doesn't do piping, assign output as an object, then use this object "a" in as.Date)
a <- substr(filename, start = 6, stop = 13)
as.Date(a, format = "%Y%m%d")

#tidyverse way (using stringr package)
str_sub(filename, start = 6, end = 13) %>% ymd()


## Solution 2: Replacing the info we don't want with blanks

#base R: Use gsub()
b <- gsub("data_", "", filename)
c <- gsub(".csv", "", b)

#tidyverse way: use str_replace()

filename %>%
  str_replace("data_", "") %>%
  str_replace(".csv", "") %>%
  ymd()

#list.files("data", pattern = ".csv") #how we would batch it, first step atleast!

## example using WHO TB dataset
who
?who

who_long <- who %>%
  pivot_longer(c(-country, -iso2, -iso3, -year)) #we want to keep these four columns, and the rest of the colums, reorganize into two different columns, one with all the

who_long %>% pull(name) %>% unique()

#can bet the sex as the 8th character of the code
who_long %>% pull(name) %>% str_sub(start = 8, end = 8)

# use this to create a new variable for sex
who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8))
#mutate creates a new variable (in tidyverse)

# get the method of diagnosis
who_long %>% pull(name) %>%
  str_sub(start=4, end=6) %>%
  str_replace("_", "") %>% unique()

who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8)) %>%
  mutate(method = str_sub(name, start=4, end=6) %>%
           str_replace("_", ""))

#get age classes
who_long %>% pull(name) %>%
  str_sub(start=9) %>%
  str_replace("014", "0-14") %>%
  str_replace("1524", "15-24") %>%
  str_replace("2534", "25-34") %>%
  str_replace("3544", "35-44") %>%
  str_replace("4554", "45-54") %>%
  str_replace("5564", "55-64") %>%
  str_replace("65", "65+") %>%
  as_factor()

who_use <- who_long %>%
  mutate(sex=str_sub(name, start = 8, end = 8)) %>%
  mutate(method = str_sub(name, start=4, end=6) %>%
           str_replace("_", "")) %>%
  mutate(age= str_sub(name, start=9) %>%
           str_replace("014", "0-14") %>%
           str_replace("1524", "15-24") %>%
           str_replace("2534", "25-34") %>%
           str_replace("3544", "35-44") %>%
           str_replace("4554", "45-54") %>%
           str_replace("5564", "55-64") %>%
           str_replace("65", "65+") %>%
           as_factor())


ggplot(who_use %>% filter(iso3 == "USA") %>% filter(method == "sp") %>% filter(sex=="m"), aes(x=year, y=value, color = age)) +
  geom_point() +
  geom_line()

view(who_use)