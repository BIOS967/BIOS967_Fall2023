#September 26, 2023
#data Wrangling

install.packages("tidyverse")
install.packages("wbstats")
library(wbstats)
library(tidyverse)

#using the billboard
billboard
?billboard

filter(billboard, artist=="backstreet Boys, The")
#the tidyverse
billboard%>% filter(artist=="backstreet boys, The")

#use vertical lines | to mean "or"
billboard %>% filter(artist=="backstreet Boys, The" | artist =="N'Sync")

#Backstreet Boys Or N'Sync songs that came in under rank 50 inweek 1
billboard%>% filter(artist=="backstreet boys, The"| artist =="N'Sync") %>% filter(wk1<50)

#use & to mean "and": show me backstreet boys songs that came in under rank = 50 in week1

billboard%>% filter(artist=="backstreet boys, The"& wk1<50)

#select by column
billboard%>%select(artist, track, date.entered,wk1)

billboard%>% select(-artist,-date.entered)

billboard%>% pivot_longer(cols=starts_with("wk"),names_to="week", values_to="rank")

#now, let's calculate the best rank in year 200 for each artist

bb.summary=billboard%>%
  pivot_longer(cols=starts_with("wk"),names_to="week", values_to="rank")%>%
  drop_na()%>%
  group_by(artist) %>%
  summarise (artist.best=min(rank), n.week=n())
bb.summary

ggplot(bb.summary,aes(x= n.week, y=artist.best))+
  geom_point()

#create a new variable using mutate()
#calculate rank change between week 1 and week 2 for each song
billboard %>%
  mutate(rank.diff=wk2-wk1) %>%
  select(artist, track,wk1,wk2, rank.diff)

