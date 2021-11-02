
.PHONY: build all

all: shelly

shelly: shelly_capside shelly_nutside

shelly_capside:
	docker run \
		--name=shelly_cap_side \
		--rm \
		-v $(PWD)/..:/src \
			matthewbaggett/openscad \
				-o /src/Shelly/shelly_$(shell date +%Y%m%d_%H%M%S)_cap_side.stl \
				-D 'part="cap_side"' \
				/src/Shelly/shelly_mk4.scad

shelly_nutside:
	docker run \
		--name=shelly_nut_side \
		--rm \
		-v $(PWD)/..:/src \
			matthewbaggett/openscad \
				-o /src/Shelly/shelly_$(shell date +%Y%m%d_%H%M%S)_nut_side.stl \
				-D 'part="nut_side"' \
				/src/Shelly/shelly_mk4.scad
