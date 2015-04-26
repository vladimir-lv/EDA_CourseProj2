#Reading files
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#3
nei.baltimore <-NEI[NEI$fips==24510,]

#merge datasets
aaa<-merge(nei.baltimore,SCC,by.x="SCC",by.y="SCC",all.x=TRUE)

nei.ds<-aaa[,c("SCC","Emissions","type","year")] 
nei.ds_agg<-aggregate(Emissions ~ type+year, data=nei.ds, FUN=sum)

png("plot3.png",width = 480, height = 480, units = "px")
qplot(year, Emissions,data=nei.ds_agg,facets=.~type,geom = "line" )
dev.off()
