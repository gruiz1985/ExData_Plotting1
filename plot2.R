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


##Create the second plot

##Create and open the first file
png('plot2.png', width=480, height = 480)
##Create the graph
plot(housepower$datetime,housepower$Global_active_power, 
     type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
##Close the device
dev.off()
