#September 19, 2023

install.packages("ggplot2") #do this once to download package to your computer.
library(ggplot2)

plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, col=iris$Species, pch=19)

##ggplot way
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2, pch=19) +
  scale_color_manual(values=c("black", "red", "green")) +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")

#color palettes in ggplot
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=2, pch=21) +
  scale_fill_brewer(palette="Paired") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")

#color palettes in ggplot
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=2, pch=21) +
  scale_fill_brewer(palette="Paired") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")

#facetting
p1=ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) +
  geom_point(size=2, shape="circle filled", alpha=0.5) +
  scale_fill_brewer(palette="Paired") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)

p1

#save the ggplot figure using ggsave()
ggsave("figures/ggplot_facet.pdf", p1)
