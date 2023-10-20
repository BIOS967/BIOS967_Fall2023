#custom functions

1:10 #gives us 1 to 10 integers
mean(1:10) #prepackaged mean function

sum(1:10)/length(1:10) #this gives us the mean

#make this into a function
mean.custom = function(y) sum(y)/length(y)

mean.custom(y=1:10)
mean.custom(iris$Sepal.Length) #my custom mean fuction
mean(iris$Sepal.Length) #R mean function


#if else statements

4 %% 2 # %% gives the remainder from division
5 %% 2

4 %% 2 == 0 #this asks, is the remainder of 4/2 equal to 0? TRUE
5 %% 2 == 0 #FALSE

#ask if a number is even or odd
num = 7
if (num %% 2 == 0) print("this number is even") else print("this number is odd mf")

#ifelse() function
ifelse(num %% 2 == 0, "this number is even", "this number is odd")

#make a custom function to tell if a number is even or odd
even.or.odd = function(num) if (num %% 2 == 0) print("this number is even") else print("this number is odd mf")

even.or.odd(2075775)

even.or.odd(2.5) #currently, this gives us the wrong answer, because only integers can be even or odd.

#how to fix this: option 1
#tell us it's odd only when the remainder is 1
even.or.odd = function(num) if (num %% 2 == 0) print("this number is even") else if (num %% 2 == 1) print("this number is odd mf")

even.or.odd(5)
even.or.odd(5.5) #still haven't fixed this

even.or.odd = function(num) if (num %% 2 == 0) print("this number is even") else
  if (num %% 2 == 1) print("this number is odd mf") else
    print ("this number is neither even nor odd")

even.or.odd(5.5) #nice!


#how to fix the function, option 2: only run the function if the input is an integer

even.or.odd = function(num) {
  if(num %% 1 !=0) print("this is not an integer") else
    if(num %% 2 == 0) print("this number is even") else
      if(num %% 2 == 1) print("this number is odd mf")
    else print ("this number is neither even nor odd")
}

even.or.odd(4.2)

# example : custom function for averages
#arithmetic mean
sum(1:10)/length(1:10)
#geometric mean
prod(1:10)^(1/length(1:10))

#CUSTOM FUNCTION FOR AVERAGES
average = function(x, type){
  if(type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}

#creating one for specific type, requires you to overwrite, or else selects default
average = function(x, type = "arithmetic"){
  if(type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}

average(1:10)

average(1:10, type="geometric")