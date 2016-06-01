# Plot3: Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources
# have seen decreases in emmissions from 1999-2008? Use the ggplot2 plotting 
# system to make a plot to answer this question.

library(ggplot2)
library(reshape2)

# read in the data frame objects if they exist in the working dir
if (file.exists("summarySCC_PM25.rds")) NEI <- readRDS("summarySCC_PM25.rds")

# filter out the Baltimore records
NEI <- NEI[NEI$fips == "24510",]

# sum PM2.5 emmissions by year and type and put in new dataframe
sources <- tapply(NEI$Emissions,list(NEI$year,NEI$type),sum)

# melt and rename the columns for better plotting in ggplot2
sources <- melt(sources)
names(sources) <- c("Year","Type","Total.Emmissions")

# create plots and send to png device (use default width/height of 480x480)
png(filename="plot3.png")
qplot(Year,Total.Emmissions,data=sources,col=Type, main="Total Emmissions by Source in Baltimore")
dev.off()