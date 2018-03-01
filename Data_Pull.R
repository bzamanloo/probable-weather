download_weather <- function(ID, year, month, day, interval){
  url=paste("http://climate.weather.gc.ca/climate_data/bulk_data_e.html?
            format=csv&stationID=",ID,"&Year=",year,"&Month=",month,"&Day=",day,"&timeframe=",interval,"&
            submit=%20Download+Data",sep="")
  
  mydat <- fread(url, autostart = 26)
  
  return(mydat)
}


bulk_download <- function(IDs, years = 2008:2018, months = 1:12, days = 14, interval = 2){
  mydata <- NULL
  
  for(ID in IDs){
    current_id <- NULL
    for(year in years){
      for(month in months){
        for(day in days){
          current_id <- rbind(current_id, cbind(ID,download_weather(ID,year,month,day,interval)))
        }
      }
    }
    mydata <- rbind(current_id, mydata)
  }
  return(mydata)
}



closestIDs <- function(n){ 
  
  closest_n <- which(dist_other %in% sort(dist_other)[1:n])
  ext <- station_inventory[closest_n,]
  
  return(ext$Station.ID)
}