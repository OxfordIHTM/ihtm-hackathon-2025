# Read and download data ----

read_data <- function(url, destfile) {
  download.file (url = url, destfile = destfile, mode = "wb")
  
}