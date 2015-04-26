#Reading files
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#2
nei.ds1<-aggregate(Emissions ~ year, data=NEI[NEI$fips==24510,], FUN=sum)

png("plot2.png",width = 480, height = 480, units = "px")
plot(nei.ds1$Emissions~nei.ds1$year,type="l",xlab = "Years",ylab = "Total Emission PM2.5",
      main="Baltimore City Total Emission PM2.5")
dev.off()

#3
nei.baltimore <-NEI[NEI$fips==24510,]

#merge datasets
aaa<-merge(nei.baltimore,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)

nei.ds<-aaa[,c("SCC","Emissions","type","year")] 
nei.ds_agg<-aggregate(Emissions ~ type+year, data=nei.ds, FUN=sum)
qplot(year, Emissions,data=nei.ds_agg,facets=.~type )

plot(aaa$Emission~aaa$year,type="l")
lines()

#4
aaa<-merge(NEI,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)
nei.coal<-aaa[grep("COAL",toupper(aaa$Short.Name)),c("Emissions","year")]
nei.coal_agg<-aggregate(Emissions ~ year, data=nei.coal, FUN=sum)
plot(nei.coal_agg$Emission~nei.coal_agg$year,type="l")

#5 
nei.all <-NEI[NEI$fips %in% c("24510","06037"),]
aaa<-merge(nei.all,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)
nei.vehicle<-aaa[grep("VEHICLE",toupper(aaa$Short.Name)),]
nei.vehicle_agg<-aggregate(Emissions ~ fips+year, data=nei.vehicle, FUN=sum)
nei.bltm<-nei.vehicle_agg[nei.vehicle_agg$fips=="24510",]
nei.la<-nei.vehicle_agg[nei.vehicle_agg$fips=="06037",]
plot(nei.la$Emission~nei.la$year,col="red",type="l")
lines(nei.bltm$Emission~nei.bltm$year,col = "blue")
