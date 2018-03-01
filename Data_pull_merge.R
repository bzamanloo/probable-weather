library(data.table)
library(geosphere)
library(dplyr)

setwd("C:/Users/danie/Desktop/SLearning Project")
load("Helper_File.R")


station_inventory <- read.csv("Station Inventory EN.csv")
station_inventory <- subset(station_inventory,station_inventory$DLY.Last.Year == 2018)


downtown_mtl = station_inventory[which(station_inventory$Name == "MCTAVISH"),]
latlog <- c(downtown_mtl$Longitude..Decimal.Degrees.,downtown_mtl$Latitude..Decimal.Degrees.)
dist_other <- distCosine(latlog,p2 = cbind(station_inventory$Longitude..Decimal.Degrees,
                                           station_inventory$Latitude..Decimal.Degrees.))



IDs <- closestIDs(5)
weather_data <- bulk_download(IDs)

withDescriptive <- left_join(weather_data,station_inventory,by = c("ID" = "Station.ID"))

#This is to take away observations from years prior to when the station started recording daily values
#There is still the issue of observations prior to the actual start date of the weather station

onlyObserved <- withDescriptive[withDescriptive$Year >= withDescriptive$DLY.First.Year,]

#Column names and data format need some cleaning
