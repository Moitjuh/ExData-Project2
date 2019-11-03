setwd("D:/Annette/Desktop")

library(pacman)
p_load(dplyr)

emission <- readRDS("summarySCC_PM25.rds")
SCC_table <- readRDS("Source_Classification_Code.rds")

## Assignment: 
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

emission_total_baltimore <- emission %>% 
  ## select Baltimore City, Maryland  as described in the assignment
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarise(total_emission = sum(Emissions)) 


## Open PNG device, create plot2.png in my working directory
png("plot2.png")

## make base plot
plot(x = emission_total_baltimore$year,
     y = emission_total_baltimore$total_emission ,
     ## remove x labels as the ticks are in incovenient places
     xaxt="n",
     ## type is line with dots for the observations
     type = "o",
     ## change axis titles
     xlab = "Year",
     ylab = "PM2.5 Emission (tons)",
     main = "Baltimore City (Maryland) PM2.5 Emission over Time")
## create new axis ticks, with a tick mark for each year we have an observations
axis(side=1, 
     at=seq(1999,2008, by =3), 
     labels = FALSE)
## set the labels for the tick marks. 
text(x=seq(1999,2008, by =3),  par("usr")[3], 
     labels = seq(1999,2008, by =3), pos = 1, xpd = TRUE)

## Close PNG file device
dev.off()
