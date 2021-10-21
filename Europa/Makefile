.PHONY: build all

all: build

build:
	echo -n "facia top middle bottom" | \
		xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/../:/src \
					bbassett/openscad \
						openscad \
							-o /src/Europa/build/{}.stl \
							-D 'part="{}"' \
							/src/Europa/europa.scad
