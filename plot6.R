setwd("D:/Annette/Desktop")

library(pacman)
p_load(dplyr, ggplot2)

emission <- readRDS("summarySCC_PM25.rds")
SCC_table <- readRDS("Source_Classification_Code.rds")%>% 
  mutate(SCC = as.character(SCC))

## Assignment: 
## Compare emissions from motor vehicle sources in Baltimore City with emissions from 
## motor vehicle sources in Los Angeles County, California (fips=="06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

emission_vehicles_LA_Balt <- emission %>% 
  ## select only observations from vehicles
  filter(type == "ON-ROAD" &
         ## select only observations Baltimore City, Maryland  and LA
         fips %in% c("24510", "06037") ) %>% 
  group_by(year,fips) %>% 
  summarise(total_emission = sum(Emissions)) %>% 
  ## change fips so that it contains the names rather than unrecognizable
  ## numbers 
  mutate(fips = case_when(
    fips == "24510" ~ "Baltimore City",
    TRUE ~ "Los Angeles County"
  ))


## Open PNG device, create plot6.png in my working directory
png("plot6.png")

ggplot(data = emission_vehicles_LA_Balt, aes(x = year, y = total_emission, col = fips)) +
  ## add the lines
  geom_line(size = 1.15) +
  ## add the dots for the observations
  geom_point(size = 2) +
  ## change title and axis titles
  labs(y = "PM2.5 Emission (Tons)", x = "Year",
       title = "Comparison of Total Vehicle Emissions in Baltimore and Los Angeles",
       col = "Location") +
  ## set the correct breaks (exactly on the observation)
  scale_x_continuous(breaks = c(1999, 2002, 2005,2008))+
  ## use white background
  theme_bw()

## Close PNG file device
dev.off()
