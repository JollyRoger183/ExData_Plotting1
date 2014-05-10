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
hist(xdata$Global_active_power, col="red", las=1, 
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(device=png, file="plot1.png", width=480,height=480)
dev.off()
