#data import problems

errdat=read.csv("data/SampleData_w_errors.csv")
errdat

#look at structure of data
str(errdat)
#problem: size
errdat$size
mean(errdat$size)

#problem: weight is not a number
errdat$weight
#this problem is caused by this inclusion of #N/A! as a value.
#solution tell R that this is a missing value when importing the data.
errdat=read.csv("data/SampleData_w_errors.csv", na.strings = "#N/A!")
#this tells R that "#N/A should be treated as NA
errdat
errdat$weight
#to deal with the same problem in size, also designate"**" as NA
errdat=read.csv("data/SampleData_w_errors.csv", na.strings = c("N/A!","**"))
errdat
errdat$size
mean(errdat$size, na.rm=T) #to calculate something from numeric vector with NA, tell it to ignore NA using NA.rm=T

#to  remove column "X":

names(errdat) #give me the column names
names(errdat)=="X"  #are any of the columns called"X"?
which(names(errdat)=="X")  #which column is called "X"?

errdat[,which(names(errdat)=="X")] #give me the values for the column called "X" in data frame "errdat"

dat=errdat[,which(names(errdat)!="X")]  #give all of the columns EXCEPT the one called "X"
dat

#let's remove any rows that is missing an individual ID
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2

#plotting basics:

plot(dat2$size,dat2$weight)  #plot one continuous variable against another

plot(dat2$weight~dat2$size)  #same plot in 'formula' notation, i.e., y~x

plot(weights~size, data=dat2) #alternative way use variable names in the formula, then data- to designate the data frame they come from.

boxplot(weights~sex, data=dat2)

