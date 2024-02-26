.PHONY: build all

all: build

bake_combined_stl:
	docker \
		run \
			--rm \
			-v "$(PWD)/:/src" \
			matthewbaggett/openscad \
					-o /src/STL/combined.stl \
					/src/original_stl_combiner.scad
