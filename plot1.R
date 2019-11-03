setwd("D:/Annette/Desktop")

library(pacman)
p_load(dplyr)

emission <- readRDS("summarySCC_PM25.rds")
SCC_table <- readRDS("Source_Classification_Code.rds")

## Excersice: 
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

emission_total <- emission %>% 
  group_by(year) %>% 
  summarise(total_emission = sum(Emissions)) %>% 
  ## by deviding the total emissions variable by 1000 the plot will
      ## be more readable as it will not have a scientific notation
  mutate(total_emission = total_emission / 1000)


## Open PNG device, create plot1.png in my working directory
png("plot1.png")

## make base plot
plot(x = emission_total$year,
     y = emission_total$total_emission ,
     ## remove x labels as the ticks are in incovenient places
     xaxt="n",
     ## type is line with dots for the observations
     type = "o",
     ## change axis titles
     xlab = "Year",
     ylab = "PM2.5 Emission (kilotons)",
     main = "US Annual PM2.5 Emission over Time")
## create new axis ticks, with a tick mark for each year we have an observations
axis(side=1, 
     at=seq(1999,2008, by =3), 
     labels = FALSE)
## set the labels for the tick marks. 
text(x=seq(1999,2008, by =3),  par("usr")[3], 
     labels = seq(1999,2008, by =3), pos = 1, xpd = TRUE)

## Close PNG file device
dev.off()
