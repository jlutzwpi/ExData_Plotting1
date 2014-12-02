## Project 1 for Exploratory Data Analysis

# read from large data file, will subset here instead of reading in entire data
# data of interest is from 01/02/2007 to 02/02/2007
# first row of interest is 66637
# last row of interest is 69516
#column names
cols <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data.file <- "./household_power_consumption.txt"
data <- read.csv(data.file, sep=";", skip=66636, nrows=2880, 
                 na.strings="?", col.names=cols)

#convert data and time factors to date and time objects
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, "%H:%M:%S")
#remove default date from the time column
data$Time <- format(data$Time, "%H:%M:%S")

#Plot 2: line graph of date vs Global active power
png("./plot2.png")
plot(data$Global_active_power, type="l", lty="solid", main="",
     xlab="",ylab="Global Active Power (kilowatts)", col="black", xaxt='n')
#get the number of rows
len <- nrow(data)
#set the x axis to display the days at the start, midpoint, and end
axis(1, at=c(0, len/2, len), labels=c("Thu", "Fri", "Sat"))
dev.off()