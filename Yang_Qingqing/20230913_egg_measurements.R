#import data
eggdat <- read.csv("data/EggMeasurements_example.csv")
str(eggdat)
eggdat

############## look at structure of data #######################
str(errdat)      #tells you the type (character or numbers)
# nest_fate is levels
#Laydate has missing values marked "."

############## Problem: eggnumber, mass, length, width are not numbers ##############
## Egg Number
eggdat$EggNumber #What is "P#"?
#this problem is caused by the inclusion of "P#" as a value
#solution: find out what P# means

##Mass
eggdat$mass
unique(eggdat$mass)
#some missing values are marked as 0. I'm not sure if I can use na.strings here because there could be real 0s elsewhere
#other missing values are marked as "." It's a little hard to spot with all the numbers.
#is there a function that gives you non-numbers?
#solution: use na.strings with "."
eggdat <- read.csv("data/EggMeasurements_example.csv", na.strings=".")
str(eggdat) #now they are numbers.

############## Look at laydate ##############
unique(eggdat$LayDate) #there are years ending in 99 which may be wrong Are they 09?
