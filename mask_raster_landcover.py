# -*- coding: utf-8 -*-
"""
Created on Sun Sep 12 10:01:53 2021

@author: ulric

This script masks all raster files in a specified folder to a shapefile.
"""

import fiona
import rasterio
import rasterio.mask
import os

with fiona.open("data/INITIAL_LULC_CLASS_SHAPEFILE.shp", "r") as shapefile:
    shapes = [feature["geometry"] for feature in shapefile]
    
raster_dir = "data/landsat/raw/INDEX_FOLDER"
outdir = "data/landsat/INDEX_FOLDER"

for filename in os.listdir(raster_dir):
    if filename.endswith('.tif'):
        inraster = os.path.join(raster_dir, filename)
        with rasterio.open(inraster) as src:
            out_image, out_transform = rasterio.mask.mask(src, shapes, crop=True)
            out_meta = src.meta
            
        out_meta.update({"driver": "GTiff",
                 "height": out_image.shape[1],
                 "width": out_image.shape[2],
                 "transform": out_transform})
    
        with rasterio.open(outdir + '/' + filename, "w", **out_meta, compress="LZW") as dest:
            dest.write(out_image)