#download data set
download.file(url = "https://assets.publishing.service.gov.uk/media/5dc407b440f0b6379a7acc8d/File_7_-_All_IoD2019_Scores__Ranks__Deciles_and_Population_Denominators_3.csv",
              destfile = "data/imd.csv")
          
#read data set 

imd_data = read.csv(
  file = "https://assets.publishing.service.gov.uk/media/5dc407b440f0b6379a7acc8d/File_7_-_All_IoD2019_Scores__Ranks__Deciles_and_Population_Denominators_3.csv", 
  header = TRUE)

#download and read

download_read = function(url,destfile){
  download.file(url = url, destfile = destfile) 
                read.csv(file = destfile)}

download_read(url = "https://assets.publishing.service.gov.uk/media/5dc407b440f0b6379a7acc8d/File_7_-_All_IoD2019_Scores__Ranks__Deciles_and_Population_Denominators_3.csv", 
              destfile = "data/imd.csv")

#summarize the data 

summary(imd_data)

# data structure

str(imd_data)
