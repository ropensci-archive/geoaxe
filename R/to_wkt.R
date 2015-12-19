#' To WKT
#'
#' @export
#' @param x Input
to_wkt <- function(x) {
  UseMethod("to_wkt")
}

#' @export
to_wkt.SpatialPolygons <- function(x) {
  lapply(x@polygons, function(z) writeWKT(SpatialPolygons(list(z))))
}
