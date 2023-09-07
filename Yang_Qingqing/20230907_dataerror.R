#data import problems

errdat <- read.csv("data/SampleData_w_errors.csv")
errdat

#problems: extra row

############## look at structure of data #######################
str(errdat)      #tells you the type (character or numbers)
#problem: weight and size should be numbers but they are characters
errdat$size #they are in quotes
mean(errdat$size) #you can't calculate the mean because they are characters


################ Address problems #########################

#2 ways to fix these problems:
  #1. go to excel file and fix them. Problem: you don't want to mess with raw data.
  #   Also, data versions may be inconsistent
  #2. fix the problems in the R script. You have a record of these changes
  #   and makes the error-checking process reproducible


####Problem: weight is not a number####
#it is interpreted as a character in part because one of the values is a character
errdat$weight
#this problem is caused by the inclusion of "#N/A!" as a value
#solution: tell R that this is a missing value when importing the data
errdat <- read.csv("data/SampleData_w_errors.csv", na.strings="#N/A!")
#this tells R that "#N/A!" should be treated as NA
errdat
errdat$weight
#now it is numeric, and the empty value got designated as NA too because it's numeric.


#### Problem: size is not a number ####
#also designate ** as NA
errdat <- read.csv("data/SampleData_w_errors.csv", na.strings=c("#N/A!", "**"))
#need to concatenate the two
errdat
errdat$size
str(errdat)
mean(errdat$size, na.rm=T) #tells it to remove the NAs when calculating


#### Problem: need to remove column X ####
names(errdat) #gives you all the column names
names(errdat) == "X" #"does this column name equal X?" for each column
which(names(errdat)=="X") #which column is called X?
errdat[,which(names(errdat)=="X")] #gives you the values for the column called X in dataframe errdat
dat=errdat[,which(names(errdat)!="X")] #gives you all of the columns except the one called X
dat

#### Problem: a row has no data ####
#think about what criteria you want for removing rows
#let's remove rows that are missing an individual ID
dat$Indiv_ID
dat2 <- dat[which(dat$Indiv_ID!=""),] #exclude blank Indiv_ID rows
#by naming these new dataframes differently, we avoid overwriting the raw data
#avoid having code do different things based on where in the process it is
dat2


################################### Plotting basics ###################################
plot(dat2$size, dat2$weight) #plot two continuous variables, "x, y"

plot(dat2$weight~dat2$size) #same plot in formula notation, "y ~ x"

plot(weight~size, data=dat2) #you can also use variable names in the formula
                             #and then data= to designate dataframe


boxplot(weight~sex, data=dat2)

