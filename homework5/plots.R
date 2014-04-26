data(Seatbelts)
times <- time(Seatbelts)
years <- floor(times)
years <- factor(years, ordered = TRUE)
months <- factor(
  month.abb[cycle(times)],
  levels = month.abb,
  ordered = TRUE
)

# Stacked Area
sb <- data.frame(
      year = years,
      month = months,
      time = as.numeric(times),
      Seatbelts
      )
sb$law <- as.factor(sb$law)
sb3 <- sb
sb3$DriversKilled <- sb$DriversKilled/sd(sb$DriversKilled)
sb3$drivers <- sb$drivers/sd(sb$drivers)
year <- rep(sb$year,2)
month <- rep(sb$month,2)
act_time <- rep(sb$time,2)
condition <- c(sb3$DriversKilled,sb3$drivers)
condition_label <- rep(c("Killed","Injured"),each=nrow(sb))
law <- rep(sb$law,2)

sb2 <- data.frame(year,month,act_time,condition,condition_label,law)
colnames(sb2)[5]<-"Accident_Result"

ggplot(data=sb2) + 
  geom_area(data=sb2,aes(x=act_time,y=condition,
                fill=Accident_Result),
                postion="stack",alpha=I(1/2)) +
  annotate("rect", xmin=1983.083,xmax=Inf,ymin=0,ymax=Inf, alpha=0.2, fill="deepskyblue") +
  scale_x_continuous(expand=c(0,0),
                     breaks=c(1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,
                              1980,1981,1982,1983,1984)) +
  scale_y_continuous(expand=c(0,0)) +
  theme(panel.background=element_blank()) +
  theme(panel.grid.major.x=element_line(color="gray90")) +
  theme(panel.grid.major.y=element_line(color="gray90")) + 
  labs(title="Killed Vs Injured Drivers Proportion Comparison",
       x="Year",
       y="Killed/Injured Scaled Proportion") +
  theme(axis.text.x = element_text(size = 12,
                                   color="black")) +
  theme(axis.text.y = element_text(size = 12,
                                   color="black")) +
  annotate("text", label = "31st Jan, \n Seatbelt law \n was passed",
           x = 1982.5, y = 15, size = 5, colour = "black")
  
# Heatmaps
f <-ggplot(sb,aes(year,month))+
  geom_tile(aes(fill=front))+
  theme(panel.background=element_blank()) +
  theme(axis.text.x = element_text(size = 10,
                                   color="black",face="bold.italic")) +
  theme(axis.text.y = element_text(size = 12,
                                   color="black",face="italic")) + 
  theme(axis.ticks.x=element_line(size=0)) +
  theme(axis.ticks.y=element_line(size=0)) + 
  labs(title="Front Seat Deaths",y="Month",x="Year",fill="Front Seat Deaths")

r <-ggplot(sb,aes(year,month))+
  geom_tile(aes(fill=rear))+
  theme(panel.background=element_blank()) +
  theme(axis.text.x = element_text(size = 10,
                                   color="black",face="bold.italic")) +
  theme(axis.text.y = element_text(size = 12,
                                   color="black",face="italic")) + 
  theme(axis.ticks.x=element_line(size=0)) +
  theme(axis.ticks.y=element_line(size=0)) + 
  labs(title="Rear Seat Deaths",y="Month",x="Year",fill="Rear Seat Deaths")
grid.arrange(f,r,ncol=2)


# Polar coordinates plot
ggplot(sb,aes(x=year,y=month)) +   
  geom_tile(aes(fill=PetrolPrice)) +
  coord_polar() +
  theme(panel.background=element_blank()) +
  scale_fill_continuous(low="gray100",high="gray0",name="Monthly Petrol Prices") +
  theme(axis.text.x = element_text(size = 12,
                                   color="black",face="bold.italic")) +
  theme(axis.text.y = element_text(size = 12,
                                   color="black",face="italic")) +
  labs(y="Months",x="Years",title="Monthly Petrol Prices 1969-1984")
