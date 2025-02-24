# Download and read required datasets ------------------------------------------

## Index of Multiple Deprivation dataset ----

### Download IMD dataset if not already available locally ----
if (!"imd.csv" %in% list.files("data")) {
  download.file (
    url = "https://assets.publishing.service.gov.uk/media/5dc407b440f0b6379a7acc8d/File_7_-_All_IoD2019_Scores__Ranks__Deciles_and_Population_Denominators_3.csv",
    destfile= "data/imd.csv"
  )  
} else {
  message(
    "imd.csv found in data directory. File will not be re-downloaded."
  )
}

### Read imd.csv dataset ----
imd <- read.csv("data/imd.csv")


## England map dataset ----

### Download zipfile of England shapefiles ----
if ("england_map.zip" %in% list.files("data")) {
  message(
    "england_map.zip found in data directory. File will not be re-downloaded."
  )
} else {
  download.file(
    url = "https://github.com/OxfordIHTM/teaching_datasets/raw/refs/heads/main/English%20IMD%202019.zip",
    destfile = "data/england_map.zip", mode = "wb"
  )  
}

### Extract shapefile from zipfile ----
unzip(
  zipfile = "data/england_map.zip",
  overwrite = FALSE, exdir = "data"
)

### Read shapefile of England ----
library(sf)

england <- st_read(
  dsn = "data/English IMD 2019",
  layer = "IMD_2019"
)


