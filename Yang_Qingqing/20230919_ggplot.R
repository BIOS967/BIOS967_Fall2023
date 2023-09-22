#September 19, 2023

install.packages("ggplot2") #do this once to download package to the computer (and after updating R)
library(ggplot2)

#create a graph in base R that we will recreate using ggplot
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, col=iris$Species, pch=19)

#creating it in ggplot
ggplot(data=iris, mapping=aes(x=Sepal.Length,y=Sepal.Width, color=Species)) +
  geom_point(size=2, pch=19) +
  scale_color_manual(values=c("black","red","green")) +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")


#Color palettes in ggplot
ggplot(data=iris, mapping=aes(x=Sepal.Length,y=Sepal.Width, fill=Species)) +
  geom_point(size=5, pch=21) +
  scale_fill_brewer(palette="Set1") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)

ggsave("Yang_Qingqing/ggplot_facet.pdf")

#or
#best practice:
p1 <- ggplot(data=iris, mapping=aes(x=Sepal.Length,y=Sepal.Width, fill=Species)) +
  geom_point(size=5, pch=21, alpha=0.5) +
  scale_fill_brewer(palette="Set1") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none") +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)

p1
ggsave("Yang_Qingqing/ggplot_facet.pdf", p1)
