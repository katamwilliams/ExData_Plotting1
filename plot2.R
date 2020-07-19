#### Download Data and Unzip Data ####
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile<- "project1data.zip"

download.file(url,destfile, method="curl")
unzip(zipfile="project1data.zip", exdir=as.character(getwd()))

#### Load Data into R ####

df<- read.table("household_power_consumption.txt", 
                header= TRUE, 
                sep=";",
                na.strings = "?")
#### Convert Date and Time variables to Date and Time class ####

df$DT <- strptime(paste(df$Date,df$Time),format="%d/%m/%Y%H:%M:%S")
df$Date<- as.Date(df$Date, format="%d/%m/%Y")
df$Time <- strptime(df$Time, format= "%H:%M:%S")

#### Subsetting for 1/2/07 and 2/2/07 ####

index <- which(df$Date == '2007-02-01'|df$Date == '2007-02-02')

subdata <- df[index,]

#### Constructing Plot ####

png("plot2.png")
plot(subdata$DT,
     subdata$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()


