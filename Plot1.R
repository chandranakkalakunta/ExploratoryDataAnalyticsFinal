
dataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


dlfile1<-"dlfile1.zip"

if(!file.exists(dlfile1)) {
  download.file(dataURL, destfile = dlfile1, method = "curl")
  unzip(dlfile1, exdir = ".")
}


NEIrds <- readRDS("summarySCC_PM25.rds")
SCCrds <- readRDS("Source_Classification_Code.rds")

totalYearlyEmissions<- aggregate(Emissions ~ year, NEIrds, sum)


png("plot1.png",width=480,height=480)

barplot( totalYearlyEmissions$Emissions ,
         names.arg=totalYearlyEmissions$year, 
         xlab="Years", 
         ylab="Total PM 2.5 emission",
         main="Total PM 2.5 emissions at various years"
)

dev.off()
