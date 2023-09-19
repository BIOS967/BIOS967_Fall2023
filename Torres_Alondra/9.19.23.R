#September 19,2023
#data
# mapping aesthetics- how the variables are related to the other
#Geom- type of geometric object
#scaling- Set of values the variables will take.
#theme-
#pch=25 triangle
#pch=10 is a cruz
#pch=21 circles with transparent middle
#pch=19 circles with the same color inside as well


install.packages("ggplot2") #do this once to download package to your computer.

library(ggplot2)

plot(Sepal.Width~Sepal.Length,data=iris, xlab= "sepal length", ylab="sepal width", las=1, col=iris$Species,pch=19)

##ggplot way
p1=ggplot(data=iris,mapping =aes(x=Sepal.Length, y=Sepal.Width, color=Species))+
  geom_point(size=2, pch=19, alpha=0.5)+
  scale_fill_brewer(palette="Paired") +
  theme_bw()+
  theme(panel.grid.major =element_blank(),panel.grid.minor = element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")+
  facet_grid(~Species)
p1
#to safe the plots
ggsave("Torres_Alondra/ggplot_facet.pdf",p1)

