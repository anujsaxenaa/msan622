library(ggplot2)
library(maps)
library(stringr)
library(gridExtra)
#setwd("/MSAN/MSANSpring/MSAN622/DataViz/project2")
met <- read.csv("meteorites.csv")
met$Country <- map.where(database="world",met$reclong,met$reclat)
# met2 <- na.omit(met)
# met2$Country <- str_extract(met2$Country,"[A-z]+")
rems <- which(grepl(":",met$Country))
met3 <- met[-rems,]
#met3 <- na.omit(met3)
met3$Country[which(met3$Country=="USA")] <- "United States"
met3$Country[which(met3$Country=="USSR")] <- "Russian Federation"
#cont <- read.csv("continents.csv")
d <- merge(met3,cont,by="Country")
world <- map_data("world")
# localFrame <- met
# 1600 1959 1977 1979 1980
# 1981 1985 1987 1988 1989
# 1990 1991 1993 1996 1997
# 1998 1999 2000 2002 2003
# 2004 2006 2008 2010 2013

timemapmain <- function(start_year,
                    localFrame) {
  big_dataset <- localFrame
  theme_opts <- list(theme(panel.grid.minor = element_blank(),
                           panel.grid.major = element_blank(),
                           panel.background = element_blank(),
                           plot.background = element_rect(fill="gray60"),
                           panel.border = element_blank(),
                           axis.line = element_blank(),
                           axis.text.x = element_blank(),
                           axis.text.y = element_blank(),
                           axis.ticks = element_blank(),
                           axis.title.x = element_blank(),
                           axis.title.y = element_blank(),
                           plot.title = element_text(size=22)))
  #ranges <- seq(year_range[1],year_range[2],1)
  localFrame2 <- localFrame
  #if (start_year==1600) {
  #  localFrame <- subset(localFrame2, localFrame2$year %in% ranges)
  #} else {
  localFrame <- subset(localFrame2, localFrame2$year <= start_year) 
  #}
  #world <- map_data("world")
  
 p <- ggplot(world, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="gray20") +
  geom_point(data=localFrame,aes(x=reclong,y=reclat,
                          color=fall,size=mass,group=NULL),alpha=I(1/6)) +
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
   #scale_size(range = c(min(big_dataset$mass)*200,max(big_dataset$mass)*2.166667e-07)) +
  scale_size(range = c(2, 13)) +
  scale_color_manual(values=c("#f03b20","#feb24c")) + 
  labs(color="Meteor Kind") #+ coord_fixed(ratio=0.85)
#   if (which_orientation=="def") {
 p <- p + coord_fixed(ratio=0.85)
#   } else if (which_orientation=="A") {
#     p <- p + coord_map("ortho", orientation=c(50, 80, 0))
#   } else if (which_orientation=="EA") {
#     p <- p + coord_map("ortho", orientation=c(30, 30, 0))
#   } else if (which_orientation=="AN") {
#     p <- p + coord_map("ortho", orientation=c(50, -80, 0))
#   } else if (which_orientation=="AC") {
#     p <- p + coord_map("ortho", orientation=c(-50, -160, 0))
#   }
 return(p)
}

orthomap <- function(start_year,year_range,which_orientation,
                        localFrame) {
  big_dataset <- localFrame
  theme_opts <- list(theme(panel.grid.minor = element_blank(),
                           panel.grid.major = element_blank(),
                           panel.background = element_blank(),
                           plot.background = element_rect(fill="gray60"),
                           panel.border = element_blank(),
                           axis.line = element_blank(),
                           axis.text.x = element_blank(),
                           axis.text.y = element_blank(),
                           axis.ticks = element_blank(),
                           axis.title.x = element_blank(),
                           axis.title.y = element_blank(),
                           plot.title = element_text(size=22)))
  ranges <- seq(year_range[1],year_range[2],1)
  localFrame2 <- localFrame
#   if (start_year==1600) {
  localFrame <- subset(localFrame2, localFrame2$year %in% ranges)
#   } else {
#     localFrame <- subset(localFrame2, localFrame2$year <= start_year) 
#   }
  #world <- map_data("world")
  
  p <- ggplot(world, aes(x=long, y=lat, group=group)) +
    geom_polygon(fill="gray20") +
    geom_point(data=localFrame,aes(x=reclong,y=reclat,
                                   color=fall,size=mass,group=NULL),alpha=I(1/6)) +
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
    #scale_size(range = c(min(big_dataset$mass)*200,max(big_dataset$mass)*2.166667e-07)) +
    scale_size(range = c(2, 13)) +
    scale_color_manual(values=c("#f03b20","#feb24c")) + 
    labs(color="Meteor Kind") #+ coord_fixed(ratio=0.85)
  if (which_orientation=="A") {
    p <- p + coord_map("ortho", orientation=c(50, 80, 0))
  } else if (which_orientation=="EA") {
    p <- p + coord_map("ortho", orientation=c(30, 30, 0))
  } else if (which_orientation=="AN") {
    p <- p + coord_map("ortho", orientation=c(50, -80, 0))
  } else if (which_orientation=="AC") {
    p <- p + coord_map("ortho", orientation=c(-50, -160, 0))
  }
  return(p)
}

