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

# plot
plot(pow$Global_active_power ~ pow$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="", col = "black")

dev.copy(png, file = "plot2.png")
dev.off()
