## 2023.10.03
# CUSTOM FUNCTIONS

1:10
mean(1:10)

sum(1:10)/length(1:10)

# make this into a function
mean.custom=function(y) sum(y)/length(y)

# to use this function you made
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length) #my custom mean function

mean(iris$Sepal.Length) #Base-R mean fucntion
# _________________________________________________________________________
## IF-ELSE statements to add arguments inside functions

4 %% 2  # to find out the "remainder" when they're divided, so you can IF...even or odd
5 %%2
5 %% 2

4 %% 2 ==0 # is the remainder of 4/2 equal to 0?
5 %% 2 ==0
# ___________________________________________________________________
# Ask if a number is even or odd
num=4
if (num %% 2 ==0) print("this number is even") else print("this number is odd")

# __________________________________________________________________
# ifelse() function
num=4
ifelse(num %% 2 ==0, "this number is even", "this number is odd")

# __________________________________________________________________
# Make a custom functin to tell if a number is even or odd
even.or.odd=function(num) if (num %% 2 ==0) print("this number is even") else print("this number is odd")

even.or.odd(5)
even.or.odd(22)
even.or.odd(3.4) # currently this gives us the wrond answer b/c only integers can be EVEN or ODD

## HOW to fix this: Option 1
## tell us it's odd only when the remainder is 1
even.or.odd=function(num) if (num %% 2 ==0) print("this number is even") else
  if (num %% 2 ==1) print("this number is odd") else
    print("this number is neither even or odd")

even.or.odd(5.3)
even.or.odd(3.4)

## HOW to fix this: Option 2
## Only run the function if the input is an integer; { means group these commands}
# note, the !=0 tells us if its an integer??
even.or.odd=function(num) {
  if (num %% 1 !=0) print("this is not an integer") else
    if (num %% 2 ==0) print("this number is even") else
  if (num %% 2 ==1) print("this number is odd")
}

even.or.odd(5)
even.or.odd(2.1)

# ___________________________________________________________________________
## Example: CUSTOM FUNCTION FOR AVERAGES

#ARITHMETIC mean is (2+4)/2
sum(1:10)/length(1:10)

#GEOMETRIC mean is  (2x4)^ 1/2
prod(1:10)^(1/length(1:10))

#Custom function for AVERAGES
# this version does NOT have a default "type"
average=function(x, type){
  if(type== "arithmetic") sum(x)/length(x) else
    if(type == "geometric") prod(x)^(1/length(x))
}

average(1:10, type = "arithmetic")

# One with a default type
average=function(x, type="arithmetic"){
  if(type== "arithmetic") sum(x)/length(x) else
    if(type == "geometric") prod(x)^(1/length(x))
}
average(1:10)
# OR you can override the default "type" to calculate other types of averages
average=function(x, type="arithmetic"){
  if(type== "arithmetic") sum(x)/length(x) else
    if(type == "geometric") prod(x)^(1/length(x))
}
average(1:10, type= "geometric")

#____________________________________________________________________________
# MEDIANS---see Dai's website

#___________________________________________________________________________







