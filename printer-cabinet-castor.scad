use <Lib/mattlib.scad>
$fn = $preview? 60 : 360;

castor_xy = 38.5;
castor_hole_spacing = 25;
bottom_corner_radius = 15;


module bolt() {
    color("green") {
        translate([0, 0, - 6])
            cylinder(h = 12, d = 22, center = true);
        translate([0, 0, 10])
            cylinder(h = 20 + 0.1, d = 8.4, center = true);
    }
}
//bolt();

module mk1() {

    difference() {

        hull() {
            difference() {
                // Body
                translate([2.5, 2.5])
                    cube([45, 45, 20], center = true);

                // Curved edge
                difference() {
                    cube([42, 42, 20 + 0.1], center = true);
                    translate([20, 20, 0])cylinder(h = 20 + 0.1, r = 40, center = true);
                }
            }
            hull() {
                mirrorCopy([0, 1, 0])
                mirrorCopy([1, 0, 0])
                translate([(castor_xy - 8) / 2, (castor_xy - 8) / 2, 5 - 10])
                    cylinder(d = 8, h = 10, center = true);
            }
        }

        // Top recess
        translate([- 2.5, - 2.5, 12.5 - 2.5])
            cube([50, 50, 5], center = true);

        // Bolt hole
        translate([0, 0, - 0.1])bolt();

        // Castor bolts
        mirrorCopy([0, 1, 0])
        mirrorCopy([1, 0, 0])
        translate([25 / 2, 25 / 2, 3 - 10 - 0.2])
            rotate([0, 180, 45])
                metricCapheadAndBolt(5, 12, recessCap = 0, recessNut = 15, chamfer = false);
    }
    //translate([0,0,-0.1])bolt();
    /**/

    translate([0, 0, - 10])color("red")square(castor_xy, center = true);


}

module mk2() {
    difference() {
        hull() {
            // Top
            translate([0, 0, 20])
                difference() {
                    translate([20, 20, 0])
                        cylinder(h = 1.0, d = 87, center = true);

                    mirrorCopy([1, - 1, 0])translate([20, 20 + 40, 0])
                        cube([87, 87, 1.1], center = true);

                    translate([- 5, - 5, 0]) {
                        difference() {
                            translate([15, 15, 0,])cube([30, 30, 1.1], center = true);
                            difference() {
                                cylinder(h = 1.2, d = 50, center = true);
                                rotate(180)
                                    mirrorCopy([1, - 1, 0])
                                    translate([12.5, 0, 0])
                                        cube([25, 50, 1.3], center = true);
                            }
                        }
                    }
                }

            // Bottom
            hull() {
                mirrorCopy([0, 1, 0])
                mirrorCopy([1, 0, 0])
                translate([(40 - bottom_corner_radius) / 2, (40 - bottom_corner_radius) / 2, 0])
                    cylinder(h = 1, d = bottom_corner_radius);
            }
        }


        translate([0, 0, 20.1])
            scale([1, 1, 4])
                difference() {
                    translate([20, 20, 0])
                        cylinder(h = 1.0, d = 84, center = true);

                    mirrorCopy([1, - 1, 0])translate([20, 20 + 40, 0])
                        cube([84, 84, 1.1], center = true);
                }


        // Bolt hole
        translate([0, 0, 12 - 0.01])bolt();

        // Castor holes
        mirrorCopy([0, 1, 0])
        mirrorCopy([1, 0, 0])
        translate([25 / 2, 25 / 2, 2.8])
            rotate([0, 180, - 45])
                metricCapheadAndBolt(5, 12, recessCap = 0, recessNut = 15, chamfer = false);
    }
}

mk2();