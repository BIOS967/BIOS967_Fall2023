# 09/19/2023  ____ggplot2_____

install.packages("ggplot2")
library(ggplot2)

## BASE "R" example (uses "quotes"):
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal Length", ylab="Sepal Width", las=1, col=iris$Species, pch=19)

## ggplot example (doesn't use quotes, needs "+" between elements you add, has formatting defaults):
ggplot(data=iris, mapping = aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point(size=2, pch=19) +  #to change colors from default to those in the Base-R plot
  scale_color_manual(values = c("black", "red", "green")) +
  theme_bw() +  #to remove defaults inside grid, and make blank, and remove legend
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = "none") +
  xlab("Sepal Length") +
  ylab("Sepal Width")

#___________________________________________________________________________
  ## COLOR PALETTES in ggplot
ggplot(data=iris, mapping = aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + #fill by species
  geom_point(size=2, shape="circle filled", alpha=0.5) +  #pch=21 makes it filled, with an outline
  scale_fill_brewer(palette = "RdYlBu") + #google color_brewer for cartographer palettes and color numbers!
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = "none") +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)  #plot subsets of data separately (i.e. diff plots for ea spp)

## another way to SAVE the LAST PLOT you made
ggsave("Brierly_Angela/ggplot_facet.png")




