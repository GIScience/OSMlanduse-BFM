intersectExtent <- function(x){
  # output an extent object representing the intersect of all extents
  # arguments:
  # x - either a list of rasterLayers, sp objects, or Extent objects
  
  # check if input is a list
  if(!is.list(x)){
    stop("x should be a list of RasterLayers, sp objects or Extent objects.\n")
  }
  
  # check object classes in list
  classes <- unique(unlist(sapply(x, class)))
  if(length(classes) > 1 | !classes %in% c("RasterLayer", "RasterBrick", "RasterStack", "Extent", "SpatialPolygons", "SpatialPolygonsDataFrame")){
    stop("x should be a list of RasterLayers, sp objects or Extent objects.\n")
  }
  
  # extract extents
  if(classes=="Extent"){
    e <- x
  } else {
    e <- lapply(x, extent)
  }
  
  # define intersect Extent
  intersectxmin <- max(unlist(lapply(e, xmin)))
  intersectxmax <- min(unlist(lapply(e, xmax)))
  intersectymin <- max(unlist(lapply(e, ymin)))
  intersectymax <- min(unlist(lapply(e, ymax)))
  intersecte <- extent(c(intersectxmin, intersectxmax, intersectymin, intersectymax))
  
  return(intersecte)
}