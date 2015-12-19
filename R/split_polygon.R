#' Split polygon
#'
#' @export
#' @param x Spatial object
#' @param cellsize size
#' @param cells.dim Dimension
#' @examples
#' library("rgeos")
#' poly <- readWKT("POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))")
#' plot(poly)
#' polys <- split_polygon(x = poly)
#' to_wkt(polys)
#' plot(readWKT(to_wkt(polys)[1]))
#' plot(readWKT(to_wkt(polys)[10]))
split_polygon <- function(x, cellsize = 10, cells.dim = 20) {
  box <- bbox(x)
  gt <- GridTopology(c(box[1,1], box[2,1]), rep(cellsize, 2), rep(cells.dim, 2))
  gr <- as(as(SpatialGrid(gt), "SpatialPixels"), "SpatialPolygons")
  gIntersection(x, gr, byid = TRUE, drop_lower_td = TRUE)
}
