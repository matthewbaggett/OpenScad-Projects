all:
	echo -n "body lamp" | \
	xargs -d ' ' --no-run-if-empty -P2 -I {} \
		docker \
			run \
				--rm \
				-v $(PWD)/../:/src \
				bbassett/openscad \
					openscad \
						-o /src/LowPolyGlowDog/{}.stl \
						-D 'printablePart="{}"' \
						/src/LowPolyGlowDog/low-poly-glow-dog.scad
	$(MAKE) bell
bell:
	@printf '\a'
	@sleep 0.2
	@printf '\a'
	@sleep 0.2
	@printf '\a'
	@sleep 0.2
	@printf '\a'
