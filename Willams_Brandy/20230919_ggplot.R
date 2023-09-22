install.packages("ggplot2")
library(ggplot2)

#Base "R" example (uses "quotes")
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, col=iris$Species, pch=19)

#ggplot example (doesn't use quotes, needs "+" between elements you add, has formatting defaults):
#define data and aesthetics
ggplot(data=iris, mapping=aes(x=Sepal.Length,y=Sepal.Width))
#add scatter plot and change point size
ggplot(data=iris, mapping=aes(x=Sepal.Length,y=Sepal.Width))+geom_point(size=2)
#color the points and define color scaling
ggplot(data=iris, mapping=aes(x=Sepal.Length,y=Sepal.Width, color=Species))+geom_point(size=2)+scale_color_discrete(type=rainbow(3))
#set up a simple theme & remove grid lines
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2) +
  scale_color_discrete(type=rainbow(3)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
#edit x & Y lables
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2) +
  scale_color_discrete(type=rainbow(3)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  xlab("Sepal Length") +
  ylab("Sepal Width")
#remove legend
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2) +
  scale_color_discrete(type=rainbow(3)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = "none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")


## COLOR PALETTES in ggplot
ggplot(data=iris, mapping = aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + #fill by species
  geom_point(size=2, shape="circle filled", alpha=0.5) +  #pch=21 makes it filled, with an outline
  scale_fill_brewer(palette = "RdYlBu") + #google color_brewer for cartographer palettes and color numbers!
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = "none") +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)  #plot subsets of data separately (i.e. diff plots for ea spp)

#Saving plots
ggsave("ggplot_1.png")

