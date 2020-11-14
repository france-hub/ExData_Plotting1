rm(list = ls()) #Clean the workspace

library(data.table)

getwd() #check the working directory
zipF <- "exdata_data_household_power_consumption.zip" #assign the zip file to a variable called zipF
dataset_zip <- unzip(zipF) #unzip the file
dataset <- fread(dataset_zip) #load in the zip file

dataset <- subset(dataset, Date %in% c("1/2/2007","2/2/2007")) #subset the date of interest

GAP <- as.numeric(dataset$Global_active_power) #change the type of variable to be accepted by the hist function

png("plot1.png", width=500, height=500) #Open png
hist(GAP, xlab = "Global Active Power (kilowatts)", #plot the histogram
     col = "red", main = "Global Active Power")
dev.off()

