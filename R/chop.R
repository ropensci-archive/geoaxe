#' Split polygon into many
#'
#' @export
#' @param x Spatial object
#' @param cellsize size
#' @param cells.dim Dimension
#' @details Works on spatial classes of type \code{SpatialPolygons}, and on
#' Well-Known Text character strings.
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
#' # geojson character input
#' # geojsonio::as.json(wellknown::wkt2geojson(wkt)$geometry)
#' x <- '{"type":"Polygon","coordinates":[[["-180.0","-20.0"],["-140.0","55.0"],["10.0","0.0"],["-140.0","-60.0"],["-180.0","-20.0"]]]}'
#' # chop(x)
#'
#' # geojson list input
#' # chop(wkt)
#'
#' ## ignore
#' # geojsonio::geojson_json(poly) %>% geojsonio::map_leaf()
#' # geojsonio::geojson_json(polys) %>% geojsonio::map_leaf()
chop <- function(x, cellsize = 10, cells.dim = 20) {
  UseMethod("chop")
}

#' @export
chop.SpatialPolygons <- function(x, cellsize = 10, cells.dim = 20) {
  box <- bbox(x)
  gt <- GridTopology(c(box[1,1], box[2,1]), rep(cellsize, 2), rep(cells.dim, 2))
  gr <- as(as(SpatialGrid(gt), "SpatialPixels"), "SpatialPolygons")
  gIntersection(x, gr, byid = TRUE, drop_lower_td = TRUE)
}

#' @export
chop.character <- function(x, cellsize = 10, cells.dim = 20) {
  switch(wkt_geojson(x),
    wkt = chop(readWKT(x), cellsize = cellsize, cells.dim = cells.dim),
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