movingHist <- function(localFrame,minmax) {
  theme_opts <- list(theme(panel.grid.minor = element_blank(),
                          panel.grid.major.y = element_line(color="gray50",linetype="dashed"),
                          panel.grid.major.x = element_line(color="gray50",linetype="dashed"),
                          panel.background = element_blank(),
                          plot.background = element_rect(fill=NA),
                          panel.border = element_blank(),
                          axis.line = element_blank(),
                          #axis.text.x = element_blank(),
                          #axis.text.y = element_blank(),
                          axis.ticks = element_blank(),
                          axis.title.x = element_blank(),
                          axis.title.y = element_blank(),
                          plot.title = element_text(size=22)))
  minyr <- minmax[1]
  maxyr <- minmax[2]
  top <- ggplot(subset(localFrame,localFrame$fall=="Fell"),
                aes(x=year))+geom_bar(bin=1,fill="#f03b20")+scale_y_reverse() +
    annotate("rect", xmin=minyr,xmax=maxyr,ymin=0,ymax=Inf, alpha=0.2, fill="deepskyblue") +
    annotate("text", label = "Fell", x = 1650, y = 13.5, size = 5, colour = "#f03b20",fontface=3) +
    #annotate("text","Hi") +
    theme_opts
  bottom <- ggplot(subset(localFrame,localFrame$fall=="Found"),
                   aes(x=year))+geom_bar(bin=1,fill="#feb24c")+scale_y_sqrt() +
    annotate("rect", xmin=minyr,xmax=maxyr,ymin=0,ymax=Inf, alpha=0.2, fill="deepskyblue") +
    annotate("text", label = "Found", x = 1650, y = 650, size = 5, colour = "#feb24c",fontface=3) +
    theme_opts
  comb <- grid.arrange(top,bottom,nrow=2)
  return(comb)
}

sub_cont <- function(localFrame,which_country) {
  theme_opts <- list(theme(panel.grid.minor = element_blank(),
                           panel.grid.major.y = element_line(color="gray50",linetype="dashed"),
                           panel.grid.major.x = element_line(color="gray50",linetype="dashed"),
                           panel.background = element_blank(),
                           plot.background = element_rect(fill=NA),
                           panel.border = element_blank(),
                           axis.line = element_blank(),
                           axis.text.x = element_blank(),
                           axis.text.y = element_blank(),
                           axis.ticks = element_blank(),
                           axis.title.x = element_blank(),
                           axis.title.y = element_blank(),
                           plot.title = element_text(size=22)))
  world <- map_data("world")
  localFrame <- subset(localFrame,localFrame$Country==which_country)
  cont <- subset(world,world$region==which_country)
  p <- ggplot(cont, aes(x=long, y=lat, group=group)) +
    geom_polygon(fill="gray20") +
    geom_point(data=localFrame,aes(x=reclong,y=reclat,
                                   color=fall,size=mass,group=NULL),alpha=I(1/6)) +
    guides(size = FALSE) +
    theme_opts +
    theme(legend.justification=c(0,0),
          legend.position=c(0,0),
          legend.direction="vertical") + 
    theme(legend.background=element_rect(fill=NA,color=NA)) +
    guides(colour = guide_legend(override.aes = list(size=5))) +
    theme(legend.key = element_rect(fill=NA,color=NA)) +
    theme(legend.text = element_text(color="gray80"),
          legend.title = element_text(color = "gray80")) +
    #scale_size(range = c(min(big_dataset$mass)*200,max(big_dataset$mass)*2.166667e-07)) +
    scale_size(range = c(2, 13)) +
    scale_color_manual(values=c("#f03b20","#feb24c"))
  return(p)
}

met_bar <- function(localFrame,which_country) {
  theme_opts <- list(theme(panel.grid.minor = element_blank(),
                           panel.grid.major.y = element_line(color="gray50",linetype="dashed"),
                           panel.grid.major.x = element_line(color="gray50",linetype="dashed"),
                           panel.background = element_blank(),
                           plot.background = element_rect(fill=NA),
                           panel.border = element_blank(),
                           #axis.line = element_blank(),
                           #axis.text.x = element_blank(),
                           #axis.text.y = element_blank(),
                           #axis.ticks = element_blank(),
                           #axis.title.x = element_blank(),
                           #axis.title.y = element_blank(),
                           plot.title = element_text(size=22)))
  big_dataset <- localFrame
  localFrame2 <- subset(localFrame,localFrame$Country==which_country)
  localFrame2 <- localFrame2[order(localFrame2$mass,decreasing=T),]
  bar_df <- head(localFrame2)[c(1,4)]
#   bar_df$name <- factor(bar_df$name, 
#                         levels = bar_df$name, 
#                         ordered = TRUE)
  p <- ggplot(bar_df,aes(x=factor(name),y=mass))+geom_bar(stat='identity')+coord_flip()+
    labs(x="Meteorite names",y="Mass (in metric tons)",
         title=paste("Biggest Meteorites in",which_country)) +
    theme_opts + 
    theme(axis.text.x = element_text(size = 10,
                                     color="gray85",face="bold.italic")) +
    theme(axis.text.y = element_text(size = 12,
                                     color="gray85",face="italic"))+
    theme(axis.title = element_text(size = 13,
                                    color="gray85",face="bold")) +
    theme(title=element_text(size=17,color="gray85",face="bold"))
  return(p)
}

