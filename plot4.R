load_power_data <-function(){
  
  ## Download and extract the data
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  power <- read.table(unz(temp, "household_power_consumption.txt"),header=T, sep=";",stringsAsFactors =FALSE )
  unlink(temp)
  
  
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  power_subset <- power[ power$Date=="2007-02-01" | power$Date=="2007-02-02" ,]
  power_subset$Date_Time <- paste(power_subset$Date, power_subset$Time)
  
  #Convert data field from character to data type
  power_subset$Date_Time <- strptime(power_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")
  class(power_subset$Date_Time)
  #convert the numeric fields to numeric from character
  for(i in c(3:9)) {power_subset[,i] <- as.numeric(as.character(power_subset[,i]))}
  power_subset;
}

## load the data, by calling our function.

plot4_data <- load_power_data()

######### Plot 4 #########

#### Turn on png device and set parameters
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)

#### Plot 2 in top left
plot(plot4_data$Date_Time, plot4_data$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis
# xlab = "" removes the label from the x axis
# otherwise, the axis is the name of the x variable, which is date_time

lines(plot4_data$Date_Time, plot4_data$Global_active_power, type="S")


#### Top right graph
plot(plot4_data$Date_Time, plot4_data$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis

lines(plot4_data$Date_Time, plot4_data$Voltage, type="S")


#### Plot 3 in bottom left
plot(plot4_data$Date_Time, plot4_data$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
## Sets up the plot, but does not populate with any data

lines(plot4_data$Date_Time, plot4_data$Sub_metering_1, col = "black", type = "S")
## Plots lines for sub_metering_1
lines(plot4_data$Date_Time, plot4_data$Sub_metering_2, col = "red", type = "S")
## Plots lines for sub_metering_2
lines(plot4_data$Date_Time, plot4_data$Sub_metering_3, col = "blue", type = "S")
## Plots lines for sub_metering_3

legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Adds a legend with lines
# lwd = c(1, 1, 1) assigns the lines widths of 1
# lty = c(1, 1) assigns the line type within the legend
# bty = "n" sets the box type to none


#### Bottom right graph
plot(plot4_data$Date_Time, plot4_data$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis

lines(plot4_data$Date_Time, plot4_data$Global_reactive_power, type="S")

#### Turn off device
dev.off()
