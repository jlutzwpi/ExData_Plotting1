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


#plot 1: Global Active Power vs freqency (histogram)
png("./plot1.png")
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()