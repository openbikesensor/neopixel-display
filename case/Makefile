OPENSCAD=/usr/bin/openscad
OPENSCAD_OPTIONS=-q

all: stls/8x32_neopixel_diffusor_small.stl stls/8x32_neopixel_diffusor.stl

stls/8x32_neopixel_diffusor_small.stl: 8x32_neopixel_diffusor.scad
	mkdir -p stls
	$(OPENSCAD) 8x32_neopixel_diffusor.scad -D small_printbed=true -q -o $@

stls/8x32_neopixel_diffusor.stl: 8x32_neopixel_diffusor.scad
	mkdir -p stls
	$(OPENSCAD) 8x32_neopixel_diffusor.scad -D small_printbed=false -q -o $@

