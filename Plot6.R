library(ggplot2)


dataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

BMFIPS<-24510
LAFIPS<-06037
COAL<-"Coal"
ROAD<- "ON-ROAD"

dlfile1<-"dlfile1.zip"

if(!file.exists(dlfile1)) {
  download.file(dataURL, destfile = dlfile1, method = "curl")
  unzip(dlfile1, exdir = ".")
}


NEIrds <- readRDS("summarySCC_PM25.rds")
SCCrds <- readRDS("Source_Classification_Code.rds")

baltimoreNEIRoadData<- subset(NEIrds, fips==BMFIPS & type==ROAD)

LANEIRoadData<-subset(NEIrds, fips=LAFIPS & type==ROAD)


TotalBMRoadAggregations<- aggregate(Emissions ~ year, baltimoreNEIRoadData, sum)

TotalLARoadAggregations<-aggregate(Emissions ~ year, LANEIRoadData, sum)

png("plot5.png",width=480,height=480)

barplot(TotalBMRoadAggregations$Emissions, names.arg=TotalBMRoadAggregations$year, 
        xlab="Years", ylab="Total Road Emissions of 2.5", main="Total Yearly Motor Vehicle  Emissions at Baltimore")


dev.off()
