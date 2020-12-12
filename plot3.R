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

with(pow, plot(DateTime, Sub_metering_1, type = "l",
               ylab = "Energy sub metering", xlab = ""))
lines(pow$DateTime, pow$Sub_metering_2, col = "red")
lines(pow$DateTime, pow$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 0.5, cex = 0.5)

dev.copy(png, file = "plot3.png")
dev.off()
