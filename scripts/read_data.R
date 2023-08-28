## This script simple reads in a dataset.
## Let's try reading in the "SampleData.csv" file in the "data" subfolder.

dat=read.csv("data/SampleData.csv")
dat

## Note two things:

#1. Even though this script is in the "scripts" subfolder, you did not have to go back "up" one folder to point to the "data" folder. This is because the pathname is relative to where the .Rproj file is, and it is in the main folder.

#2. Because the pathname is just relative to where the .Rproj file is, that means that the pathname would be identical no matter what computer you cloned this repository (directory) to. That is, you can run the exact same code on whatever machine you're on, as long as you open this as an Rstudio Projects file. That is super convenient!!

#compare that to if I ran the read.csv() function with the absolute pathname I have for this dataset on my computer:

dat_v2=read.csv("/Users/dshizuka/Documents/GitHub/BIOS967_Fall2023/data/SampleData.csv")
dat_v2
# I could run this code on my laptop, but it will not run on your computer (nor will it run on my office desktop or any other computer) because the absolute path to this file is different on your computer. This is why you should always create your scripts within a well-organized Rstudio Projects directory/repository. It makes collaboration--even with yourself--much easier.
