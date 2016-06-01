# Plot6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
# sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over 
# time in motor vehicle emmissions?

library(ggplot2)
library(reshape2)

# read in the data frame objects if they exist in the working dir
if (file.exists("summarySCC_PM25.rds")) NEI <- readRDS("summarySCC_PM25.rds")
if (file.exists("Source_Classification_Code.rds")) SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC (be patient!)
x <- merge(NEI,SCC)

# subset motor vehicle related sources in Baltimore City and Los Angeles County
# and use only the columns required for the plot. 
is.mv <- grepl("[Vv]ehicles",x$EI.Sector) & (x$fips == "24510" | x$fips == "06037")
x <- x[is.mv,c("year","Emissions","fips")]

# sum PM2.5 emmissions by year and fips and put in new dataframe
sources <- tapply(x$Emissions,list(x$year,x$fips),sum)

# melt and rename the columns for better plotting in ggplot2
sources <- melt(sources)
names(sources) <- c("Year","City","Total.Emmissions")

# make Location into a factor for conditioning the plot
sources$City <- factor(sources$City,labels=c("LA County","Baltimore"))

# create plots and send to png device (use default width/height of 480x480)
png(filename="plot6.png")
qplot(Year,Total.Emmissions,data=sources,col=City, main="Total Vehicle Emmissions by City")
dev.off()