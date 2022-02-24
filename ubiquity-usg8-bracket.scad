use <Lib/mattlib.scad>
$fn=60;

// Actual dimensions + Printer Fudge Factor.
unifi_usg8 = [148.2,100,30.6] + [1,0,0];
unifi_48v_brick = [47.1,100,32] + [1,0,0];

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


/**/
module part(size){
    difference(){
        hull(){
            mirrorCopy(){
                translate([(size.x/2)+5-2.5,0,((size.z/2)*-1)+.5])cube([5,30,1], center=true);
                mirrorCopy([0,1,0]){
                    translate([(size.x/2)+5+2.5,10+2.5,((size.z/2)*-1)+.5]){
                        cylinder(h=1, d=8, center=true);
                    }
                }

                translate([(size.x/2)+5,0,(size.z/2)+2.5]){
                    rotate([90,0,0]){
                        cylinder(h=15,d=5, center=true);
                    }
                }
            }
        }
        translate([0,0,-0.5]){
            cube(size+[0,0,1], center=true);
        }
        mirrorCopy(){
            translate([(size.x/2)+5,0,-8]){
                screw();
            }
        }
    }
}

if($preview){
    part(unifi_usg8);
    translate([0,50,0]){
        part(unifi_48v_brick);
    }
}else{
    // Part prints beautifully upside down.
    rotate([180,0,0]){
        part(unifi_usg8);
        translate([0,50,0]){
            part(unifi_48v_brick);
        }
        translate([0,-50,0]){
            part(unifi_48v_brick);
        }
    }
}