# Same block of code will be used here to download and prepare data set.

print("Checking if the data set is already downloaded ......")


if (!file.exists("ElectriPowerConsumption.zip")){
  
  print("Donwlading file ........this will take few momonets")
  download.file(url ="http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",destfile = "/home/jagoul/Coursera/Data-Science-Specialization/Exploratory Data Analysis/Week 1/Projects/ElectriPowerConsumption.zip",method = "libcurl", mode = "w")
  setwd("/home/jagoul/Coursera/Data-Science-Specialization/Exploratory Data Analysis/Week 1/Projects/")
  mypath <- paste(getwd(),"ElectriPowerConsumption.zip", sep ="", collapse = NULL)
  unzip("ElectriPowerConsumption.zip")
  print("Download complete.")
  
}else 
  print("File is already there , preparing plot .................")

#reading the text file and converting it into dataframe 
HPC_Dataset <-read.table("household_power_consumption.txt", header = TRUE,sep = ";",stringsAsFactors=FALSE, dec=".")

#subsetting Data frame according to specific 2 days period in Febraury 2007
Feb_HPC_Dataset <-HPC_Dataset[HPC_Dataset$Date %in% c("1/2/2007","2/2/2007"),]

#preparing and converting time to its appropriate format
dateTime     <-strptime(paste(Feb_HPC_Dataset$Date,Feb_HPC_Dataset$Time, sep = ""),"%d/%m/%Y %H:%M:%S")
subMetering1 <-as.numeric(Feb_HPC_Dataset$Sub_metering_1)
subMetering2 <-as.numeric(Feb_HPC_Dataset$Sub_metering_2)
subMetering3 <-as.numeric(Feb_HPC_Dataset$Sub_metering_3)
#Plotting Date versus Global_active Power values after conversion into numberic values
par(mfrow=c(2,2),  mar=c(4,4,1,1), oma=c(0,0,1,0))
with(Feb_HPC_Dataset, plot(strptime(paste(Date,Time, sep = ""),"%d/%m/%Y %H:%M:%S"), as.numeric(Global_active_power), type = "l",ylim=c(0,6),ylab="Global Active Power", xlab = "Time"))
with(Feb_HPC_Dataset, plot(strptime(paste(Date,Time, sep = ""),"%d/%m/%Y %H:%M:%S"), as.numeric(Voltage), type = "l",ylim=c(234,246),ylab="Voltage", xlab = "datetime"))
with(Feb_HPC_Dataset,plot(dateTime, subMetering1, type = "l", ylab = "Energy sub metric", xlab = "Time"))
lines(dateTime,subMetering2, type ="l", col='red')
lines(dateTime,subMetering3, type ="l", col='blue')
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col = c("black","red","blue"), lty = 1,lwd =3, box.lwd = 0)
with(Feb_HPC_Dataset, plot(strptime(paste(Date,Time, sep = ""),"%d/%m/%Y %H:%M:%S"), as.numeric(Global_reactive_power), type = "l",ylab="Global Reactive Power", xlab = "datetime", ylim = c(0.0,0.5)))

#Export file to the working Directory
dev.copy(png, file="Plot4.png", height=480, width=480)
dev.off()