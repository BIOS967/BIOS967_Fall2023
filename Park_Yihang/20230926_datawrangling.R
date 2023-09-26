##data wrangling##

install.packages("tidyverse")
install.packages("wbstats")

library(tidyverse)

#use %>% in tidyverse: allows for using output of one command directly in to the next comment. ctrl+shift+m = %>%

#using the billboard
billboard
?billboard

#filter the data by band
filter(billboard, artist=="Backstreet Boys, The")

#the tidyverse
billboard %>% filter(artist=="Backstreet Boys, The" | artist=="N'Sync")

#Backstreet boys OR N'Sync songs that came in under rank = 50 in week 1

billboard %>% filter(artist=="Backstreet Boys, The" | artist=="N'Sync") %>% filter(wk1<50)

#use & to mean "and" : show me Backstreet Boys songs that came in under rank= 50 in week 1
billboard %>% filter(artist=="Backstreet Boys, The" & wk1<50)

#select by columns
billboard %>% select(artist, track, date.entered, wk1)

#unselect certain column using -
billboard %>% select(-artist, -date.entered)

## using pivot_longer to go from wide to long format data
#cols= assigns the columns you want to pivot
# names_to = assigns the variable name for what the columns were
# values_to = assigns the variable name for the values in those columns
billboard %>%  pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank")



# now, let's calculate the best rank in year 2000 for each artist
bb.summary=billboard %>%  pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank") %>%
  drop_na() %>%
  group_by(artist) %>% 
  summarize(artist.best=min(rank), n.weeks=n())
#save this new summary data as new object 

bb.summary

#now plot relationship between number of weeks in top 100 and the artist's best rank that year
ggplot(bb.summary, aes(x=n.weeks, y=artist.best))+
  geom_point()


#create new variable using mutate()
#calculate rank change btw week 1 and week 2 for each song
billboard %>% 
  mutate(rank.diff=wk2-wk1) %>% 
  select(artist, track, wk1, wk2, rank.diff)
#don't do any calculate sth in excel!!!! let your calculation is a part of the code