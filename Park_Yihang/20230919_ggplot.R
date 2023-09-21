#September 19, 2023
install.packages("ggplot2")
#if you update R, you have to install packages again

library(ggplot2)

#basicR way
plot(Sepal.Width~Sepal.Length, data=iris, xlab="Sepal length", ylab="Sepal Width", las=1, col=iris$Species, pch=19) #las makes the values on y axis horizontal not vertical


#ggplot way
#unlike basic R, we can put variable names without any quotes
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species))

# line 13 shows nothing, you have to specify geom Using + 

ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + geom_point(size=2, pch=19) +
#pch 19 is color withoutoutline, and 21 is color filled with outer line
scale_color_manual(values=c("black", "red", "green"))+
theme_bw() +
theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none")+
  xlab("Sepal Length") +
  ylab("Sepal Width")

#color palettes in ggplot: rerun the above codes without scale_color_manual

ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + geom_point(size=2, pch=21) +
  scale_color_brewer(palette="RdYlBu")+ #you can search on it color brewer
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none")+
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)
      
#facetting
ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + geom_point(size=2, shape="circle filled", alpha) +
  scale_color_brewer(palette="RdYlBu")+ #you can search on it color brewer
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(), legend.position="none")+
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  facet_grid(~Species)

#save the plot
ggsave("figures/ggplot_factor.pdf", p1)
