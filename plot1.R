# Plot1: Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, make a plot showing
# the total PM2.5 emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.

# read in the data frame objects if they exist in the working dir
if (file.exists("summarySCC_PM25.rds")) NEI <- readRDS("summarySCC_PM25.rds")

# sum  PM2.5 emissions for each year
x <- tapply(NEI$Emissions,NEI$year,sum)

# create plots and send to png device (use default width/height of 480x480)
png(filename="plot1.png")
plot(names(x),x,main="Total US PM2.5 Emmissions",xlab="Year",ylab="Emmissions")
dev.off()
