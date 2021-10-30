
.PHONY: build all

all:

shellie_benchmark:
	time \
		docker run --rm \
			-v $(PWD):/src \
				bbassett/openscad \
					openscad \
						-o /src/shelly.stl \
						-D 'startPi=4.75' \
						-D 'endPi=5' \
						/src/shelly_mk3.scad


