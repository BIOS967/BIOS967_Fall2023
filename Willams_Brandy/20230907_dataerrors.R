# sample data import problems

errdat=read.csv("data/SampleData_w_errors.csv")
errdat

#look at structure of data
str(errdat)
#size and weight are being read as characters instead of numbers
errdat$size

#Problem-N/A as a value
#SLn- tell R that #N/A! should be treated as NA
errdat=read.csv("data/SampleData_w_errors.csv", na.strings="#N/A!")
#this tells r that "N/A! should be treated as na
errdat
errdat$weight


# to deal with the same problem in size, also designate "**" as NA
errdat=read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!","**"))
errdat
errdat$size
#to calculate something from numeric vector with NA's, tell it to ignore NA using na.rm=T
mean(errdat$size, na.rm=T)
str(errdat)

#To remove column "X"
names(errdat)#give me column names
names(errdat)== "X"#are any columns called "X"?
which(names(errdat)=="X")#which column is called "X"

errdat[,which(names(errdat)=="X")]#give me the values for the column called "X" in dataframe "errdat"

dat=errdat[,which(names(errdat)!="X")]#give me all columns EXCEPT the one called "X"
#comma before requests all rows, if you want a specific row, put the row number
dat

#remove any rows missing individual ID
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2


#Plotting Basics:
plot(dat2$size,dat2$weight)
#made a scatter automatically plot b/c 2 numerical values plotted against each other
#1 continuous variable vs another continuous variable

#same plot in "formula" notation, ex:y~x
plot(dat2$weight~dat$size)

#alt way: use variable names, then "data=" to designate the data frame they come from
plot(weight~size, data=dat2)

boxplot(weight~sex,data=dat2)


