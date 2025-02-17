# download and read data

download.file (url = "https://assets.publishing.service.gov.uk/media/5dc407b440f0b6379a7acc8d/File_7_-_All_IoD2019_Scores__Ranks__Deciles_and_Population_Denominators_3.csv",
destfile= "data/imd.csv"
)
imd <- read.csv("data/imd.csv")

