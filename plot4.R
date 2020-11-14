rm(list = ls())

library(data.table)

getwd() #check the working directory
zipF <- "exdata_data_household_power_consumption.zip" #assign the zip file to a variable called zipF
dataset_zip <- unzip(zipF) #unzip the file
dataset <- fread(dataset_zip) #load in the zip file

dataset <- subset(dataset, Date %in% c("1/2/2007","2/2/2007")) #subset the date of interest
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y") #as.Date format

date_time <- paste(as.Date(dataset$Date), dataset$Time)  #Create a variable of date & Time
dataset$Datetime <- as.POSIXct(date_time)

#Plot and save
png("plot4.png", width=500, height=500)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) #Define layout
with(dataset, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)")
  lines(Sub_metering_2~Datetime,col="red")
  lines(Sub_metering_3~Datetime,col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)")
})
dev.off()
