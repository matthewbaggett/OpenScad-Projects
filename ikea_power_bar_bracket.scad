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

module screw() {
    recessHeight = 60;
    headDia = 8;
    headHeight = 4;
    shaftDia = 5;
    shaftLength = 15;

    color("green", 0.5) {
        // Shaft
        translate([0, 0, (shaftLength / 2) * - 1])
            cylinder(h = shaftLength, d = shaftDia, center = true);
        // Cap
        translate([0, 0, 2])
            cylinder(h = headHeight + 0.01, d2 = headDia, d1 = shaftDia, center = true);
        // Recess hole
        translate([0, 0, recessHeight / 2 + headHeight])
            cylinder(h = recessHeight, d = headDia, center = true);
    }
}

module cable_cutout() {
    color("green", 0.5) {
        hull(){
            rotate([90, 90, 0])
                cylinder(h = 50, d = 15, center = true);
            translate([0,0,-20])
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
}

module body_subtracted(cutout = true, topText = "") {
    difference() {
        body();

        translate([0, 15, - 0.2])
            strip_end();

        if (cutout)
            translate([0, 0, 20])
                cable_cutout();

        mirrorCopy()
        translate([20, 0, 5])
            screw();

        if (topText) {
            translate([0, 12.5, height + 3.6])
                scale(0.5)
                    linear_extrude(1)
                        text(topText, valign = "center", halign = "center");
        }
    }
}

//screw();

/**/
// For woodscrews
if (part == undef || part == "screws-cable") {
    translate([75, 0, 0]) {
        difference() {
            body_subtracted(topText = "WOOD SCREWS");

            mirrorCopy()
                translate([20, 0, 8])
                    screw();
        }
    }
}
if (part == undef || part == "screws-nocable") {
    translate([75, 60, 0])rotate($preview?180:0) {
        difference() {
            body_subtracted(cutout = false, topText = "WOOD SCREWS");

            mirrorCopy()
                translate([20, 0, 8])
                    screw();
        }
    }
}

// For M5 bolts
if (part == undef || part == "m5-cable") {
    translate([0, 0, 0]) {
        difference() {
            body_subtracted(topText = "M5 CAP HEAD");

            mirrorCopy()
                translate([20, - 1, 0])
                    metricCapheadAndBolt(6, 20, recessCap = 50, chamfer = false);
        }
    }
}
if (part == undef || part == "m5-nocable") {
    translate([0, 60, 0])rotate($preview?180:0) {
        difference() {
            body_subtracted(cutout = false, topText = "M5 CAP HEAD");

            mirrorCopy()
                translate([20, - 1, 0])
                    metricCapheadAndBolt(6, 20, recessCap = 50, chamfer = false);
        }
    }
}
/**/