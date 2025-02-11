#download the file
library(downloader)
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = ".")
dataFile<-"./household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#modifications to data
data$Date2 <- as.Date( as.character(data$Date),  "%d/%m/%Y")
data2<-subset(data, Date2>=as.Date("2007-02-01") & Date2<= as.Date("2007-02-02"))
data2$Global_active_power<-as.numeric(data2$Global_active_power)

#plotting the data
png(file="plot1.png")
hist(data2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(Kilowatts)")
dev.off()