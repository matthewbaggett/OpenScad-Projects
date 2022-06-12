all:
	echo -n "hub_inner hub_outer hub_roller drivegear test_frame test_frame_undriven_carrier" | \
	xargs -d ' ' --no-run-if-empty -n1 -P5 -I {} \
		docker \
			run \
				--rm \
				-v $(PWD)/../:/src \
				bbassett/openscad \
					openscad \
						-o /src/OmniBot/{}.stl \
						-D 'printablePart="{}"' \
						/src/OmniBot/wheel.scad
	$(MAKE) bell
bell:
	@printf '\a'
	@sleep 0.2
	@printf '\a'
	@sleep 0.2
	@printf '\a'
	@sleep 0.2
	@printf '\a'
