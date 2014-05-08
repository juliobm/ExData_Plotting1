# the data begins in 66645 and ends at 69524
# sqldf doesn't work for me unless it's the better way
#
Sys.setlocale(category = "LC_ALL", locale = "C")
row_start <- 66645
row_stop <- 69524
row_total <- row_stop-row_start+1
dplot <- 
  read.csv("household_power_consumption.txt", header=TRUE, sep=";", fill=TRUE, dec=".",
           skip=row_start-2,nrows=row_total,as.is=T,
           col.names=c("Date","Time","Global_active_power",
                       "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                       "Sub_metering_3"), colClasses=c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
head(dplot,n=1)
tail(dplot,n=1)
days <- strptime(paste(dplot$Date, dplot$Time), format="%d/%m/%Y %H:%M:%S")
head(days)
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,2))
plot(days, dplot$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
# 2
plot(days, dplot$Voltage, type="l", xlab="datetime", ylab="Voltage")
# 3
plot(days, dplot$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(days, dplot$Sub_metering_2, type="l", col="red")
points(days, dplot$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1,1), bty="n", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# 4
plot(days, dplot$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
# plot directly in the png device to avoid weirds behaviers
#dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

