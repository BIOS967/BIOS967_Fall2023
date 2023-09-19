#September 19th 2023
#Learning ggplot

#base R vs ggplot2

#Base R
#workflow is to learn the plotting functions
#Then within the function you have different elements
#(ie-color)
#Add elements with new functions!

#ggplot2
#Uses different grammar of graphics
#Componetes:
  #The Data
  #use aes() to add aesthetics
      #This tells us how the variables are related to
      #each other
  #Then we tell it what kind of geometric object we want
  #to make using geom (ie- geom_point, ...)
  #scaling: assigning values to the variables (This is where
  # we would add color for species)
  #Theme: legends
#So in a way its almost like ggplot2 is backwards of base R

## NOTE: IF YOU ARE RUNNING THIS AND IT FAILS, YOU MAY NEED TO UN-COMMENT THE BELOW LINES TO GET THE PACKAGES
#library(BiocManager)
#BiocManager::install(ggplot2)
#or
#install.packages("ggplot2")

library(ggplot2)

#BASE R

plot(Sepal.Width~Sepal.Length, data = iris)

plot(Sepal.Width~Sepal.Length, data = iris,
     xlab= "Sepal Length", ylab= "Sepal Width")

plot(Sepal.Width~Sepal.Length, data = iris,
     xlab= "Sepal Length", ylab= "Sepal Width",las=1)

plot(Sepal.Width~Sepal.Length, data = iris,
     xlab= "Sepal Length", ylab= "Sepal Width",las=1,
     col=iris$Species)

plot(Sepal.Width~Sepal.Length, data = iris,
     xlab= "Sepal Length", ylab= "Sepal Width",las=1,
     col=iris$Species, pch=19)



#ggplot
ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
         geom_point()

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=2,pch=21)

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, fill=Species, color="Blue")) +
  geom_point(size=2,pch=21)

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_manual(values=c("black","red","green")) #Assigning colors based on colors given, alphabetical, or order it is given?

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_manual(values=c("black","red","green"))+
  theme_bw()

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_manual(values=c("black","red","green"))+
  theme_classic()

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_manual(values=c("black","red","green"))+
  theme_linedraw()

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_manual(values=c("black","red","green"))+
  theme_light()+
  theme(panel.grid.major=element_blank())

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_manual(values=c("black","red","green"))+
  theme_light()+
  theme(panel.grid.major=element_blank(), panel.grid.minor = element_blank(), legend.position = "none")+
  xlab("Sepal Length")+
  ylab("Sepal Width")

#color palettes in ggplot2
ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2,pch=19)+
  scale_color_brewer(palette = "RdYlBu")+
  theme_light()+
  theme(panel.grid.major=element_blank(), panel.grid.minor = element_blank(), legend.position = "none")+
  xlab("Sepal Length")+
  ylab("Sepal Width")

ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=3,pch=21)+
  scale_fill_brewer(palette = "PRGn")+
  theme_light()+
  theme(panel.grid.major=element_blank(), panel.grid.minor = element_blank(), legend.position = "none")+
  xlab("Sepal Length")+
  ylab("Sepal Width")


#Facet: Plot subsets of data separately
ggplot(data=iris,mapping= aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=3,pch=21)+    #can add in alpha =0.05 to make semitransparent
  scale_fill_brewer(palette = "PRGn")+
  theme_light()+
  theme(panel.grid.major=element_blank(), panel.grid.minor = element_blank(), legend.position = "none")+
  xlab("Sepal Length")+
  ylab("Sepal Width")+
  facet_grid(~Species)


#How to save a figure we made

#You can right click and save as an image

#You can save via code
#Always saves the last plot that you made
ggsave(filename = "Kugel_Ken/Facetted_Sepal.png" )
