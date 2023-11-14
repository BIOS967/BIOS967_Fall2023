#custom functions

1:10
mean(1:10)

sum(1:10)/length(1:10)

#make this into a function
mean.custom=function(y) sum(y)/length(y)

#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Legth) #my custom mean function


##if else statement
4 %% 2
5%%2
5%%3
6 %% 4
4 %% 2

4 %% 2 == 0 # is the remainder of 4/2 equal to 0?
5 %% 2 == 0

# ask if a number is even or odd
num = 4
if(num %% 2 == 0)print ("this number is even")

num=7
if(num %% 2 == 0)print ("this number is even") else print ("this number is odd")

#ifelse() function
num=8
ifelse(num %% 2 == 0, "this number is even", "this number is odd")
num=5

#make a custom function to tell if a number is even or odd
even.or.odd=function(num) if(num %% 2 == 0)print ("this number is even") else print ("this number is odd")

even.or.odd(5)
even.or.odd(6)
even.or.odd(16516)
even.or.odd(6.3) #currently, this gives us the wrong answer because only integers can be even or odd

##how to fix this: option 1.
#tell us it's odd only when the remainder is 1
even.or.odd=function(num) if(num %% 2 == 0)print ("this number is even") else if (num %% 2==1) print ("this number is odd")
even.or.odd(5.3)
even.or.odd(5)

even.or.odd=function(num) if(num %% 2 == 0)print ("this number is even") else
  if (num %% 2==1) print ("this number is odd") else
    print("this number is neither even or odd")

even.or.odd(5.5)

##how to fix the function: option 2.
# only run the function if the input is an integer


##example: custom function for averages
# arithmetic of 1:10
sum(1:10)/length(1:10)
#geometric mean of 1:10
prod(1:10)^(1/length(1:10))
#custom function for averages
average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(X) else
    if(type=="geometric") prod(x)^(1/length(x))}


