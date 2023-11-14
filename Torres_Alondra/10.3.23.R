#custom functions

1:10
mean(1:10)

sum(1:10)/length(1:10)

#make this into a function
mean.custom=function(y) sum(y)/length(y)

#use it
mean.custom(y=1:10)
mean.custom(iris$Sepal.Length) #my custom mean function

mean(iris$Sepal.Length) #base R mean function

## if else statements

4%%2
5%%2

4%%2==0 #is the remainder of 4/2 equal to 0?
5%%1==0

# ask if a number is even or odd
num=4
if(num %% 2==0) print("this numer is even")

num=7
if(num %%2 == 0) print("this number is even") else print
("this number is odd")
#make
eve.or.odd=function(num) if (num %% 2==0) print("this number is even") else print("this number is odd")

even.or.odd(5)
even.or.odd(204)
even.or.odd(209875983729835)

even.or.odd(3.5)
eve.or.odd=function(num) if (num %% 2==0) print("this number is even") else
if(num %% 2==1) print("this number is odd") else
print("this number is neither even nor odd")

eve.or.odd(5.3)
#how to fix the function, option 2: Only run the function if the input is an integer
even.or.odd= function (num) {
if(num%% 1 !=0) print("this is not an integer") else
if (num %% 2== 0) print("this number is even") else
if (num%% 2==1) print("this number is odd")}

even.or.odd(5.3)

##example: custom function for averages

#arithmetic mean of 1:10

sum(1:10)^(1/length(1:10))

#geometric mean of 1:10
prod(1:10)^(1/length(1:10))

#custom function for averages
average=function(x, type){
if (type=="aritmetic") sum(x)/length(x) else
if(type=="geometric") prod(x)^(1/length(x))
}
average(1:10,type="aritmetric")
## [1] 5.5
average(1:10, type="geometric")
## [1] 4.528729

v=c(1,4,7,2,9,3,8,5,6)
v
## [1] 1 4 7 2 9 3 8 5 6
sort(v)
## [1] 1 2 3 4 5 6 7 8 9
v.sort=sort(v) #save the sorted vector
n=length(v.sort) #get the length of the sorted vector
v.sort[n/2+1] #get the middle number (when there are odd set of numbers)
w=c(v, 10)
w
w.sort=sort(w) #save the sorted vector
n=length(w.sort) #get the length of the sorted vector
(w.sort[n/2]+w.sort[n/2+1])/2 #get the middle number (when there are odd set of numbers)
average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(x)
  else if (type=="geometric") prod(x)^(1/length(x))
  else if (type=="median"){
    n=length(x)
    x.sort=sort(x)
    if(n %% 2 == 1) x.sort[n/2+1] else
      if(n %% 2 ==0) (x.sort[n/2]+x.sort[n/2+1])/2
  }
}
average(1:10, type="median")
average(1:10, type="mode")
average=function(x, type="arithmetic"){
  if(type=="arithmetic") sum(x)/length(x)
  else if (type=="geometric") prod(x)^(1/length(x))
  else if (type=="median"){
    n=length(x)
    if(n %% 2 == 1) x[n/2+1] else
      if(n %% 2 ==0) (x[n/2]+x[n/2+1])/2
  }
  else ("I don't know that one")
}
average(1:10, type="mode")
