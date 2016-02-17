all: move rmd2md

move:
		cp inst/vign/geoaxe_vignette.md vignettes;\
		cp -r inst/vign/img/ vignettes/img/

rmd2md:
		cd vignettes;\
		mv geoaxe_vignette.md geoaxe_vignette.Rmd
