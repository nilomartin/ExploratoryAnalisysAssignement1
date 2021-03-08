#using sqldf package to subset while reading the file
library(sqldf)
data<-read.csv.sql("household_power_consumption.txt", header = T, sep = ";", 
                   sql = "select * from file where Date == '1/2/2007' OR Date =='2/2/2007'")
#converting Date data to date class
data$Date<-as.Date(data$Date, "%d/%m/%Y")
#converting time data to date class with chron package
library(chron)
data$Time<-times(data$Time)
#creating a variable with date and time together
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#creating the plot into a png file
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", lty=1, col = c("black", "red", "blue"),legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Reactive Power (kilowatts)",xlab="")
})
dev.off()
