###MOSAIK RASTER###

#This script mosaics the LULC change maps of the Landsat sub-tiles to one LULC
#change map and saves it as a Geotiff.

#set working directory
setwd('./data/landsat/INDEX_FOLDER')

#list all change maps for LULC conversion to certain class (adapt, if necessary)
tiles <- list.files(full.names = T , recursive =T, pattern='\\urban.tif$')
tiles

#make empty raster list
your_length <- 0
rast_list <- rep(NA, your_length)

#import tiles as raster into the raster list
for (tile in tiles){ 
  rast = raster(tile)
  rast_list <- c(rast_list, rast)
}

#merge rasters and save geotiff
path.mrg='./output/'
rast_list$tolerance <- 1
rast_list$filename <- paste0(path.mrg, "osmlanduseplus_pasture_to_urban.tif")
#rast_list$overlap <- FALSE
rast_list$overwrite <- TRUE
mm <- do.call(merge, rast_list)