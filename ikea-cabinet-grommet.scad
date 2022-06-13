use <Lib/mattlib.scad>;
$fn=$preview?30:360;



module holeSawGrommet(diameter = 35, thickness=16){
    module part(){
        difference(){
            union(){
                translate([0,0,thickness/-2])
                    cylinder(h=thickness,d=diameter);
                mirrorCopy([0,0,1])
                    translate([0,0,(thickness/-2)-3])
                        cylinder(h=3,d=diameter+10);
            }
            cylinder(h=thickness+(3*2)+0.1, d=diameter-6, center=true);
        }
    }

    module splitter(){
        translate([0,0,(thickness/-2)-1.5])
            cylinder(h=3+0.01,d=diameter+10+1, center=true);
        cylinder(h=thickness+(3*2)+0.2, d=diameter-3, center=true);
    }
    translate([0,0,thickness/2+3]){
        translate([-diameter*.7,0,0])rotate([0,180,0]){
            difference(){
                part();
                splitter();
            }
        }
        translate([diameter*.7,0,0]){
            intersection(){
                part();
                splitter();
            }
        }
}
}


holeSawGrommet(diameter=35, thickness=16);
translate([0,44+6,0])holeSawGrommet(diameter=44, thickness=16);