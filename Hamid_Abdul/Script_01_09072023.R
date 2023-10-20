# data import problems

errdata=read.csv("data/SampleData_w_errors.csv")
errdata
#look at structure of data
str(errdata)
errdata$size
mean(errdata$size)

#problem: weight is not a number
errdata$weight
#this problem is caused by inclusion of #N/A as a value.
# solution: tell R that this is a missing value when importing the data.

errdat=read.csv("data/SampleData_w_errors.csv", na.strings="#N/A")
errdat
errdat$weight

#to deal with th esaem problem in size also designate "**" as NA
errdat=read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!","**"))
errdat
mean(errdat$size,na.rm=T)#to calculate something from numeric vector with NAs, tell it to ignore NAs using na.rm=T

names(errdat) #give me the column name
names(errdat)=="X" #are any of the column called "X"?
which(names(errdat)=="X") # which column is called "X"?

errdat[,which(names(errdat)=="X")] #give me the value for the column called "X" in the dataframe "errdat".

dat=errdat[,which(names(errdat)!="X")] # give me all of the columns except the on ecalled "X"
dat

#lets remove any rows that is misssing an individual ID
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2

#plotting basics:

plot(dat2$size, dat2$weight)#plot one continuos variable against another
plot(dat2$sex, dat2$weight)

plot(dat2$weight~dat2$size) #same plot as 'formula' notation. i.e., y-x

plot(weight~size, data=dat2) # alternative way: use variable name in the formula, then data= to designate the dataframe they come from

boxplot(weight~sex, data=dat2)
boxplot(weight~sex, data=dat2)

