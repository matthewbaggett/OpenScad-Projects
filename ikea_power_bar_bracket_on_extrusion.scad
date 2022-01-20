use <Lib/mattlib.scad>
$fn = $preview? 60 : 360;
height = 41.8;
width = 54;
taper = 5;
width_meat = 10;

module strip_end() {
    color("green", 0.5)
        translate([0, 5, (height / 2)])
            cube([width, 10 * 2, height] + [0, 0.1, 0.1], center = true);
}

module cable_cutout() {
    color("green", 0.5) {
        hull(){
            rotate([90, 90, 0])
                cylinder(h = 50, d = 15, center = true);
            translate([0,0,-5])
                rotate([90, 90, 0])
                    cylinder(h = 50, d = 15, center = true);
        }
    }
}

module body() {
    hull() {
        // bottom plate
        hull() {
            translate([0, 5 + 2.5, 0.5])
                cube([width + width_meat + taper, 25, 1], center = true);

            mirrorCopy()
            translate([((width + width_meat) - 10 + taper) / 2, - 5, 0.5])
                cylinder(h = 1, d = 10, center = true);
        }

        // top plate
        hull() {
            translate([0, 20, height + 0.5 + 3])
                cube([width + width_meat - taper, 10, 1], center = true);

            mirrorCopy()
            translate([((width + width_meat) - 10 - taper) / 2, 10, height + 0.5 + 3])
                cylinder(h = 1, d = 10, center = true);
        }
    }
    hull(){
        translate([0,0,-.5])
            hull() {
                translate([0, 5 + 2.5, 0.5])
                    cube([width + width_meat + taper, 25, 1], center = true);

                mirrorCopy()
                    translate([((width + width_meat) - 10 + taper) / 2, - 5, 0.5])
                        cylinder(h = 1, d = 10, center = true);
            }
            
        translate([0,0,-45])
            hull() {
                translate([0, 5 + 15, 0.5])
                    cube([width + width_meat + taper - 20-10, 10, 1], center = true);

                mirrorCopy()
                    translate([((width + width_meat) - 10-10 - 20 + taper) / 2, - 0, 0.5])
                        cylinder(h = 1, d = 10, center = true);
            }
    }
}

module body_subtracted(cutout = true, topText = "") {
    difference() {
        body();

        translate([0, 15, - 0.2])
            strip_end();

        if (cutout)
            translate([0, 0, 20])
                cable_cutout();

        if (topText) {
            translate([0, 12.5, height + 3.6])
                scale(0.5)
                    linear_extrude(1)
                        text(topText, valign = "center", halign = "center");
        }
        
        translate([0,0,-17])
            rotate([90,0,0])
                extrusion30x30(50, center=true);
    
        translate([0,0,4])
            rotate([0,90,0])
                rotate(90)
                    metricCapheadAndBolt(6, 20, recessCap = 50, recessNut = 50, chamfer = false);
        
        translate([0,10,-38])
            rotate([0,90,0])
                rotate(90)
                    metricCapheadAndBolt(6, 20, recessCap = 50, recessNut = 50, chamfer = false);
    }
    
}


if (part == undef || part == "20mm-extrusion-cable") {
    translate([0,30,0])
    rotate([180,90,0])
        translate([-5, 0, 0]) {
            difference() {
                body_subtracted(cutout=true, topText = "2020 ALU. EXT.");
                translate([25,5,0])cube([50,50,100], center=true);
            }
        }
    translate([0,-30,0])
    rotate([0,-90,0])
        translate([5, 0, 0]) {
            difference() {
                body_subtracted(cutout=true, topText = "2020 ALU. EXT.");
                translate([-25,5,0])cube([50,50,100], center=true);
            }
        }
}

if (part == undef || part == "20mm-extrusion-nocable") {
    translate([0,70,0])
    rotate([180,90,0])
        translate([-5, 0, 0]) {
            difference() {
                body_subtracted(cutout=false, topText = "2020 ALU. EXT.");
                translate([25,5,0])cube([50,50,100], center=true);
            }
        }
    translate([0,-70,0])
    rotate([0,-90,0])
        translate([5, 0, 0]) {
            difference() {
                body_subtracted(cutout=false, topText = "2020 ALU. EXT.");
                translate([-25,5,0])cube([50,50,100], center=true);
            }
        }
}

