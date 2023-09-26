#September 19th, 2023

install.packages("ggplot2") #do this once to download package to your computer
library(ggplot2)

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, col=iris$Species, pch=19)

#ggplot way
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species,)) +
  geom_point(size=3, pch=19) +
  scale_color_manual(values=c("black", "red", "green")) +
  theme_bw() +
  theme(panel.grid.major=element_line("blue"), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")

#color palettes in ggplot
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species,)) +
  geom_point(size=3, pch=21) +
  scale_color_brewer(palette="Paired") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")

#facetting
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species,)) +
  geom_point(size=3, pch=21, alpha=0.5) +
  scale_color_brewer(palette="Paired") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)

ggsave("Foster_Lexie/ggplot_facet.png") #saving the plot into a folder on your desktop

