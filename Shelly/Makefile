
.PHONY: build all

all: shellie

shellie:
	echo -n "capside nutside" | \
		xargs -d ' ' --no-run-if-empty -n1 -P1 -I {} \
		docker run --rm \
			-v $(PWD):/src \
				bbassett/openscad \
					openscad \
						-o /src/shelly_{}.stl \
						-D 'part="{}"' \
						/src/shelly_mk3.scad


