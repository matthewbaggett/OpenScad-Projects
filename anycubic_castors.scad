use <Lib/mattlib.scad>
$fn=$preview?30:360;

height=60;
castor_xy = 38.5;
castor_hole_spacing = 25;
top_corner_radius = 7.5;
bottom_corner_radius = 15;


module extrusion_element(){
    // Extrusion cutout
    rotate([90,0,0])
        extrusion20x20(45, center=true);
}

module bracket(){
    difference(){
        hull(){
            // Top deck
            translate([0,0,30]){
                //hull() {
                    mirrorCopy([0, 1, 0])
                    mirrorCopy([1, 0, 0])
                    translate([(25 - top_corner_radius) / 2, (25 - top_corner_radius) / 2, -5-(top_corner_radius/2)])
                        sphere(d=top_corner_radius);
                //}
            }

            // Middle deck
            translate([0,0,-7.5]){
                //hull() {
                    mirrorCopy([0, 1, 0])
                    mirrorCopy([1, 0, 0])
                        translate([(35 - bottom_corner_radius) / 2, (45 - bottom_corner_radius) / 2, 0])
                            sphere(d=bottom_corner_radius);
                //}
            }

            // Bottom deck
            translate([0,0,-60]){
                //hull() {
                    mirrorCopy([0, 1, 0])
                    mirrorCopy([1, 0, 0])
                    translate([(40 - bottom_corner_radius) / 2, (40 - bottom_corner_radius) / 2, 0])
                        cylinder(h = 1, d = bottom_corner_radius);
                //}
            }
        }

        // Castor bolts
        mirrorCopy([0, 1, 0])mirrorCopy([1, 0, 0])
            translate([25 / 2, 25 / 2, -60+2.5])
                rotate([0, 180, 0])
                    metricCapheadAndBolt(5, 12, recessCap = 0, recessNut = 38, chamfer = false);

        // Extrusion piece
        extrusion_element();
        
        // Internal finger holes
        mirrorCopy([0, 1, 0])
            hull()
                mirrorCopy([1, 0, 0])
                    translate([25/2,25/2,-25-9])
                        cylinder(h=25,d=10);
        
        // Top bolt
        translate([0,0,16])
            rotate([0,90,0])
                rotate(90)
                    metricCapheadAndBolt(6, 20, recessCap = 20, recessNut = 20, chamfer = false);
                
        // Bottom bolt
        translate([0,0,-45])
            rotate([0,90,0])
                rotate(90)
                    metricCapheadAndBolt(6, 20, recessCap = 20, recessNut = 20, chamfer = false);
    }
}



if($preview){
    extrusion_element();
    bracket();
}else{
    if (part == undef || part == "left") {
        rotate([0,90,0])
            translate([0,60,0])
                difference(){
                    bracket();
                    #translate([25,0,0])cube([50,200,300], center=true);
                }
    }
    
    if (part == undef || part == "right") {
        rotate([180,-90,0])
            translate([0,60,0])
                difference(){
                    bracket();
                    translate([-25,0,0])cube([50,200,300], center=true);
                }
    }
}