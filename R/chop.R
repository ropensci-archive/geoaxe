#' Split polygon into many
#'
#' @export
#' @param x Spatial object
#' @param size size of each side of each cell, which makes a square cell
#' @param n number of cells to make in each dimension, same number used for
#' each dimension
#' @details Works on spatial classes of type \code{SpatialPolygons}, and on
#' Well-Known Text character strings. GeoJSON character strings and lists
#' to come
#' @examples
#' library("rgeos")
#' wkt <- "POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))"
#'
#' # SpatialPolygons input
#' poly <- readWKT(wkt)
#' plot(poly)
#' polys <- chop(x = poly)
#' to_wkt(polys)
#' to_wkt(polys)[[2]]
#' plot(polys)
#' plot(poly, add = TRUE, lwd = 6)
#'
#' # WKT character input
#' chop(wkt)
#'
#' ## example w/ more complex polygon
#' ff <- system.file("examples", "us_eez_alaska.txt", package = "geoaxe")
#' wkt <- readLines(ff)
#' res <- chop(wkt, size = 2)
#' ttt <- readWKT(wkt)
#' # plot(ttt, lwd = 2)
#' # plot(res, add = TRUE)
#'
#' # geojson character input
#' # geojsonio::as.json(wellknown::wkt2geojson(wkt)$geometry)
#' # chop(x)
#'
#' # geojson list input
#' # chop(wkt)
#'
#' ## ignore
#' # geojsonio::geojson_json(poly) %>% geojsonio::map_leaf()
#' # geojsonio::geojson_json(polys) %>% geojsonio::map_leaf()
chop <- function(x, size = 10, n = 20) {
  UseMethod("chop")
}

#' @export
chop.SpatialPolygons <- function(x, size = 10, n = 20) {
  box <- sp::bbox(x)
  gt <- sp::GridTopology(c(box[1,1], box[2,1]), rep(size, 2), rep(n, 2))
  gr <- as(as(sp::SpatialGrid(gt), "SpatialPixels"), "SpatialPolygons")
  gIntersection(x, gr, byid = TRUE, drop_lower_td = TRUE)
}

#' @export
chop.character <- function(x, size = 10, n = 20) {
  switch(wkt_geojson(x),
    wkt = chop(rgeos::readWKT(x), size = size, n = n),
    geojson = {
      stop("not ready yet", call. = FALSE)
      # ff <- tempfile(fileext = ".geojson")
      # writeLines(x, con = ff)
      # cat(x, file = ff, sep = "\n")
      # readOGR('/Users/sacmac/stuff.geojson', "OGRGeoJSON")
    }
    # geojson = chop(geojsonio::geojson_read(x, what = "sp"), cellsize = cellsize, cells.dim = cells.dim)
  )
}

wkt_geojson <- function(x) {
  if (grepl("\\{|\\}", x)) {
    "geojson"
  } else if (grepl("POLYGON|MULTIPOLYGON", x)) {
    "wkt"
  } else {
    stop("No match", call. = FALSE)
  }
}
