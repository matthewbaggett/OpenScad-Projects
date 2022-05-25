.PHONY: build all

all: build

build:
	echo -n "facia top_front top_rear bottom_front bottom_rear duct rear_combined front_combined" | \
		xargs -d ' ' --no-run-if-empty -n1 -P1 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/../:/src \
					matthewbaggett/openscad \
							-o /src/Europa/Ganymede_{}.stl \
							-D 'renderPrintablePart="{}"' \
							-D 'rotateForPrint="yes"' \
							/src/Europa/Ganymede.scad
