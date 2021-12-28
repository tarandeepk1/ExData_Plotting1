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
png(file="plot4.png")
par(mfrow=c(2,2))

#plot(1,1)
data2$Global_active_power<-as.numeric(data2$Global_active_power)
plot(data2$datetime, data2$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#plot(1,2)
data2$Voltage<-as.numeric(data2$Voltage)
plot(data2$datetime, data2$Voltage, type="l", xlab="datetime", ylab="Voltage")

#plot(1,3)
plot(data2$datetime, data2$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
points(data2$datetime, data2$Sub_metering_2, type="l", col="red")
points(data2$datetime, data2$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#plot(1,4)
data2$Global_reactive_power<-as.numeric(data2$Global_reactive_power)
plot(data2$datetime, data2$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()