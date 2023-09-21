#September 19, 2023

#first we have to install and load ggplot2 package

#install.packages("ggplot2") #do this once to download package to computer

library(ggplot2)

#####  BASE R  ####

#plot(Sepal.Width~Sepal.Length, data=iris)
plot(Sepal.Width~Sepal.Length, data=iris, xlab = "Sepal Length", ylab = "Sepal Width", las=1, col=iris$Species, pch = 19)

#las=1 changes the y axis number orientation
#pch = 19 point type, #pch = "x" will make them all x's

#####  GGPLOT ####

#ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  #geom_point(size=2, pch=21)

#pch = 19 is a filled circle, color defined by color=
#pch = 21 is a circled outline, fill is the color on the inside

ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2, pch=19) +
  scale_color_manual(values=c("black", "red", "green")) +
  theme_bw() + #_bw, classic, _minimal, etc, look it up!
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Length")

ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2, pch=19) +
  scale_color_brewer(palette="Accent") +
  theme_bw() + #_bw, classic, _minimal, etc, look it up!
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Length")

#with outline, fill color being the palate
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=2, pch=21) +
  scale_fill_brewer(palette="Accent") +
  theme_bw() + #_bw, classic, _minimal, etc, look it up!
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Length")

# if you don't want to create a new color pallet all on your own,
#scale_color_brewer()

#faceting

p1 = ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=2, shape = "circle filled", alpha=0.5) +
  scale_fill_brewer(palette="Accent") +
  theme_bw() + #_bw, classic, _minimal, etc, look it up!
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Length") +
  facet_grid(~Species)

p1

#save the ggplot,
#ggsave("figures/ggplot_facet.png", p1)


