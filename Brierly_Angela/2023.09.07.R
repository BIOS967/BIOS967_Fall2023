# 09/07/2023  Data import problems

errdat=read.csv("data/SampleData_w_errors.csv")
errdat

# LOOK AT STRUCTURE OF DATA
str(errdat)
# this told us what data type each column is (character, number(integer), etc.)

#Problem: size is not a number # tells us what the problem is
errdat$size

mean(errdat$size)


# Problem: Weight is not a number
errdat$weight
#this problem is caused by the inclusion of #N/A! as a value.
#SOLUTION: tell R that this is a missing value when importing the data.

errdat=read.csv("data/SampleData_w_errors.csv", na.strings="#N/A!")
#this tells R that "$N/A!" should be treated as NA.
errdat
errdat$weight

#to deal with the same problime in the size column, also designate "**" as NA.
errdat=read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!","**"))
errdat
errdat$size
#to calculate something from numeric vector with NAs, tell it to ignore NA using "na.rm=T"
mean(errdat$size, na.rm=T)

# To REMOVE COLUMN "X":
names(errdat)  #give me the column names
names(errdat)=="X"  #do any column names equal "X"?
which(names(errdat)=="X") #WHICH column is called "X"?
errdat[,which(names(errdat)=="X")] #give me the values for the column called "X" in dataframe "errdat"

dat=errdat[,which(names(errdat)!="X")] #give me all of the columns EXCEPT the one called "X" and call it "dat".
dat

# To remove any ROWS that are missing an individual ID or whatever row you dont want.
dat$Indiv_ID
dat2=dat[which(dat$Indiv_ID!=""),]
dat2



# PLOTTING BASICS:

plot(dat2$size, dat2$weight)  # Plot 2 continuous numeric values against each other.

plot(dat2$weight~dat2$size)  # same as above but in "FORMULA" notation, i.e., y~x.

plot(weight~size, data=dat2)  # Alternative way to use variable names in the formula, then data= to designate the dataframe they come from.

boxplot(weight~sex, data=dat2)  #Using it in a BOXPLOT.
