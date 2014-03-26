#setwd("/MSAN/MSANSpring/MSAN622/DataViz")
library(ggplot2)
data(movies)
data(EuStockMarkets)

genre <- rep(NA, nrow(movies))
count <- rowSums(movies[,18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"

movies$genre <- genre
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))

#1

(sc_plot <- ggplot(movies, aes(x=budget, y=rating))+
   geom_point(color="orange4")+xlab("Movie Budget ($)")+
   ylab("IMDB Movie Rating")+
   ggtitle("Relationship between Movie Budget & Rating")+
   theme(panel.background = element_rect(fill='oldlace',color="white"))
 )

ggsave("hw1-scatter.png", dpi = 300, width = 10, height = 7)

#2

(bar_graph <- ggplot(movies, aes(x=genre,fill=genre))+
  geom_bar()+ggtitle("Movie Votes by Genre")+
   xlab("Movie Genres")+
   ylab("Votes")+
   theme(panel.background = element_rect(fill='snow2',color="white"))
)

ggsave("hw1-bar.png", dpi = 300, width = 10, height = 8)

#3

(facet_plot <- ggplot(movies,aes(x=budget,y=rating,color=genre))+
  geom_point()+
  facet_wrap(~genre)+
   xlab("Movie Budget ($)")+
   ylab("IMDB Movie Rating")+
   ggtitle("Relationship between Movie Budget & Rating by Genre")+
   theme(legend.position="none")
)

ggsave("hw1-multiples.png", dpi = 300, width = 10, height = 8)

#4

(mult_line <- ggplot(eu, aes(x=time, y=DAX))+
  geom_line(aes(x=time,y=DAX,color="DAX"))+
  geom_line(aes(x=time,y=SMI,color="SMI"))+
  geom_line(aes(x=time,y=CAC,color="CAC"))+
  geom_line(aes(x=time,y=FTSE,color="FTSE"))+
  labs(color="Index")+
  ylab("Daily Closing Price")+
  xlab("Year")+
  ggtitle("Daily Closing Prices (1991-1998)")
)

ggsave("hw1-multiline.png", dpi = 300, width = 10, height = 8)
