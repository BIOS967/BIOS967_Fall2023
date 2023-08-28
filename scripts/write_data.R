### This script simply takes the iris dataset and saves it as a .csv file in the "data" subfolder

write.csv(iris, "data/iris.csv")
#note that I'm including "data/" in the file name. This places the file in that subfolder.

#Let's also generate a plot and save it to the "figures" subfolder. We'll get to an explanation of this code when we cover plotting, but try running this code.
png("figures/plot.png")
plot(Petal.Length~Species, data=iris)
dev.off()