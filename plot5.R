#Reading files
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")


#5 
nei.all <-NEI[NEI$fips %in% c("24510","06037"),]
aaa<-merge(nei.all,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)
nei.vehicle<-aaa[grep("VEHICLE",toupper(aaa$Short.Name)),]
nei.vehicle_agg<-aggregate(Emissions ~ fips+year, data=nei.vehicle, FUN=sum)
nei.bltm<-nei.vehicle_agg[nei.vehicle_agg$fips=="24510",]
#nei.la<-nei.vehicle_agg[nei.vehicle_agg$fips=="06037",]

png("plot5.png",width = 480, height = 480, units = "px")

plot(nei.bltm$Emission~nei.bltm$year,col="red",type="l",xlab = "Year",ylab = "PM2.5 Emission",
     main="Motor vehicle PM2.5 Emission")
dev.off()

#lines(nei.bltm$Emission~nei.bltm$year,col = "blue")
