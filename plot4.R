##COURSERA EXPLORATORY DATA ANALYSIS PROJECT ONE##
setwd("C:/Users/Gis/Explore1")
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec=".")

## SUBSET BY DATE ##

power$Date <- as.character(power$Date)
power$Time <- as.character(power$Time)
tmp <- as.Date(c("2007/02/01", "2007/02/02"), "%Y/%m/%d")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power <- power[power$Date %in% tmp,]
rm(tmp)

## DATA SCRUB ##
power$datetime <- paste(power$Date, power$Time)
power$datetime <- as.POSIXct(strptime(power$datetime, format = "%Y-%m-%d %H:%M:%S"))
for (i in c(3:9)) {
power[,i] <- as.character(power[,i])
power[,i] <- as.numeric(power[,i])  
}

## PLOT ##
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(power$datetime, power$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(power$datetime, power$Voltage, type = "l", ylab = "Voltage", xlab = "")
plot(power$datetime, power$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(power$datetime, power$Sub_metering_2, type = "l", col = "red")
  lines(power$datetime, power$Sub_metering_3, type = "l", col = "blue")
  legend("topright", names(power)[7:9], col = c("black", "red", "blue"), lty = 1)
plot(power$datetime, power$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
