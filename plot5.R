# Plot5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# read in the data frame objects if they exist in the working dir
if (file.exists("summarySCC_PM25.rds")) NEI <- readRDS("summarySCC_PM25.rds")
if (file.exists("Source_Classification_Code.rds")) SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC (be patient!)
x <- merge(NEI,SCC)

# subset motor vehicle related sources in Baltimore City
is.mv <- grepl("[Vv]ehicles",x$EI.Sector) & x$fips == "24510"
x <- x[is.mv,c("year","Emissions")]

# sum  PM2.5 emissions for each year
x <- tapply(x$Emissions,x$year,sum)

# create plots and send to png device (use default width/height of 480x480)
png(filename="plot5.png")
plot(names(x),x,main="Baltimore Vehicle Emissions PM2.5",xlab="Year",ylab="Emmissions")
dev.off()