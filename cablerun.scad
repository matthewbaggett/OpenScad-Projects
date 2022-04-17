use <Lib/mattlib.scad>
$fn=180; 
zipWidth = 6;
zipHeight = 2;
bevel  = 5;
bodySize = [15,22,5];

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
module strap_cutouts(){
    mirrorCopy([0,1,0]){
        translate([0,6,1-0.001]){
            hull(){
                mirrorCopy([0,1,0]){
                    translate([0,(zipWidth/2)-1,0]){
                        rotate([0,90,0]){
                            cylinder(h=22,d=zipHeight, center=true);
                        }
                    }
                }
                translate([0,0,zipHeight/-4]){
                    cube([22,zipWidth,1], center=true);
                }
            }
        }
    }
}

module strap_body(){
    hull(){
        mirrorCopy([0,1,0]){
            mirrorCopy([1,0,0]){
                
                translate([(bodySize.x/2)-(bevel/2),(bodySize.y/2)-(bevel/2),0]){
                    translate([0,0,bodySize.z-(bevel/2)]){
                        sphere(d=bevel);
                    }
                    translate([0,0,0.5]){
                        cylinder(h=1,d=bevel, center=true);
                    }
                }
            }
        }
    }
}
difference(){
    strap_body();
    strap_cutouts();
    screw();
}