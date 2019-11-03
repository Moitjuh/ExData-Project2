setwd("D:/Annette/Desktop")

library(pacman)
p_load(dplyr, ggplot2)

emission <- readRDS("summarySCC_PM25.rds")
SCC_table <- readRDS("Source_Classification_Code.rds")%>% 
  mutate(SCC = as.character(SCC))

## Assignment: 
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

emission_vehicles <- emission %>% 
  ## select only observations from vehicles
  filter( type == "ON-ROAD" &
         ## select only observations Baltimore City, Maryland 
         fips == "24510") %>% 
  group_by(year) %>% 
  summarise(total_emission = sum(Emissions)) 

## Open PNG device, create plot5.png in my working directory
png("plot5.png")

ggplot(data = emission_vehicles, aes(x = year, y = total_emission)) +
  ## add the lines
  geom_line(size = 1.15) +
  ## add the dots for the observations
  geom_point(size = 2) +
  ## change title and axis titles
  labs(y = "PM2.5 Emission (Tons)", x = "Year",
       title = "Baltimore City Total Emissions from Motor Vehicle Sources over time") +
  ## rescale the y-axis, ggplot automatically uses 350 and 615 as begin and end
  ## by doing so the drop "appears" to be optically larger than it actually is
  ylim(0, 355) +
  ## set the correct breaks (exactly on the observation)
  scale_x_continuous(breaks = c(1999, 2002, 2005,2008))+
  ## use white background
  theme_bw()


## Close PNG file device
dev.off()
