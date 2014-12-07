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
plot3_data <- load_power_data()

######### Plot 3 #########
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(7, 6, 5, 4))

plot(plot3_data$Date_Time, plot3_data$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
## Sets up the plot, but does not populate with any data

lines(plot3_data$Date_Time, plot3_data$Sub_metering_1, col = "black", type = "S")
## Plots lines for sub_metering_1
lines(plot3_data$Date_Time, plot3_data$Sub_metering_2, col = "red", type = "S")
## Plots lines for sub_metering_2
lines(plot3_data$Date_Time, plot3_data$Sub_metering_3, col = "blue", type = "S")
## Plots lines for sub_metering_3

legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Adds a legend with lines
# lwd = c(1, 1, 1) assigns the lines widths of 1
# lty = c(1, 1) assigns the line type within the legend

dev.off()
