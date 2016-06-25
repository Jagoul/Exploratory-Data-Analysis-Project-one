print("Welcome To Exploratory Analysis Course project 1")
print("================================================")

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
   
    
    #Plotting histogram of Global_active Power values after conversion into numberic values
    par(mar=c(4,5,2,1))
    with(Feb_HPC_Dataset, hist(as.numeric(Global_active_power), main = "GLobal Active Power", xlab = "Global Active Power (kilowatts)",col = "red", xlim =c(0, 6),xaxt="n", yaxt ="n"))
    axis(1, xaxp= c(0,6,3))
    axis(2, yaxp=c(0,1200,4))
    # #exporting plot as png file and save it under the same repository
    dev.copy(png, filename = "Plot1.png",width = 480, height = 480)
    dev.off()
    # print("Plot is ready , kindly check exported PNG file")
    