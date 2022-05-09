.PHONY: build all

all: build

build:
	echo -n "facia top_front top_rear bottom_front bottom_rear screen_retainer_bracket duct" | \
		xargs -d ' ' --no-run-if-empty -n1 -P6 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/../:/src \
					matthewbaggett/openscad \
							-o /src/Europa/{}.stl \
							-D 'renderPrintablePart="{}"' \
							-D 'rotateForPrint="yes"' \
							/src/Europa/rebuilt_europa.scad
