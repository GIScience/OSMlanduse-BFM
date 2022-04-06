landsat_download.py

This python script downloads Landsat 7 and/or 8 images from Google Earth Engine for a given area and timeperiod. It masks the clouds from the images and calculates landcover indices of the images. It can calculate the landcover indices NDVI, NDMI, NDBI, NDWI, and SAVI. It is meant to be run in Google Colab. To run it, you need a Google Earth Engine account.

INPUTS (must be adapted in the script):
- Coordinates of desired study area
- desired time period
- desired folder in your Google Drive where Google Earth Engine should store the downloaded images

OUTPUT:
- The script saves the timeseries of Landsat images cropped to the study area with calculated landcover index in your Google Drive.



mask_raster_landcover.py

This python script masks all raster files in a specified folder to a shapefile. It can be used to mask the Landsat timeseries downloaded from Google Earth Engine to the initial LULC classes from OSMlanduse.

INPUTS:
- Shapefile of the initial LULC class from OSMlanduse. This should be saved in ./data.
- Landsat timeseries (with calculated landcover index) downloaded from Google Earth Engine. The Landsat timeseries should be saved in ./data/landsat/raw/<INDEX FOLDER>.

OUTPUT:
- Landsat timeseries (with calculated landcover index) masked to the areas of the initial OSM LULC class. The masked Landsat timeseries should be saved in ./data/landsat/<INDEX FOLDER>.



bfm_lulc_change.Rmd

This document contains the R code to derive the LULC changes with the OSMlanduse+ method (OSMlanduse changes refined with Landsat timeseries data). The BFAST settings are optimized for the LULC change study of Baden-Württemberg from March 2018 until October 2019.

INPUT:
- Geotiff files of the OSMlanduse changes (one file for each LULC transition). The Geotiffs should have the same spatial resolution as the Landsat images (30 m). They should be saved in the directory ./data.
- Landsat timeseries (with calculated landcover index) masked to the areas of the initial OSM LULC class. The timeseries of each Landsat tile should be saved in a separate directory. The masked Landsat timeseries should be saved in ./data/landsat/<INDEX FOLDER>.

OUTPUT:
- Geotiff of the OSMlanduse+ changes for each LULC transition in each sub-tile. Unforturnately, merging of the generated Geotiffs is not included in this script.
- Printouts of the LULC change emissions for each LULC transition and CO2 emission attribution method, once per sub-tile and once per Landsat tile. Unfortunately, the calculation of the total emissions in the study area is not included in this script.



mosaik_raster.R

This R script mosaics the LULC change maps of the Landsat sub-tiles to one LULC change map and saves it as a Geotiff.

INPUT:
- Change maps of one LULC transition for each Landsat sub-tile, saved in ./data/landsat/<INDEX FOLDER>. Adapt the file name pattern in the script according to the LULC transition of which you want to mosaic the maps!

OUTPUT:
- Mosaicked LULC change maps as Geotiffs, saved in the directory ./output



bfm_test.Rmd

This document contains the R scripts to test the different BFAST settings for Landsat timeseries of each initial LULC class in test areas.

INPUT:
- Landsat timeseries (with calculated landcover index) in a test area masked to the areas of the initial OSM LULC class. The masked Landsat timeseries should be saved in ./data/landsat/<INDEX FOLDER_test>.
- Geotiffs with the LaVerDi LULC changes (one geotiff for each initial LULC class). The Geotiffs should have the same spatial resolution as the Landsat images (30 m). They should be saved in the directory ./data.

OUTPUT:
- Raster maps with overlap of LaVerDi and BFM changes for each initial LULC class
- Plots with LaVerDi and BFM changes for each initial LULC class
- CSVs with number of overlapping raster cells and percentage of overlapping raster cells with respect to total BFM change and total LaVerDi change