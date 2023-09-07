## Working Through Data With Errors

#Data importing .CSV File
errdat= read.csv("data/SampleData_w_errors.csv")
errdat

#Look at structure of data
str(errdat) #str gives overview of what this data structure looks at including class (vector)

#Problem: Size is not numbers
errdat$size
#See this prints out the size as characters!
#How can we fix this??
#And neither is weight!


#We could go to the excel and fix the issue... But what if we messed up the data?
#What if collaborators use the not updated excel??

#So what other solutions can we do on the R side?
#Problem 1: Weight is not a number
#Reason Why 1: The #N/A! IS a character; also the "" at the end!
#Solution 1: Tell R that the #N/A! is a missing value when importing the data

errdat= read.csv("data/SampleData_w_errors.csv", na.strings = "#N/A!")
errdat
errdat$weight
# Now #N/A! is read as NA
##It also solved the "" ==> blank as a character can be a character...
##BUT blank as a number is nothing but missing data!!


#Problem 2: Size is a character
#Reason why 2: the **
#Solution 2: Do the same thing!

errdat= read.csv("data/SampleData_w_errors.csv", na.string=c("#N/A!","**"))
errdat

#Problem 3: this
mean(errdat$size)
#Fit by
mean(errdat$size, na.rm=T)
#Now we can actually calculate the mean by telling R to forget about the NA


#Problem 4: What the heck is Column "X"!?
#Lets look at the excel to see if we can get any ideas
#Luckily (or planned) the excel tells us that the X is a random value in a column, probably a data entry error!
#So lets remove the column... but in R; who knows maybe there's a reason for it!
#Solution 3: remove that column, or remove any column with no column name!

#to remove column X

names(errdat) #this gives us the column names
names(errdat)=="X"   #For any of the column names, do any of them 'equal' X
which(names(errdat)=="X") #Whuch column is called X?
errdat[,which(names(errdat)=="X")] #Give me the values for the column called "X" in dataframe "errdat"

dat=errdat[,which(names(errdat)!="X")]
dat
errdat[,1:5] #This would work for a small data set like this, but what if it is huge?

#Problem 5: That last row!?
#Do the same thing but for rows rather than columns
#SO let's remove any rows that are missing individual IDs

dat$Indiv_ID #lets taget the row where the ID is "" (blank)
dat2=dat[which(dat$Indiv_ID != ""),]  #We don't need the names because we are looking specifically at the data
dat2


#which(names(dat$Indiv_ID) != "")

#Why does it break the way it does when we use names??



# Starting Plotting: Back to the Basics -----------------------------------
#To start, what kind of vectors do we have?
#Factors (integers/levels) (Where levels is like a binary or set defined as numbers ie- 0 or 1)
#Numeric (continuous)
#Characters (Child or Adult, M or F, etc)
#Time

#Scatterplot: 2 continuous variables against each other
#Box Plot: ! continuous variable over a category
#Lineplot: Continuous over time, etc

plot(dat2$size,dat2$weight) #This plots a continuous variable over another continuous

plot(dat2$sex, dat2$weight)  #Uh oh this no work-ie

plot(dat2$weight~dat2$size) #So what is this saying? Its the same plot in formula notation? ie- y~x

plot(weight~size, data=dat2) #This is much more crisp/clean! #Variable names should be case and spelling sensitive





