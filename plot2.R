rm(list = ls()) #Clean workspace

library(data.table)

getwd() #check the working directory
zipF <- "exdata_data_household_power_consumption.zip" #assign the zip file to a variable called zipF
dataset_zip <- unzip(zipF) #unzip the file
dataset <- fread(dataset_zip) #load in the zip file

dataset <- subset(dataset, Date %in% c("1/2/2007","2/2/2007")) #subset the date of interest
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y") #as.Date format

date_time <- paste(as.Date(dataset$Date), dataset$Time) #Create a variable of date & Time
dataset$Datetime <- as.POSIXct(date_time) #POSIXct format

##Plot and save
png("plot2.png", width=500, height=500) #Open png
with(dataset, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
}) #plot 
dev.off()

