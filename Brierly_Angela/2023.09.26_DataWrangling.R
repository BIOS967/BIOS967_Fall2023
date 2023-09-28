## 2023.09.26  ____DATA WRANGLING

#install.packages("tidyverse")
#install.packages("wbstats")

library(tidyverse)
library(wbstats)
install.packages("wbstats")
library(wbstats)
?wbstats


#using the BILLBOARD
billboard
?billboard

#To look at just ONE artist from billboard dataframe
# FILTER BY DATA
filter(billboard, artist=="BAckstreet Boys, The")

#TIDYVERSE way
billboard %>% filter(artist=="Backstreet Boys, The")
# The PIPE (%<%) implies you know the dataset for the FILTER

billboard %>% filter(artist=="Backstreet Boys, The" | artist=="N'Sync") # the "|" means "or"

billboard %>% filter(artist=="Backstreet Boys, The" | artist=="N'Sync") %>% filter(wk1<50)
# previous criteria AND ranked >50 during week 1.

#use "&" to mean "and": show me backstreet boys songs that came in >50 in week 1.
billboard %>% filter(artist=="Backstreet Boys, The" & wk1<50)

# select by COLUMNS
billboard %>% select(artist, track, date.entered, wk1)
#or use a negative sign "-" to show all EXCEPT those
billboard %>% select(-artist, -date.entered)


#_________________________________________________________________________
##WIDE FORMAT vs. LONG FORMAT

#shifting only SOME of the columns from WIDE to LONG format
# using "pivot_longer()" to go from WIDE to LONG format
# "cols=" assigns the variable name for wha the columns were
# "values_to=" assigns the variable name for the values in those columns
billboard %>% pivot_longer(cols = starts_with("wk"), names_to = "week", values_to = "rank")

# Calculate the best rank in year 2000 for each artist
billboard %>%
  pivot_longer(cols = starts_with("wk"), names_to = "week", values_to = "rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarise(artist.best=min(rank), n.weeks=n())

# Lets SAVE this new Summary Data as a NEW OBJECT
bb.summary=billboard %>%
  pivot_longer(cols = starts_with("wk"), names_to = "week", values_to = "rank") %>%
  drop_na() %>%
  group_by(artist) %>%
  summarise(artist.best=min(rank), n.weeks=n())

#Plot the relationship btwn # weeks on top 100 and artists best rank that year
ggplot(bb.summary, aes(x=n.weeks, y=artist.best)) +
  geom_point()

#create a NEW VARIABLE using "mutate()"
# calculate "rank change btwn wk1 and wk2" for ea song.

billboard %>%
  mutate(rank.diff=wk2-wk1) %>%
  select(artist, track, wk1, wk2, rank.diff)




