geoaxe
======



[![Build Status](https://travis-ci.org/ropenscilabs/geoaxe.svg)](https://travis-ci.org/ropenscilabs/geoaxe)
[![Build status](https://ci.appveyor.com/api/projects/status/48we73qe8ucf8tst?svg=true)](https://ci.appveyor.com/project/sckott/geoaxe)
[![codecov.io](https://codecov.io/github/ropenscilabs/geoaxe/coverage.svg?branch=master)](https://codecov.io/github/ropenscilabs/geoaxe?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/geoaxe)](https://github.com/metacran/cranlogs.app)

`geoaxe` - split geospatial objects into pieces

## Install


```r
devtools::install_github("ropenscilabs/geoaxe")
```


```r
library("geoaxe")
library("sp")
```

## Spatial Polygons and friends input

Works for only `SpatialPolygons` for now, but aim to include related classes soon.


```r
library("rgeos")
wkt <- "POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))"
poly <- rgeos::readWKT(wkt)
polys <- chop(x = poly)
```

Plot original polygon


```r
plot(poly, lwd = 6)
```

![plot of chunk unnamed-chunk-5](inst/img/unnamed-chunk-5-1.png)

Add chopped up polygon bits


```r
plot(polys, add = TRUE)
```

![plot of chunk unnamed-chunk-6](inst/img/unnamed-chunk-6-1.png)



## Well-Known Text input


```r
wkt <- "POLYGON((-180 -20, -140 55, 10 0, -140 -60, -180 -20))"
plot(chop(wkt))
```

![plot of chunk unnamed-chunk-8](inst/img/unnamed-chunk-8-1.png)



## Manipulate number of cells

> plots go left to right, then down, and repeat


```r
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
par(mar = c(1, 0, 1, 0))
plot(chop(wkt, n = 10))
plot(chop(wkt, n = 15))
plot(chop(wkt, n = 20))
plot(chop(wkt, n = 50))
```

![plot of chunk unnamed-chunk-10](inst/img/unnamed-chunk-10-1.png)



## Manipulate cell size

> plots go left to right, then down, and repeat


```r
layout(matrix(1:8, 4, 2, byrow = TRUE))
par(mar = c(1, 0, 1, 0))
plot(chop(wkt, size = 2))
plot(chop(wkt, size = 4))
plot(chop(wkt, size = 8))
plot(chop(wkt, size = 15))
plot(chop(wkt, size = 25))
plot(chop(wkt, size = 50))
plot(chop(wkt, size = 100))
plot(chop(wkt, size = 200))
```

![plot of chunk unnamed-chunk-12](inst/img/unnamed-chunk-12-1.png)



## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/geoaxe/issues).
* License: MIT
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
