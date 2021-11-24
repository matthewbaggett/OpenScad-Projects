use <../Lib/mattlib.scad>

module cushion() {
    color("lightgreen")
        hull()
            mirrorCopy()
            translate([10, 0, 4 + 0.01])
                cylinder(h = 2, d = 60, center = true);
}

module squab() {
    color("green")
        difference() {
            hull()
                mirrorCopy()
                translate([10, 0, 0])
                    cylinder(h = 10, d = 80, center = true);
            cushion();
        }
}

squab();
cushion();

translate([0, 50, 0]) {
    // Chair back
    rotate([-10,0,0]){
        color("green"){
            hull(){
                translate([0, 0, 80])
                    scale([2,1,1])
                        rotate([90, 0, 0])
                            cylinder(h = 5, d = 30, center = true);
                translate([0, -50, -0])
                    difference(){
                        squab();
                        translate([0,-10,0])
                            cube([100,60,20], center=true);
                    }
            }
            mirrorCopy()
            hull() {

                translate([40, 0, 90])
                    rotate([90, 0, 0])
                        cylinder(h = 5, d = 30, center = true);
                translate([0, -50, -0])
                    difference(){
                        squab();
                        translate([0,-10,0])
                            cube([100,60,20], center=true);
                    }
            }
        }
        // Eyes
        color("darkblue")
            mirrorCopy()
            translate([40, 0, 90])
                rotate([90, 0, 0])
                    cylinder(h = 5, d = 15, center = true);
        // Nostrils
        color("darkgreen")
            mirrorCopy()
            translate([8, 0, 90 - 10])
                rotate([90, 0, 0])
                    cylinder(h = 5, d = 5, center = true);

        // Mouth
        translate([0, 0, 90 - 19])
            color("red")
                scale([8, 1, 2])
                    render()
                        difference() {
                            rotate([90, 0, 0])
                                cylinder(h = 5, d = 10, center = true);
                            translate([0, 0, 5])
                                cube([10, 10, 11], center = true);
                        }
    }
}
