library(ggplot2)


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

totalBMYearlyEmissionsByType<- aggregate(Emissions ~ year+type, baltimoreNEIData, sum )

png("plot3.png",width=480,height=480)

graph<- ggplot(totalBMYearlyEmissionsByType, aes(year, Emissions, col=type))

graph<- graph+geom_line()+xlab("Year")+ylab("Total Emissions by Type")+ggtitle("Total Yearly Emissions by Type")

print(graph)

dev.off()
