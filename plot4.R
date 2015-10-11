## Load libraries
library("data.table")
library("lubridate")
## Download the data file to your working directory:
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")
## Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = TRUE, na.strings = c("?", ""))
data <-data.table(data)
## Select data
one_day <- data[Date %in% c("1/2/2007", "2/2/2007")]
## Clean data
one_day$Date <- as.Date(one_day$Date, format = "%d/%m/%Y")
one_day$time_tmp <- paste(one_day$Date, one_day$Time)
one_day$Time <- ymd_hms(one_day$time_tmp)
## Draw the plot
png(file = "plot4.png", width = 480, height=480)
par(mfcol = c(2,2))
# Plot 1
x <- one_day$Time
y <- one_day$Global_active_power
plot(x,y, type = "n", ylab = "Global Active power (kilowatts)", xlab = "")
lines(x,y, type = "l")
# Plot 2
x <- one_day$Time
y1 <- one_day$Sub_metering_1
y2 <- one_day$Sub_metering_2
y3 <- one_day$Sub_metering_3
plot(x,y1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(x,y1, type = "l")
lines(x,y2, type = "l", col="red")
lines(x,y3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), seg.len = 5)
# Plot 3
x <- one_day$Time
y <- one_day$Voltage
plot(x,y, type = "n", ylab = "Voltage", xlab = "datetime")
lines(x,y, type = "l")
# Plot 4
x <- one_day$Time
y <- one_day$Global_reactive_power
plot(x,y, type = "n", ylab = "Global_reactive_power", xlab = "datetime", ylim = c(0, 0.5))
lines(x,y, type = "l")
dev.off()