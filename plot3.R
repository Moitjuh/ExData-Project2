setwd("D:/Annette/Desktop")

library(pacman)
p_load(dplyr, ggplot2)

emission <- readRDS("summarySCC_PM25.rds")
SCC_table <- readRDS("Source_Classification_Code.rds")

## Assignment: 
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

emission_total_baltimore <- emission %>% 
  ## select Baltimore City, Maryland  as described in the assignment (point 2)
  filter(fips == "24510") %>% 
  group_by(year, type) %>% 
  summarise(total_emission = sum(Emissions))

## Open PNG device, create plot3.png in my working directory
png("plot3.png")

ggplot(data = emission_total_baltimore, aes(x = year, y = total_emission, color = type)) +
  ## add the lines
  geom_line(size = 1.15) +
  ## add the dots for the observations
  geom_point(size = 2) +
  ## change title and axis titles
  labs(y = "PM2.5 Emission (tons)", x = "Year",
       title = "PM2.5 Emissions in Baltimore City over time by Various Sources")+
  ## set the correct breaks (exactly on the observation)
  scale_x_continuous(breaks = c(1999, 2002, 2005,2008))+
  ## use white background
  theme_bw()


## Close PNG file device
dev.off()
