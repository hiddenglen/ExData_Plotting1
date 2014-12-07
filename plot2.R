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
plot2_data <- load_power_data()

######### Plot 2 #########

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(6, 6, 5, 4))

plot(plot2_data$Date_Time, plot2_data$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis
# xlab = "" removes the label from the x axis
# otherwise, the axis is the name of the x variable, which is date_time

lines(plot2_data$Date_Time, plot2_data$Global_active_power, type="S")

dev.off()