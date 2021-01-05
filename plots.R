## Install, and load the package data.table in order to read the files
install.packages('data.table')
library(data.table)
install.packages('dplyr')
library(dplyr)

##Reading the .txt file
housepower<-as.data.frame(read.table('household_power_consumption.txt', 
                                     header=TRUE, sep = ';'))
housepower<-as.data.table(housepower)

##Create the new variable datetime
housepower[,datetime:=strptime(paste(Date,Time),'%d/%m/%y %H:%M:%S')]

##Select the dates 2007-02-01 and 2007-02-02
housepower<-subset(housepower, 
                        datetime<=strptime('2007-02-02 23:59:59', '%Y-%m-%d %H:%M:%S') & 
                          datetime>=strptime('2007-02-01 00:00:00', '%Y-%m-%d %H:%M:%S'))
housepower$Global_active_power<-as.numeric(
  as.character.numeric_version(housepower$Global_active_power))
housepower$Global_reactive_power<-as.numeric(
  as.character.numeric_version(housepower$Global_reactive_power))
housepower$Voltage<-as.numeric(
  as.character.numeric_version(housepower$Voltage))
housepower$Global_intensity<-as.numeric(
  as.character.numeric_version(housepower$Global_intensity))
housepower$Sub_metering_1<-as.numeric(
  as.character.numeric_version(housepower$Sub_metering_1))
housepower$Sub_metering_2<-as.numeric(
  as.character.numeric_version(housepower$Sub_metering_2))
housepower$Sub_metering_3<-as.numeric(
  as.character.numeric_version(housepower$Sub_metering_3))

##Create the first plot

##Create and open the first file
png('plot1.png', width=480, height = 480)
##Create the histogram
hist(housepower$Global_active_power, col = 'red', 
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
##Close the device
dev.off()

##Create the second plot

##Create and open the first file
png('plot2.png', width=480, height = 480)
##Create the graph
plot(housepower$datetime,housepower$Global_active_power, 
     type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
##Close the device
dev.off()

##Create the third plot

##Create and open the first file
png('plot3.png', width=480, height = 480)
##Create the graph
plot(housepower$datetime,housepower$Sub_metering_1, type = 'n', 
     xlab = '', ylab = 'Energy sub metering')
points(housepower$datetime,housepower$Sub_metering_1, type = 'l', 
       xlab = '', ylab = 'Energy sub metering')
points(housepower$datetime,housepower$Sub_metering_2, type = 'l', 
       col='red',xlab = '', ylab = 'Energy sub metering')
points(housepower$datetime,housepower$Sub_metering_3, type = 'l', 
       col='blue',xlab = '', ylab = 'Energy sub metering')
legend('topright', col=c('black','red','blue'), 
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1)
##Close the device
dev.off()

##Create the fourth plot

##Create and open the first file
png('plot4.png', width=480, height = 480)
##Create the graph

##Divide the device in 4
par(mfrow=c(2,2))

plot(housepower$datetime,housepower$Global_active_power, 
     type = 'l', xlab = '', ylab = 'Global Active Power')
plot(housepower$datetime,housepower$Voltage, 
     type = 'l', xlab = 'datetime', ylab = 'Voltage')
plot(housepower$datetime,housepower$Sub_metering_1, type = 'n', 
     xlab = '', ylab = 'Energy sub metering')
points(housepower$datetime,housepower$Sub_metering_1, type = 'l', 
       xlab = '', ylab = 'Energy sub metering')
points(housepower$datetime,housepower$Sub_metering_2, type = 'l', 
       col='red',xlab = '', ylab = 'Energy sub metering')
points(housepower$datetime,housepower$Sub_metering_3, type = 'l', 
       col='blue',xlab = '', ylab = 'Energy sub metering')
legend('topright', col=c('black','red','blue'), 
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1)
plot(housepower$datetime,housepower$Global_reactive_power, 
     type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')
##Close the device
dev.off()




