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

# create plot and save as png.file
#=================================
# create plot number 3 - Energy sub metering
#===========================================
plot(x=xdata$date_time, y=xdata$Global_active_power,
     type="l", ylab="Global Active Power (kilowatts)", xlab="")

plot(x=xdata$date_time, y=xdata$Sub_metering_1,
     type="l", ylab="Energy sub metering", xlab="", las=1)
lines(x=xdata$date_time, y=xdata$Sub_metering_2,
      type="l", col="red")
lines(x=xdata$date_time, y=xdata$Sub_metering_3,
      type="l", col="blue")
legend("topright", legend=c(paste("sub_metering", 1:3, sep="_")),
       col=c(1:3), lwd=1, lty=1)

dev.copy(device=png, file="plot3.png", width=480,height=480)
dev.off()
