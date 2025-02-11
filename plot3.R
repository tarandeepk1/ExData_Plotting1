#download the file and read it
library(downloader)
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = ".")
dataFile<-"./household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#modifications to data
data$Date2 <- as.Date( as.character(data$Date),  "%d/%m/%Y")
data2<-subset(data, Date2>=as.Date("2007-02-01") & Date2<= as.Date("2007-02-02"))
data2$datetime <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#plotting the data
png(file="plot3.png")
plot(data2$datetime, data2$Sub_metering_1, type="l", ylab="Energy Sub Metering",xlab="")
points(data2$datetime, data2$Sub_metering_2, type="l", col="red")
points(data2$datetime, data2$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))
dev.off()