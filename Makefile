.PHONY: build all

all: anycubic_shittycam_mount

anycubic_shittycam_mount:
	echo -n "top bottom generalcam" | \
		xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/:/src \
					bbassett/openscad \
						openscad \
							-o /src/build/anycubic_shittycam_mount_{}.stl \
							-D 'part="{}"' \
							/src/anycubic_shittycam_mount.scad
