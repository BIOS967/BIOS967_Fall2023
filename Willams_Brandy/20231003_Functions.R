#custom functions
1:10
mean(1:10)
sum(1:10)/length(1:10)
#make this into a function
mean.custom=function(y) sum(y)/length(y)
#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length)#custom function
mean(iris$Sepal.Length)#base R function

#If-else functions: if(condition=true)code

4%%2 #giving the remainder....4/2=2, with a remainder of zero
5%%2

4%%2==0 #is the remainder of 4/2 equal to 0?
5%%2==0

#ask if num is even or odd
num=4
if(num%%2==0) print ("this number is even")# tell it if it's an even number, say so

num=7
if(num%%2==0)print("this number is even")else print ("this number is odd") #tell if it's not even, it's odd

#if else () function
num=7
ifelse(num%%2==0,"this number is even", "this number is odd")

#make a custom function to tell in a number is even or odd
even.or.odd=function(num)if(num%%2==0)print("this number is even")else print ("this number is odd")

even.or.odd(5)
even.or.odd(405592)
even.or.odd(937)

#not perfect
even.or.odd(3.5)#3.5 isn't an integer so it's technically not even or odd
#How to fix: option 1

#tell us it's odd only when the remainder is 1

even.or.odd=function(num)if(num%%2==0)print("this number is even")else if (num%%2==1) print ("this number is odd")

even.or.odd(5.5) #code no longer works b/c remainder isn't 1

even.or.odd=function(num)if(num%%2==0)print("this number is even")else if (num%%2==1) print ("this number is odd") else print ("this number is neither even or odd")

 even.or.odd(5.4)

#How to fix pt 2: only run the function is an integer
 even.or.odd=function(num){
   if(num%%1 !=0)print ("this is not an integer") else
     if(num%%2==0) print("this number is even")else
       if(num%%2==1)print("this number is odd")
 }
even.or.odd(5.3)

#custom function for averages

#arithmetic of 1:10
sum(1:10)/length(1:10)
#geometric mean of 1:10
prod(1:10)^(1/length(1:10))
#custom function
average=function(x,type){
  if(type=="arithmetic")sum(x)/length(x)else
    if(type=="geometric")prod(x)^(1/length(x))
}
average(1:10,type="arithmetic")

#create avg function with arithmetic as default
average=function(x,type="arithmetic"){
  if(type=="arithmetic")sum(x)/length(x)else
    if(type=="geometric")prod(x)^(1/length(x))
}
average(1:10)#apply default
average(1:10,type="geometric")#override default



