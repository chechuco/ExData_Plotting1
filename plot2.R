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
png(file = "plot2.png", width = 480, height=480)
#hist(one_day$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active power (kilowatts)", ylim = c(0, 1200))
x <- one_day$Time
y <- one_day$Global_active_power
plot(x,y, type = "n", ylab = "Global Active power (kilowatts)", xlab = "")
lines(x,y, type = "l")
dev.off()