# October 3 2023
# Custom Functions


#Basic syntax of a function
  #function(x) {the function you want to do using the variable you defined after function (in this     #case x)}

  #the x is the input, and must be used in teh code/function
  #you can have multiple inputs!

1:10
mean(1:10)

#what if we want to create our own mean function?
sum(1:10)/length(1:10)
mean.function<-function(x){sum(x)/length(x)}
mean.function(1:10)


#Now lets shift gears and understand if/else statements

#If(condition) {code similar to function}
  #condition is normally a T or F based condition

4%%2
# %% gives you the remainder
4%%7

4%%2 ==0 #this asks if the remainder is 0

#ask if a number is even or odd
number =72
if(number%%2 ==0) print("This number is even") else print("This number is odd")

eveness.function <- function(x){if(x%%2 ==0) print("This number is even") else print("This number is odd")}
eveness.function(3)

#There is also an ifelse function
eveness.function(3.2)

class(3.2) == "int"

#This is still all fucked up...
eveness.function.up1 <- function(x){if(x%%1 != 0) print("This number is not an int"){
  if(x%%2 ==0) print("This number is even")
  }
  else
  if( x%%2 ==1) print("This number is odd")
  }


eveness.function.up1(4)













#Function for averages : both arithmatic mean and geometric mean

average <- function(x, type){
 if(type == "arithmatic") sum(x)/length(x) else
   if(type == "geometric") prod(x)^(1/length(x))
}

average(1:10, type="arithmatic")


average <- function(x, type="arithmatic"){
  if(type == "arithmatic") sum(x)/length(x) else
    if(type == "geometric") prod(x)^(1/length(x))
}
average(1:10, type= "geometric")
