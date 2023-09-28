# September 26th 2023
# Data Wrangling with Tidyverse

#Packages

#install.packages("tidyverse")
library(tidyverse)
#install.packages("wbstats")
library(wbstats)

#Pipe Operator: %>% (ctr+shft+m)
#This is specific to our packages. It allows us to connect one command with another (ie- output from part one as input for part two)

#Tibbles: Special class of dataframe
#Defensive coding which protects from 'dangerous' changes such as changing variable names or types

#Using the billboard dataframe

billboard

#This is a large dataset and we cant even see all of it!
#Lets filter so we can just see one band

filter(billboard, artist== "Backstreet Boys, The")

#We could then assign this as an object... or the tidyverse way--> using pipes!


#Tidyverse
billboard %>% filter(artist=="Backstreet Boys, The") #pipe implies the dataset

#Now lets add more
billboard %>% filter(artist=="Backstreet Boys, The" | artist== "N'Sync")

#Now lets use & to specify
billboard %>% filter(artist=="Backstreet Boys, The" | artist== "N'Sync") %>% filter(wk1<"50")
#Or we could do it like this
billboard %>% filter(artist=="Backstreet Boys, The" & wk1<"50" | artist== "N'Sync" & wk1<"50")


#Well this is all rows... what about columns??
billboard %>% select(artist, track, date.entered, wk1) %>% print(n=317)


#Unselect certain columns
billboard%>% select(-artist, -date.entered)



#Lets convert this wide data to Long format data
## Using pivot_longer()

billboard %>% pivot_longer(cols=starts_with("wk"), names_to ="week", values_to="rank")

#Best rank of each artist
billboard %>%
  pivot_longer(cols=starts_with("wk"), names_to ="week", values_to="rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarize(Artist.Best =min(rank), n.weeks=n())


#Lets save the data so we can do analysis

bb.summary = billboard %>%
  pivot_longer(cols=starts_with("wk"), names_to ="week", values_to="rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarize(Artist.Best =min(rank), n.weeks=n())

#Now plot relationship between number of weeks and artist's best rank
ggplot(bb.summary, aes(x=n.weeks,y=Artist.Best))+
  geom_point()

#create a new variable using mutate()
## For each song lets see if the rank goes up or down for each week

billboard %>%
  mutate(rank.change =wk2-wk1) %>%
  select(artist, track, wk1,wk2,rank.change) %>%
  filter(rank.change > 0) #This would show us artists that are falling down the top 100

