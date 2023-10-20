#custom functions!!!
# how to write, aka syntax: function("input arguments") {"code for what to do with the inputs"}
# example of ^: function(x) {blah blah blah}

1:10
mean(1:10)

sum(1:10)/length(1:10)

#make this into a function
mean.custom=function(y) sum(y)/length(y)

#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length)# mine
mean(iris$Sepal.Length)#base R

#if else statements

4 %% 2 #what is left after dividing the whole numbers

#ask if number is even or odd

num=4
if(num %% 2==0) print ("this number is even") # true so printed the phrase
if(num %% 3==0) print ("this number is even")



num=4
if(num %% 2==0) print ("this number is even") else print ("this number is odd")
if(num %% 3==0) print ("this number is even") else print ("this number is odd")

#if else () functions
num=8
ifelse(num %% 2==0, "this number is even, "this number is odd"")

#make a custom function to tell if number is even or odd