# create_table <- function(localFrame,which_country) {
#   tab <- subset(localFrame,localFrame$Country==which_country)
#   tab <- tab[order(tab$mass,decreasing=T),]
#   tab <- tab[c(1:6)]
#   return(tab)
# }
#"en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8"
# fill_cont <- function(localFrame,which_country) {
#   theme_opts <- list(theme(panel.grid.minor = element_blank(),
#                            panel.grid.major = element_blank(),
#                            panel.background = element_blank(),
#                            plot.background = element_rect(fill="gray60"),
#                            panel.border = element_blank(),
#                            axis.line = element_blank(),
#                            axis.text.x = element_blank(),
#                            axis.text.y = element_blank(),
#                            axis.ticks = element_blank(),
#                            axis.title.x = element_blank(),
#                            axis.title.y = element_blank(),
#                            plot.title = element_text(size=22)))
#   #localFrame <- subset(localFrame,localFrame$Country==which_country)
#   #cont <- subset(world,world$region==which_country)
#   p <- ggplot(world, aes(x=long, y=lat, group=group)) + geom_path() + 
#     geom_polygon(fill="gray20") + theme_opts
#   if (world$region==which_country) {
#   p <- p + scale_color_manual(fill="red")
#   }
#   return(p)
# }













# ggplot(subset(met,met$fall=="Fell"),
#        aes(x=year))+geom_bar(bin=1)+
#   scale_y_sqrt()+scale_y_reverse()+
#   annotate("rect", xmin=1600,xmax=1610,ymin=0,ymax=Inf, alpha=0.2, fill="deepskyblue") 
#   

#   if (which_orientation=="AN") {
#     p <- p + coord_map("ortho", orientation=c(50, -80, 0))
#   } else if (which_orientation=="EA") {
#     p <- p + coord_map("ortho", orientation=c(30, 30, 0))
#   } else if (which_orientation=="A") {
#     p <- p + coord_map("ortho", orientation=c(50, 80, 0))
#   } else if (which_orientation=="LA") {
#     p <- p + coord_map("ortho", orientation=c(-20, -80, 0))
#   } else if (which_orientation=="AC"){
#     p <- p + coord_map("ortho", orientation=c(-50, -160, 0))
#   } else {
    #p <- p + coord_equal()
#   }

# } else {
#   
#   world <- map_data("world")
#   if (which_country %in% unique(localFrame$Country)) {
#     localFrame <- subset(localFrame, localFrame$Country==which_country)
#     world <- subset(world, world$region==which_country)
#   } else {
#   localFrame <- localFrame
#   }
# #   world <- map_data("world")
# #   world <- subset(world, world$region==which_country)
#   
#   p <- ggplot(world, aes(x=long, y=lat, group=group)) +
#     geom_polygon(fill="gray40") +
#     geom_point(data=localFrame,aes(x=reclong,y=reclat,
#                                    color=fall,size=mass,group=NULL),alpha=I(1/2)) +
#     #geom_text(data=localFrame,aes(label=Countr)) +
#     guides(size = FALSE) +
#     theme_opts + 
#     theme(legend.justification=c(0,0),
#           legend.position=c(0,0),
#           legend.direction="vertical") + 
#     theme(legend.background=element_rect(fill=NA,color=NA)) +
#     guides(colour = guide_legend(override.aes = list(size=5))) +
#     theme(legend.key = element_rect(fill=NA,color=NA)) +
#     theme(legend.text = element_text(color="gray80"),
#           legend.title = element_text(color = "gray80")) +
#     scale_size(range = c(3.5, 13)) +
#     scale_color_manual(values=c("#feb24c","deepskyblue2")) + 
#     labs(color="Meteor Kind") +
#     coord_equal() #+ coord_map("ortho", orientation=c(30, 30, 0))
# }


#####
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


# x <- c(rep(1,3),rep(2,8),rep(3,15),rep(4,23),rep(5,35),rep(6,40),rep(7,32),rep(8,28),
#        rep(9,20),rep(10,45),rep(11,14),rep(12,6))
# 
# 
# x1 <- c(2.35, -5.02, -8.71, -3.73, -4.05, -4.00)
# ((2*pi)^-0.5)*(3.11^-1)*exp(-0.5*(2.69/3.11)^2)
# x2 <- c(5.15, 3.82, 2.12)
