#data import problems
errdat=read.csv("data/SampleData_w_errors.csv")
errdat

#look at structure of data
str(errdat)

#problem: size is not a number here
errdat$size
mean(errdat&size)

#weight is not a number
errdat$weight
#this problem is caused by the inclusion of #N/A! as a value
#solution: tell R that this is a missing value when importing the data
errdat=read.csv("data/SampleData_w_errors.csv", na.strings="#N/A!")

#to deal with the same problem in size, also designate "**" as NA
errdat=read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!", "**"))
errdat
errdat$size
mean(errdat$size, na.rm=T) #TO calculate something from numeric vector with NAs, tell it to ignore NA using na.rm=T

#to remove column "X":
names(errdat) #give me the column names
names(errdat)=="X" #are any of the columns called "X"?
which(names(errdat)=="X") #which column is called "X"?
errdat[,which(names(errdat)=="X")] #give me the values for the column called "X" in dataframe "errdat"
#EMPTIED the ROW part before the comma as you want all the columns to be changed. If you want to specify the row, you can put a ni-umber before the comma

dat=errdat[,which(names(errdat)!="X")] #give me all of the columns EXCEPT the one called "X"
dat

#let's remove any rows that is missing an individual ID
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2

#plotting basics:
# factor: integers/levels numeric: continuous characters:discrete(not levels)/categories

plot(dat2$size, dat2$weight) #automatically shows scatterplot on PLOTS, as plot one continuous variable AGAINST ANOTHER
plot(dat2$weight~dat2$size) #same plot in 'formula' notation, i.e y~x
plot(weight~size, data=dat2)
#alternative way: use variable names in the formula, then data= to designate the dataframe they come from

boxplot(weight~sex, data=dat2)
