#Homework 1

# Group 2 Exercise --------------------------------------------------------
raw_dat=read.csv("data/EggMeasurements_example.csv")
raw_dat
#Obvious Issues:
#<NA> in ChickID
#P+ number in EggNumber
# #N/A in Nest_Fate
# Two excel Tabs?
# . in LayDate ==> Change to ' '
#Should dates be characters? if not what about the / in the date?


#Problem 1: <NA> in ChickID
#Resolved but found new problem
raw_dat$ChickID
raw_dat2=read.csv("data/EggMeasurements_example.csv", na.strings = "<NA>")
raw_dat2
raw_dat2$ChickID #hmm, still char... Maybe another issue in the same column?
# AHA 6017-P1 among many others. So I need to tackle the P+ number issue...

#Problem 3: #N/A in Nest Fate
#Resolved
raw_dat3= read.csv("data/EggMeasurements_example.csv", na.strings = c("<NA>", "#N/A"))
raw_dat3

#moved to help flow of rest of code.


#Problem 2: P+ number issue
#Unresolved...
# Well if we look at nest 6006... there is already a number 1 and there is a P1, but there is not an 11... But is this true for the rest of the data? What if we changed P1 to 100? thats probably safe right? Except then we'd be saying there's 100 eggs!?
# Lets look at the excel...
#how does R feel about underscores? I assume they're characters?
class("_") #Yup.
#I feel that any fix I can think of would be a case by case basis.
#What if we made it negative? ie- P1==> -1
# it does disrupt the count of eggs, but would/should never overlap numbers...

?read.csv

raw_dat2

#How can we reference all cells that have a P+number. R won't recognize == "P" right?
raw_dat2$EggNumber == "P" #Nope, this catches none of them.. Hmm well what if we... use a split function.. that seems extremely tedious, there must be a better way... If not I can fall back on this, make an empty list and a loop function to split the numbers into letters, then identify if there is a P in the list, then clear the list. Then it should tell me the correct true/false
#It might be faster to fix each P (ie P1, P2, ect.)
a= "P"
a
?"if"
#if(a in raw_dat2$EggNumber) {"P"} #Why can't I use 'in' here?
?"%in%"
a %in% raw_dat2$EggNumber
"P" %in% raw_dat2$EggNumber
raw_dat2$EggNumber
#At least this summarizes the whole group on whether it catches it or not..



#problem 4: . in LayDate
# can we just make it a NA?
raw_dat3$LayDate = replace(".",raw_dat3$LayDate,values = " ") #I'm sure this is not a smart way of doing this, but why doesn't it get all the data?

raw_dat3$LayDate
b ="."
b %in% raw_dat3$LayDate #not helpful

if(b %in% raw_dat3$LayDate) {T} #not helpful

raw_dat4 = read.csv("data/EggMeasurements_example.csv", na.strings= c("<NA>","#N/A","."))
raw_dat4 #why are "." now <NA>?? is that okay since it should be read as NA per above?
#raw_dat3


# Finish Basic Plotting Module --------------------------------------------

