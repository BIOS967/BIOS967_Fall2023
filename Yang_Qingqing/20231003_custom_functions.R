#custom functions

#sequence of integers 1 to 10
1:10
mean(1:10)
#the mean function does sum(1:10)/length(1:10)
#make this into a function
mean.custom <- function(y) sum(y)/length(y)

#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length) == mean(iris$Sepal.Length)

#if else statements
4 %% 2
5 %% 2
# %% is an operator for giving you the remainder of dividing the first thing by the second

4 %% 2 == 0 #is the remainder of 4/2 equal to zero? IFF true, then 4 is even.
5 %% 2 == 0

#ask if a number is even or odd
num = 4
if (num %% 2 == 0) print("this number is even")

#make it tell you it's even or tell you it's odd
num = 4
if (num %% 2 == 0) print("this number is even") else print("this number is odd")

#putting the above in an ifelse function
ifelse(num %% 2 == 0, "this number is even", "this number is odd")

#make a custom function to tell if a number is even or odd
even.or.odd = function(num) if (num %% 2 == 0) print("this number is even") else print("this number is odd")

even.or.odd(204)
#this doesn't work for non-integers
#we need to anticipate all the different ways it could mess up

#option 1
#tell us it's odd IFF the remainder is 1
even.or.odd = function(num) if (num %% 2 == 0) print("this number is even") else if (num %% 2 == 1) print("this number is odd")

even.or.odd(5.4)

even.or.odd = function(num) if (num %% 2 == 0) print("this number is even") else
  if (num %% 2 == 1) print("this number is odd") else
    print ("this number is neither even nor odd")

#option 2
#only run the function if the input is an integer
even.or.odd = function(num) {
  if (num %% 1 != 0) print("this is not an integer") else
    if (num %% 2 == 0) print("this number is even") else
      if (num %% 2 == 1) print("this number is odd")
}
even.or.odd(54.2)

#example: custom function for averages

#arithmetic mean of 1:10
sum(1:10)/length(1:10)
#geometric mean of 1:10
prod(1:10)^(1/length(1:10))

#custom function for averages
average <- function(x, type) {
if(type=="arithmetic") sum(x)/length(x) else
  if(type=="geometric") prod(x)^(1/length(x))
}
#this version doesn't have a default type
average(1:10, type = "arithmetic")

#let's create one with default type arithmetic
average <- function(x, type="arithmetic") {
  if(type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}

average(1:10) #will apply the default type
average(1:10, type="geometric") #but we can override the default to calculate other types of averages
