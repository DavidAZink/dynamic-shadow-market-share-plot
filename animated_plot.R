#Call in data
data1=readRDS('census-app/data/data1.rds')
#I'll create the dynamic plot with gganimate and plotly
library(gganimate)
library(scales)
data1$Year=as.numeric(as.character(data1$Year))

#create the ggplot
plot=ggplot() +
  geom_polygon(data=data1, 
               aes(long, lat, group=group, fill=data1[, 'shadow_share']), size=0.0001, 
               colour = alpha("black", 0.001))+
  geom_polygon(data=map_data('state'), aes(long, lat, group=group), fill=NA, colour='black') +
  scale_fill_gradient2(low=muted('red'), high=muted('green'), mid='white', midpoint=0.5,
                       space='Lab', guide='colourbar', breaks=seq(0, 1, 0.20), labels=scales::percent) + 
  coord_fixed(ratio=1.3) +
  labs(fill='', title=paste('Shadow Bank Market Share ', '{current_frame}'))+
  theme(legend.position="bottom",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(), 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),  
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(), 
        plot.title = element_text(hjust = 0.5, size=12, face='bold'), legend.key.width = unit(3, "cm")) +
  #tell the plot the transition based on YEAR
  transition_manual(Year)

#animate the plot and save as .gif file
animate(plot, renderer=gifski_renderer('share_dynamic2.gif'), duration=20)


