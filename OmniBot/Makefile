all:
	echo -n "hub drivegear" | \
	xargs -d ' ' --no-run-if-empty -n1 -P2 -I {} \
		docker \
			run \
				--rm \
				-v $(PWD)/../:/src \
				bbassett/openscad \
					openscad \
						-o /src/OmniBot/{}.stl \
						-D 'printablePart="{}"' \
						/src/OmniBot/wheel.scad