# Plot4: Across the United States how have emmissions from coal
# combustion-related sources changed from 1999–2008?

# read in the data frame objects if they exist in the working dir
if (file.exists("summarySCC_PM25.rds")) NEI <- readRDS("summarySCC_PM25.rds")
if (file.exists("Source_Classification_Code.rds")) SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC (be patient!)
x <- merge(NEI,SCC)

# subset coal combustion-related sources and year, emmissions
is.coal <- grepl("[Cc]oal",x$Short.Name)
x <- x[is.coal,c("year","Emissions")]

# sum  PM2.5 emissions for each year
x <- tapply(x$Emissions,x$year,sum)

# create plots and send to png device (use default width/height of 480x480)
png(filename="plot4.png")
plot(names(x),x,main="Total US PM2.5 Emmissions from Coal Sources",xlab="Year",ylab="Emmissions")
dev.off()