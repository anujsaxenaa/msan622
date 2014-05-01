library(ggplot2)
library(maps)
setwd("/MSAN/MSANSpring/MSAN622/DataViz/project")
met <- read.csv("meteorites.csv")
met$Country <- map.where(database="world",met$reclong,met$reclat)
timemap <- function(start_year,localFrame) {
 #localFrame <- subset(localFrame, localFrame$year <= start_year) 
 world <- map_data("world")
 theme_opts <- list(theme(panel.grid.minor = element_blank(),
                          panel.grid.major = element_blank(),
                          panel.background = element_blank(),
                          plot.background = element_rect(fill="gray20"),
                          panel.border = element_blank(),
                          axis.line = element_blank(),
                          axis.text.x = element_blank(),
                          axis.text.y = element_blank(),
                          axis.ticks = element_blank(),
                          axis.title.x = element_blank(),
                          axis.title.y = element_blank(),
                          plot.title = element_text(size=22))) 
 p <- ggplot(world, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="gray40") +
  geom_point(data=localFrame,aes(x=reclong,y=reclat,
                          color=fall,size=mass,group=NULL),alpha=I(1/4)) +
  guides(size = FALSE) +
  geom_hline(yintercept=0,linetype="dashed",color="gray50") +
  theme_opts +
  theme(legend.justification=c(0,0),
        legend.position=c(0,0),
        legend.direction="vertical") + 
  theme(legend.background=element_rect(fill=NA,color=NA)) +
  guides(colour = guide_legend(override.aes = list(size=5))) +
  theme(legend.key = element_rect(fill=NA,color=NA)) +
  theme(legend.text = element_text(color="gray80"),
        legend.title = element_text(color = "gray80")) +
  scale_size(range = c(1.4, 13)) +
  scale_color_manual(values=c("#f03b20","#feb24c")) + 
  labs(color="Meteor Kind")# +
  #coord_map("ortho", orientation=c(30, 30, 0)) 
  #coord_equal()
 return(p)
}


# theme_opts <- list(theme(panel.grid.minor = element_blank(),
#                          panel.grid.major = element_blank(),
#                          panel.background = element_blank(),
#                          plot.background = element_rect(fill=NA),
#                          panel.border = element_blank(),
#                          axis.line = element_blank(),
#                          axis.text.x = element_blank(),
#                          axis.text.y = element_blank(),
#                          axis.ticks = element_blank(),
#                          axis.title.x = element_blank(),
#                          axis.title.y = element_blank(),
#                          plot.title = element_text(size=22)))
# world <- map_data("world")
# ggplot(world, aes(x=long, y=lat, group=group)) +
#   geom_polygon() +
#   geom_point(data=met,aes(x=reclong,y=reclat,
#                           color=fall,size=mass,group=NULL),alpha=I(1/4)) +
#   guides(size = FALSE) +
#   geom_hline(yintercept=0,linetype="dashed",color="gray50") +
#   theme_opts +
#   theme(legend.justification=c(0,0),
#         legend.position=c(0,0.5),
#         legend.direction="vertical") + 
#   guides(colour = guide_legend(override.aes = list(size=10))) +
#   theme(legend.key = element_rect(fill="white")) +
#   scale_size(range = c(1.7, 11))
  #theme(legend.key = element_rect(colour = 'purple', fill = NA, size = 2, linetype='dashed'))
  #scale_size(range = c(2, 15))
  


## using rdgal shapefiles
#wmap <- readOGR(dsn="ne_110m_land", layer="ne_110m_land")
#wmap_df <- fortify(wmap)