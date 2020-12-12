library(dplyr)
setwd("f:/R_learning/course4-1-project")

# read data
exdata <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt",
                     header = TRUE, sep = ";")
power_table <- filter(exdata, Date == "2/2/2007" | Date == "1/2/2007")

# convert type of date and time
power_table$Date <- as.Date(power_table$Date, "%d/%m/%Y")
power_table$Time <- strptime(power_table$Time, "%H:%M:%S")

# plot
hist(as.numeric(power_table$Global_active_power), main = "Global Active Power",
     xlab = "Global Active Power (killowatts)", col = "red")

dev.copy(png, file = "plot1.png")
dev.off()
