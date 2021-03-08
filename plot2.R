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
png("plot2.png", width=480, height=480)
with(data, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})
dev.off()
