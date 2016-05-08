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
png("plot1.png", width=480, height=480)
hist(power$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

