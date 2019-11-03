setwd("D:/Annette/Desktop")

library(pacman)
p_load(dplyr, ggplot2)

emission <- readRDS("summarySCC_PM25.rds")
SCC_table <- readRDS("Source_Classification_Code.rds")%>% 
  mutate(SCC = as.character(SCC))

## Assignment: 
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

emission_coal <- emission %>% 
  ## add PM2.5 source (found in the SCC table)
  left_join(SCC_table, by = "SCC") %>% 
  ## only keep observations of which the source is coal
  filter(grepl("coal",Short.Name, ignore.case = TRUE)) %>% 
  group_by(year) %>% 
  summarise(total_emission = sum(Emissions)) %>% 
  ## by deviding the total emissions variable by 1000 the plot will
  ## be more readable as it will not have a scientific notation
  mutate(total_emission = total_emission / 1000)

## Open PNG device, create plot4.png in my working directory
png("plot4.png")

ggplot(data = emission_coal, aes(x = year, y = total_emission)) +
  ## add the lines
  geom_line(size = 1.15) +
  ## add the dots for the observations
  geom_point(size = 2) +
  ## change title and axis titles
  labs(y = "PM2.5 Emission (Kilotons)", x = "Year",
       title = "Total Emissions from Coal Sources over time") +
  ## rescale the y-axis, ggplot automatically uses 350 and 615 as begin and end
  ## by doing so the drop between 2005 to 2008 "appears" to be optically larger
  ## than it actually is
  ylim(0, 615) +
  ## set the correct breaks (exactly on the observation)
  scale_x_continuous(breaks = c(1999, 2002, 2005,2008))+
  ## use white background
  theme_bw()


## Close PNG file device
dev.off()
