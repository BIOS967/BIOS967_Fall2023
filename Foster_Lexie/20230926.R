#data wrangling

?billboard
billbaord
billboard

#filter the data by band
filter(billboard, artist=="Backstreet Boys, The")
filter(billboard, artist=="Spears, Britney")

#the tidyverse way (first I have a dataset, then I want to do an action to it)
billboard %>% filter(artist=="Backstreet Boys, The")

#Use vertical line | to mean "or"
billboard %>% filter(artist=="Backstreet Boys, The" | artist=="N'Sync")

#use & to mean "and": show me Backstreet Boys songs that in under rank = 50 in week 1
billboard %>% filter(artist=="Backstreet Boys, The" & wk1<50)

billboard %>% filter(artist=="Backstreet Boys, The"  | artist=="N'Sync") %>% filter(wk1<50)

#select by columns
billboard %>% select(artist, track, date.entered, wk1)

#unselect certain columns using the negative sign (-)
billboard %>% select(-artist, -date.entered)

# using pivot_longer() to go from wide to long format data
# cols = assigns the columns you want to pivot
# names_to = assigns the variable name to what the columns were
# values_to = assigns the variable name for the values in those columns
billboard %>% pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank")

#now, let's calculate the best rank in year 2000 for each artist
billboard %>% pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarize(artist.best=min(rank), n.weeks=n()) #n gives the number of times an artist appears

#save this new summary data as a new object
bb.summary=billboard %>%
  pivot_longer(cols=starts_with("wk"), names_to="week", values_to="rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarize(artist.best=min(rank), n.weeks=n())

bb.summary

#now plot relationship between number of weeks in Top 100 and artist's best rank that year
ggplot(bb.summary, aes(x=n.weeks, y=artist.best)) +
  geom_point()

#create a new variable using mutate()
#calculate rank change between week 1 and week 2 for each song
billboard %>%
  mutate(rank.diff=wk2-wk1) %>%
  select(artist, track, wk1, wk2, rank.diff)




