#Data wrangling using tidyverse
#install Pckages
install.packages("tidyverse")
install.packages("wbstats")

#load packages
library(tidyverse)
library(wbstats)

#using the billboard
billboard
?billboard

#filter data by artist
filter(billboard, artist=="Backstreet Boys,The")

#tidyverse way
billboard %>%filter(artist=="Backstreet Boys, The") #"%>%"=Pipe, allow for using output of one commanand directly in to the next command

billboard %>%filter(artist=="Backstreet Boys, The" | artist=="N'Sync")


#show backstreet boys songs under rank 50 in week 1
billboard %>%filter(artist=="Backstreet Boys, The" & wk1<50 )

#Select by columns
billboard%>%select(artist,track,date.entered,wk1)

#unselect certain columns
billboard%>%select(-artist,-date.entered)

#Switch from wide format to long format using pivot_longer()
#cols=assigns the columns you wan ttp pivot
#Names_to=assigns variable name for what column was
#values_to=assign variable name for the values in the columns
billboard %>% pivot_longer(cols = starts_with("wk"),names_to = "week", values_to = "rank")

#calculate the best rank in yr 2000 for each artist
#get rid of NA's= drop_na
billboard %>%
  pivot_longer(cols = starts_with("wk"),names_to = "week",
  values_to = "rank") %>% drop_na() %>%
  group_by(artist) %>%
  summarise(min(rank), n.weeks=n())  #summarize number of weeks in top 100

#Save new summary data as an obj
bb.summary=billboard %>%
  pivot_longer(cols = starts_with("wk"),names_to = "week",
               values_to = "rank") %>% drop_na() %>%
  group_by(artist) %>%
  summarise(artist.best=min(rank), n.weeks=n())
bb.summary

ggplot(bb.summary,aes(x=n.weeks, y=artist.best))+
  geom_point()

#Create a new variable using mutate()
#calculate rank change between wk 1 & 1 for each song
billboard %>%
  mutate(rank.dif=wk2-wk1) %>%
  select(artist,track,wk1,wk2,rank.dif)




