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


# Why do I care if EggID are not numbers!? They're fine as characters! I'm done!
str(raw_dat4)

# Finish Basic Plotting Module --------------------------------------------
a = seq(1,15,1)
b=seq(16,30,1)
plot(a,b)
fac= factor(c(rep("A",5),rep("B",5),rep("C",5)))
plot(fac, a)

plot(a~fac)

t= seq(1,10,1)
response= c(1,5,4,2,3,9,6,7,8,10)
plot(t,response,type="b") #for some reason, 1 does not work

plot(t,response,type="p")
plot(t,response,type="h")
plot(t,response,type="s")

groups=c(rep("a",10),rep("b",5),rep("c",2))
groups.table = table(groups)
groups.table
barplot(groups.table)

iris
str(iris)
?iris

plot(iris$Sepal.Length, iris$Sepal.Width)

plot(iris$Species, iris$Sepal.Width)

plot(iris$Sepal.Width~iris$Sepal.Length)
plot(iris$Sepal.Width~iris$Species)
plot(Sepal.Width~Sepal.Length, data=iris)

plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width")
plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", main="Length vs Width: Sepals in Iris Dataset")
plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", main="Length vs Width: Sepals in Iris Dataset", las=1,xlim=c(0,10),ylim=c(0,5))

plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", las=1,pch=4)

plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", las=1,pch=1,cex=3)

plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", las=1,pch=19,cex=1, col=4)

plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", las=1,pch=19,cex=1, col="red")

plot(Sepal.Width~Sepal.Length, data= iris, xlab = "Sepal Length", ylab="Sepal Width", las=1,pch=19,cex=1, col="#00FF00")

my.colors=rainbow(24)
plot(1:24,pch=19,cex=2,col=my.colors)

my.colors_2=topo.colors(24)
plot(1:24,pch=19,cex=2,col=my.colors_2)

my.colors_3=heat.colors(24)
plot(1:24,pch=19,cex=2,col=my.colors_3)

my.colors_4=cm.colors(24)
plot(1:24,pch=19,cex=2,col=my.colors_4)

plot(Sepal.Width~Sepal.Length, data=iris,xlab="sepal Length", ylab="Sepal Width",las=1, pch=19, cex=3, col=rgb(1,0,0,0.25))

par(mfrow=c(1,2))
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",las=1,pch=19,col= "#00FF00")
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width",las=1,pch=19,col= "tomato")

?par
par

head(iris$Species)

as.numeric(iris$Species)

plot(Sepal.Width~Sepal.Length,data=iris, xlab="Sepal Length", ylab= "Sepal Width", las=1, pch= 19, col=as.numeric(iris$Species))

colorset=rainbow(3)
pt.cols=colorset[as.numeric(iris$Species)]

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab= "Sepal Width", las=1, pch=19, col=pt.cols)

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, pch=19, col=pt.cols)
legend("bottomright", legend=c("I. setosa", "I. versicolor", "I. virginica"), pch=19, col=colorset)
