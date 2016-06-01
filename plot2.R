# Plot2: Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
# to make a plot answering this question.

# read in the data frame objects if they exist in the working dir
if (file.exists("summarySCC_PM25.rds")) NEI <- readRDS("summarySCC_PM25.rds")

# subset the data from Baltimore City
NEISub <- subset(NEI,NEI$fips=="24510")

# sum  PM2.5 emissions for each year
x <- tapply(NEISub$Emissions,NEISub$year,sum)

# create plots and send to png device (use default width/height of 480x480)
png(filename="plot2.png")
plot(names(x),x,main="Total PM2.5 Emmissions Baltimore City",xlab="Year",ylab="Emmissions")
dev.off()