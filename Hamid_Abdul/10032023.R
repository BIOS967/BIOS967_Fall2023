#10032023

#Custom Functions

1:10
mean(1:10)

sum(1:10)/length(1:10)

#make this into function

mean.custom=function(y) sum(y)/ length(y)

#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length)


#if else statement

4 %% 2
5 %% 2
5 %% 2.5
4 %% 2 == 0 # is the remainder of 4/2 is 0 
5 %% 2 == 0

#ask if a number is even or odd
num = 4
if (num %% 2 == 0) print ("this number is even")


num = 7
if (num %% 2 == 0) print ("this number is even") else print ("this number is odd")

#ifelse() function
num=8
ifelse(num %% 2 == 0, "this number is even", "this number is odd")


#make a custom function to tell if an number is even or odd
even.or.odd=function(num) if (num %% 2 == 0) print ("this number is even") else print ("this number is odd")

even.or.odd(9)

even.or.odd(2.5) #currently, this give us the wrong answer because only integers can be even or odd

# how to fix this: option1
# tell us it's odd only if remainde is 1

even.or.odd=function(num) if(num %% 2 == 0) print ("this number is even") else if (num %% 2 == 1) print ("this number is odd")

even.or.odd(5.5)

even.or.odd=function(num) if(num %% 2 == 0) print("this number is even") else if (num %% 2 == 1) print("this number is odd") else print("this number is neither even or odd")
even.or.odd(5.3)

#how to fix function, option2: only run the function if the input is integer

even.or.odd=function(num) {
  if(num %% 1 !=0) print("this is not an integer") else
    if (num %% 2 == 0) print("this number is even") else 
      if (num %% 2 == 1) print("this number is odd")
}
even.or.odd(3.3)


## example: cutom function for averages 

#arithmatic mena of 1:10 
sum(1:10)/length(1:10)

#geometric mean of 1:10
prod(1:10)^(1/length(1:10))

#custom function for averages
average=function(x, type){
  if (type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}

average (1:10, type="arithmetic")


#lets create one with defalult type= "arithmetic

average=function(x, type= "arithematic"){
  if (type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}

average(1:10) 
#will apply the default type "arithmetic"
