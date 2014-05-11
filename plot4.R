#library(data.table)  # load data.table package to use fread() function

# for very fast read in of all rows:
#===================================
#xdata <- fread(input="C:/02_LEARNING/coursera/Data Science/04 - Exploratory Data Analysis/household_power_consumption.txt",
#               sep="auto", na.string="?", header=TRUE, stringsAsFactors=FALSE)

#xdata <- as.data.frame(xdata)
#setwd("C:/02_LEARNING/coursera/Data Science/04 - Exploratory Data Analysis")


# for slower read in of only certain number of rows (100,000):
#=============================================================


xdata <- read.table(file="household_power_consumption.txt",
               nrows=100000, header=TRUE, na.string="?", sep=";", stringsAsFactors=FALSE)

# select only the rows for 1st and 2nd February 2007
date_rows <- xdata$Date %in% c("1/2/2007", "2/2/2007")
xdata <- xdata[date_rows, ]

#> dim(xdata)
#[1] 2880    9  
# 24h * 60min * 2 days = 2880 measurments (every minute for two days)

xdata$date_time <- strptime(paste(xdata$Date, xdata$Time), format="%d/%m/%Y %H:%M:%S")
xdata$Date <- as.Date(xdata$Date, format="%d/%m/%Y")

# create file
#============
png(filename="plot4.png", width=480, height=480, bg="white")

par(mfrow=c(2,2))

# create plot number 1 - Global Active Power
#===========================================
plot(x=xdata$date_time, y=xdata$Global_active_power,
     type="l", ylab="Global Active Power (kilowatts)", xlab="")

# create plot number 2 - Voltage
#===============================
plot(x=xdata$date_time, y=xdata$Voltage,
     type="l", ylab="Voltage", xlab="datetime")


# create plot number 3 - Energy sub metering
#===========================================
plot(x=xdata$date_time, y=xdata$Sub_metering_1,
     type="l", ylab="Energy sub metering", xlab="", las=1)
lines(x=xdata$date_time, y=xdata$Sub_metering_2,
      type="l", col="red")
lines(x=xdata$date_time, y=xdata$Sub_metering_3,
      type="l", col="blue")
legend("topright", legend=c(paste("sub_metering", 1:3, sep="_")),
       col=c("black", "red", "blue"), lwd=1, lty=1)

# create plot number 4 - Global_reactive_power
#=============================================
plot(x=xdata$date_time, y=xdata$Global_reactive_power, las=1,
     type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
