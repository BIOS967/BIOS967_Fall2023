#09-05-2023---------------------------------------------------------------------

#09-07-2023---------------------------------------------------------------------
errdat=read.csv("data/SampleData_w_errors.csv")
errdat
#look at structure of data
str(errdat)
#problemLsize is not a number here.
errdat$size

#problem: weight is not a number
errdat$weight

#this problem is caused by the inclusion of $N/A as value.
#solution: tell R that this is a missing value when importing the data
errdat=read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!","**"))
errdat
errdat$weight
mean(errdat$size, na.rm = T) #to calculate something from numeric vector with
#NAs, tell it to ignore NA using na.rm=T

#to remove column "X"
names(errdat)
names(errdat)=="X" #are any of the columns called "X"
which(names(errdat)=="X") #which column is called "X"
#give me the values for the column called "X" in df "errdat"
errdat[,which(names(errdat)=="X")]
#give me all the columns EXCEPT the one called "X"
dat=errdat[,which(names(errdat)!="X")]
dat

#let's remove any rows that is missing an individual ID
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2

#plotting basics:
plot(dat2$size,dat2$weight)#plot one continuous

plot(dat2$weight~dat2$size)#plot in 'formula'

plot(weight~size,data=dat2)
boxplot(weight~size,data=dat2)


