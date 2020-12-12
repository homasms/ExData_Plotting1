library(dplyr)
setwd("f:/R_learning/course4-1-project")

# read data
exdata <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt",
                     header = TRUE, sep = ";")
power_table <- filter(exdata, Date == "2/2/2007" | Date == "1/2/2007")

# convert type of date and time
power_table$Date <- as.Date(power_table$Date, "%d/%m/%Y")

# combine date and time column
pow <- select(power_table, -Date, -Time)
DateTime <- paste(power_table$Date, power_table$Time)
pow <- cbind(pow, DateTime)
pow$DateTime <- as.POSIXct(DateTime)

# organize window size
windows(height = 10, width = 10)
par(mfrow = c(2, 2), mar = c(3, 4, 3, 3))

# plot 1
with(pow, plot( DateTime, Global_active_power, type="l",
                ylab="Global Active Power (kilowatts)", xlab="", col = "black"))

# plot 2
plot(pow$DateTime, pow$Voltage, type = "l", xlab = "datetime", ylab = "voltage")

# plot 3
with(pow, plot(DateTime, Sub_metering_1, type = "l",
               ylab = "Energy sub metering", xlab = ""))
lines(pow$DateTime, pow$Sub_metering_2, col = "red")
lines(pow$DateTime, pow$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1, cex = 0.65, xjust = 1, yjust = 0)

# plot 4
with(pow, plot( DateTime, Global_reactive_power, type="l",
                ylab="Global Active Power (kilowatts)", xlab="", col = "black"))

# save in png
dev.copy(png, file = "plot4.png")
dev.off()
