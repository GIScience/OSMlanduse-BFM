genTileUTM <- function(tilesize, extent, res)
  # generate an matrix of tile extents: ie. (xmin, xmax, ymin, ymax) for each tile
{
  xmins <- seq(xmin(extent), xmax(extent), by=tilesize*res)
  ymins <- seq(ymin(extent), ymax(extent), by=tilesize*res)
  tiles <- expand.grid(xmins,ymins)
  colnames(tiles) <- c("xmin", "ymin")
  xmaxes <- c(xmins[2:length(xmins)], xmax(extent))
  ymaxes <- c(ymins[2:length(ymins)], ymax(extent))
  temp <- expand.grid(xmaxes, ymaxes)
  tiles$xmax <- temp[,1]
  tiles$ymax <- temp[,2]
  
  tiles <- cbind(tiles$xmin, tiles$xmax, tiles$ymin, tiles$ymax)
  colnames(tiles) <- c("xmin", "xmax", "ymin", "ymax")
  
  ind <- NULL
  for (i in 1:length(xmins)){
    for (j in 1:length(ymins)){
      ind <- c(ind, paste(i,".",j,sep=""))
    }
  }
  
  row.names(tiles) <- ind
  
  return(tiles)
}

subsetUTM <- function(data, tilesize, fileext="tif", format="GTiff", overwrite=TRUE)
  # subset a scene or AOI based on a predefined tile size
{
  
  tiles <- genTileUTM(tilesize, extent(data), res(data)[1])
  
  img <- vector("list", nrow(tiles))
  for (i in 1:nrow(tiles)){
    #if not exits tile_folder: generate tile folder
    dir.create(file.path(paste0(folder, "/", row.names(tiles)[i])), showWarnings = FALSE)
    setwd(file.path(paste0(folder, "/", row.names(tiles)[i])))
    img[[i]] <- crop(data, extent(tiles[i,]))
    names(img[[i]]) <- paste(names(data), "_", row.names(tiles)[i], sep="")
    writeRaster(img[[i]], filename=paste(names(data), sep=""),#insert tile folder path
                  format=format, overwrite=overwrite)
    setwd(folder)
  }
  
  return(img)
}
