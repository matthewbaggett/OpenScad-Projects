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

ikea_power_bar_bracket:
	echo -n "m5-nocable m5-cable screws-nocable screws-cable" | \
		xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/:/src \
					bbassett/openscad \
						openscad \
							-o /src/ikea_power_bar_bracket_{}.stl \
							-D 'part="{}"' \
							/src/ikea_power_bar_bracket.scad

m93p_bracket:
	echo -n "left right" | \
		xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/:/src \
					bbassett/openscad \
						openscad \
							-o /src/m93p_bracket_{}.stl \
							-D 'part="{}"' \
							/src/m93p_bracket.scad

lenovo_45w_bracket:
	echo -n "left right" | \
		xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/:/src \
					bbassett/openscad \
						openscad \
							-o /src/lenovo-45w-bracket_{}.stl \
							-D 'part="{}"' \
							/src/lenovo-45w-bracket.scad

anycubic_castor:
	echo -n "left right" | \
		xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
			docker \
				run \
					--rm \
					-v $(PWD)/:/src \
					bbassett/openscad \
						openscad \
							-o /src/anycubic_castors_{}.stl \
							-D 'part="{}"' \
							/src/anycubic_castors.scad