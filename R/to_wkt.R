#' To WKT
#'
#' @export
#' @param x Input
to_wkt <- function(x) {
  UseMethod("to_wkt")
}

#' @export
to_wkt.axewkt <- function(x) x

#' @export
to_wkt.SpatialPolygons <- function(x) {
  towkt(lapply(x@polygons, function(z) writeWKT(SpatialPolygons(list(z)))))
}

towkt <- function(x) {
  structure(x, class = "axewkt")
}
