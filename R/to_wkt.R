#' To WKT
#'
#' @export
#' @param x An object of class \code{axewkt} or \code{SpatialPolygons}
#' @param recursive (logical) Whether to recursively drill down and split
#' all polygons that would result in \code{MULTIPOLYGON} into single \code{POLYGON}
#' objects
#' @examples
#' library("rgeos")
#' wkt <- "POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))"
#' poly <- readWKT(wkt)
#' polys <- chop(x = poly)
#' to_wkt(polys)
#' to_wkt(polys)[[2]]
#'
#' to_wkt(polys, recursive = FALSE)
#' to_wkt(polys, recursive = TRUE)
to_wkt <- function(x, recursive = FALSE) {
  UseMethod("to_wkt")
}

#' @export
to_wkt.default <- function(x, recursive = FALSE) {
  stop("no to_wkt method for ", class(x), call. = FALSE)
}

#' @export
to_wkt.axewkt <- function(x, recursive = FALSE) x

#' @export
to_wkt.SpatialPolygons <- function(x, recursive = FALSE) {
  if (recursive) {
    tmp <- as.character(unlist(lapply(x@polygons, function(z) {
      lapply(z@Polygons, function(w) rgeos::writeWKT(sp::SpatialPolygons(list(sp::Polygons(list(w), 1)))))
    }), recursive = FALSE))
  } else {
    tmp <- lapply(x@polygons, function(z) rgeos::writeWKT(sp::SpatialPolygons(list(z))))
  }
  towkt(as.character(tmp))
}

towkt <- function(x) {
  structure(x, class = "axewkt")
}
