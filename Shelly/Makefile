
.PHONY: build all

all: shelly

shelly: shelly_capside shelly_nutside

shelly_capside:
	docker run --rm \
		-v $(PWD)/..:/src \
			bbassett/openscad \
				openscad \
					-o /src/Shelly/shelly_capside.stl \
					-D 'part="capside"' \
					/src/Shelly/shelly_mk3.scad

shelly_nutside:
	docker run --rm \
		-v $(PWD)/..:/src \
			bbassett/openscad \
				openscad \
					-o /src/Shelly/shelly_nutside.stl \
					-D 'part="nutside"' \
					/src/Shelly/shelly_mk3.scad
