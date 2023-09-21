eggs <- read.csv("data/EggMeasurements_example.csv")
eggs

str(eggs) #shows what type of data are in each collumn
#unique(eggs$mass) #shows the unique characters in mass column

#at this point we can see that there is a "." in the otherwise column of numbers, causing them all to be read as characters

eggs <- read.csv("data/EggMeasurements_example.csv", na.strings=c(".","")) #fixes dates (which were spaces)
unique(eggs$mass)
unique(eggs$length)
unique(eggs$width) #perfect!

#now we'll notice a bunch of dates are weird
#unique(eggs$LayDate)
#eggs <- read.csv("data/EggMeasurements_example.csv", na.strings="")
unique(eggs$LayDate)