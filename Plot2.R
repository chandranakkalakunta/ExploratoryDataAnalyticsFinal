

dataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

BMFIPS<-24510

dlfile1<-"dlfile1.zip"

if(!file.exists(dlfile1)) {
  download.file(dataURL, destfile = dlfile1, method = "curl")
  unzip(dlfile1, exdir = ".")
}


NEIrds <- readRDS("summarySCC_PM25.rds")
SCCrds <- readRDS("Source_Classification_Code.rds")

baltimoreNEIData<- subset(NEIrds, fips==BMFIPS)

totalBMYearlyEmissions<- aggregate(Emissions ~ year, baltimoreNEIData, sum )

png("plot2.png",width=480,height=480)

barplot(totalBMYearlyEmissions$Emissions, names.arg=totalBMYearlyEmissions$year, 
        xlab="Years", ylab="Total Emissions of 2.5", main="Total Yearly Emissions at Baltimore")

dev.off()
