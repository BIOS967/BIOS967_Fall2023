## 26 September 2023; data wrangling

install.packages("tidyverse")
install.packages("wbstats")

library(tidyverse)
library(wbstats)

#using the preloaded database billboard
billboard
?billboard
billboard$track
#we want to look at data for just one band
#filter the data by band
filter(billboard, artist=="Backstreet Boys, The")
#or do the same thing using pipes. The filter function has an implicit first argument.
billboard %>% filter(artist=="Backstreet Boys, The")
#or if we want two artists
billboard %>% filter(artist=="Backstreet Boys, The" | artist== "N'Sync")
#we can add the condition that they do better than rank 50 in week 1
billboard %>% filter(artist=="Backstreet Boys, The" | artist== "N'Sync") %>% filter(wk1<50)
#or we can use & to see one band's songs that came in under rank 50 in week 1
billboard %>% filter(artist=="Backstreet Boys, The" & wk1<50)

#select by column
billboard %>% select(artist, track, date.entered, wk1)
#you can deselect certain columns using -
billboard %>% select(-artist, -date.entered)

#use pivot.longer() to go from wide to long format data
#first, cols assigns the columns you want to pivot
#names_to assigns the variable name for what the columns were
#values_to assigns the variable name for use in the values in the columns
billboard %>% pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank" )

#now, let's calculate the best rank in the year 2000 for each artist
#get rid of NAs
#name the variable for minimum rank "artist.best"
#also find the number of weeks their songs were in the top 100
#n() function is the number of rows the person appears in the data
billboard %>%
  pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank" ) %>%
  drop_na() %>%
  group_by(artist) %>%
  summarize(artist.best=min(rank), n.weeks=n())
#we couldn't have done this with wide format data

#save this new summary data as a new object
bb.summary <- billboard %>%
  pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank" ) %>%
  drop_na() %>%
  group_by(artist) %>%
  summarize(artist.best=min(rank), n.weeks=n())

#look at correlation between number of weeks in top 100 and the best rank
ggplot(bb.summary, aes(x=n.weeks, y=artist.best)) +
  geom_point()

#create a new variable using mutate()
#calculate rank change between week 1 and week 2 for each song
billboard %>%
  mutate(rank.diff=wk2-wk1) %>%
  select(artist, track, wk1, wk2, rank.diff)






