eggs=read.csv("data/EggMeasurements_example.csv")
head(eggs)
str(eggs)
unique(eggs$mass)
unique(eggs$length)
unique(eggs$width)
eggs=read.csv("data/EggMeasurements_example.csv",na.strings=".")
unique(eggs$mass)
str(eggs)
sort(unique(eggs$LayDate))
eggs=read.csv("data/EggMeasurements_example.csv", na.strings=c("#N/A!", "########", "."))
eggs
eggs=eggs[which(eggs$LayDate!="NA"),]
eggs
plot(Nest, LayDate)
Plot(mass, LayDate)
plot(eggs$mass~eggs$EggVolume)
