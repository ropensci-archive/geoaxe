geoaxe
======



[![Build Status](https://travis-ci.org/ropenscilabs/geoaxe.svg)](https://travis-ci.org/ropenscilabs/geoaxe)

`geoaxe` - split geospatial objects into pieces

## Install


```r
devtools::install_github("ropenscilabs/geoaxe")
```


```r
library("geoaxe")
```

## SpatialPolygons


```r
library("rgeos")
wkt <- "POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))"
poly <- readWKT(wkt)
polys <- chop(x = poly)
plot(polys)
plot(poly, add = TRUE, lwd = 6)
```

![plot of chunk unnamed-chunk-4](inst/img/unnamed-chunk-4-1.png) 

## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/geoaxe/issues).
* License: MIT
