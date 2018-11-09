library(ggplot2)


dataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

BMFIPS<-24510
COAL<-"Coal"

dlfile1<-"dlfile1.zip"

if(!file.exists(dlfile1)) {
  download.file(dataURL, destfile = dlfile1, method = "curl")
  unzip(dlfile1, exdir = ".")
}


NEIrds <- readRDS("summarySCC_PM25.rds")
SCCrds <- readRDS("Source_Classification_Code.rds")

NEISCCrds<- merge(NEIrds,SCCrds, by="SCC")

NEISCCCoalDataIndex<- grep(COAL, NEISCCrds$EI.Sector, ignore.case = TRUE)

NEISCCCoalData<-NEISCCrds[NEISCCCoalDataIndex,]

TotalCoalAggregations<- aggregate(Emissions ~ year, NEISCCCoalData, sum)

png("plot4.png",width=480,height=480)

graph<- ggplot(TotalCoalAggregations, aes(factor(year), Emissions))

graph<- graph+geom_bar(stat="identity")+xlab("Year")+ylab("Total COAL Emissions ")+ggtitle("Total Yearly Coal Related Emissions")

print(graph)

dev.off()
