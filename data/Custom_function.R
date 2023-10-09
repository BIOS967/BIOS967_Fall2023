#custome function
1:10
mean(1:10)

#creating function
mean.custom=function(y){sum(y)/length(y)}
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length)
mean(iris$Sepal.Length)


##if else statement

#%% gives remainder
4%%2
3%%2

4 %% 2 ==0
3%%2==0

#using if statement
num = 4
if(num %%2 ==0) print ("this number is even")
#using else statement
num = 5
if(num %%2 ==0) print ("this number is even") else print("this number is odd")

#ifelse() function
ifelse(num%%2==0, "this number is even", "this number is odd")

#if a number is even or odd
even.or.odd = function(num) if (num %% 2 ==0) print("this number is even") else print("this number is odd")
even.or.odd(5)
even.or.odd(221010204563276)

#tell us it's odd only when the remainder is 1
even.or.odd = function(num) if (num %% 2 ==0) print("this number is even") else if (num%%2==1) print("this number is odd")
even.or.odd(4)
even.or.odd = function(num) if (num %% 2 ==0) print("this number is even") else if (num%%2==1) print("this number is odd") else print("this number is neither even nor odd")
even.or.odd(1.5)
#don't run if the input is not an integer
even.or.odd = function(num) {
  if (num%%1 !=0) print("this number is not an integer") else
    if (num %% 2 ==0) print("this number is even") else
    if (num%%2==1) print("this number is odd")
}
even.or.odd(5)

#example of custom function
sum(1:10)/length(1:10)
#geometric mean of 1:10
prod(1:10)^(1/length(1:10))

average=function(x, type){
  if(type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}
average(1:10, type = "arithmetic")


#let's fix difault as arithmetic
average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(x) else
    if(type=="geometric") prod(x)^(1/length(x))
}

#for geometric
average(1:10, type = "geometric")
