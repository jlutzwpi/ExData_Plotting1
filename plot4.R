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

#Plot 4: 4 plots in one: Plots 2 and 3, plus date vs Voltage and date vs
#Global reactive power
png("./plot4.png")
par(mfrow=c(2,2))
#plot 2 first
plot(data$Global_active_power, type="l", lty="solid", main="",
     xlab="",ylab="Global Active Power (kilowatts)", col="black", xaxt='n')
#get the number of rows
len <- nrow(data)
#set the x axis to display the days at the start, midpoint, and end
axis(1, at=c(0, len/2, len), labels=c("Thu", "Fri", "Sat"))

#now the date vs voltage plot
plot(data$Voltage, type="l", lty="solid", main="",
     xlab="datetime",ylab="Voltage", col="black", xaxt='n')
#set the x axis to display the days at the start, midpoint, and end
axis(1, at=c(0, len/2, len), labels=c("Thu", "Fri", "Sat"))

#now plot 3
plot(data$Sub_metering_1, type="l", lty="solid", main="",
     xlab="",ylab="Energy sub metering", col="black", xaxt='n',yaxt='n')
points(data$Sub_metering_2, type="l", lty="solid", col="red")
points(data$Sub_metering_3, type="l", lty="solid", col="blue")
#create a legend
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright",  lty=c(1,1,1), col=c("black", "red","blue"), leg.txt, bty="n",
       cex=0.9)
#set the x axis to display the days at the start, midpoint, and end
axis(1, at=c(0, len/2, len), labels=c("Thu", "Fri", "Sat"))
#set y axis
axis(2, at=c(0,10,20,30), labels=TRUE)

#last plot
plot(data$Global_reactive_power, type="l", lty="solid", main="",
     xlab="datetime",ylab="Global_reactive_power", col="black", xaxt='n')
#set the x axis to display the days at the start, midpoint, and end
axis(1, at=c(0, len/2, len), labels=c("Thu", "Fri", "Sat"))

dev.off()