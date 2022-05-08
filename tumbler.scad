arrangeForPrint = "no"; // [yes:Yes, no:No]
// Part to print
part = "all"; // [all, left_shaft, right_shaft, center_carrier, front, side, back, oring_fit_test]
mBoltSize = 6;
mod = 5;
bottomRollerOffset = 25+50+5;
rollerGap = 70-13;

use <Lib/mattlib.scad>;
$fn=160;

module skateboard_bearing(){
    hull()bearing_608();
    cylinder(h=9,d=16, center=true);
}
module frame(){
    difference(){
        union(){
            
            // Ends
            mirrorCopy([1,0,0]){
                translate([102.5,0,25]){
                    cube([15,200,50], center=true);
                }
            }
            // Sides
            mirrorCopy([0,1,0]){
                translate([0,-92.5,25]){
                    cube([190,15,50], center=true);
                }
            }
            // Motor-end hump
            hull(){
                translate([-102.5,0,55])rotate([0,90,0])cylinder(h=15, d=20, center=true);
                translate([-102.5,84,40])rotate([0,90,0])cylinder(h=15, d=20, center=true);
                translate([-102.5,-84,40])rotate([0,90,0])cylinder(h=15, d=20, center=true);
            }
        }

        // Assembly boltholes
        union(){
            mirrorCopy([0,1,0]){
                mirrorCopy([1,0,0]){
                    translate([96,-88,40]){
                        rotate([-35,90,0]){
                            metricCapheadAndBolt(mBoltSize, 18, recessNut=20, recessCap=20, chamfer=false);
                        }
                    }
                    translate([96,-88,10]){
                        rotate([-35,90,0]){
                            metricCapheadAndBolt(mBoltSize, 18, recessNut=20, recessCap=20, chamfer=false);
                        }
                    }
                }
            }
           
        }

        // Bearing cutouts
        mirrorCopy([0,1,0]){
            translate([0,50,35]){
                mirrorCopy()
                    translate([100-3,0,0])
                        rotate([0,90,0])
                            skateboard_bearing();
            }
        }
        
        // Decorative Underside cutout
        translate([0,0,-85]){
            scale([1,1,0.8]){
                rotate([0,90,0])cylinder(h=250, d=250, center=true);
                rotate([0,90,90])cylinder(h=250, d=250, center=true);
            }
        }
        
        // Motor cutout
        translate([-100,0,35])rotate([90,0,90])nema17_cutout();
        
        // Jar lid clearance
        translate([100+2.5,0,60]){
            rotate([0,90,0]){
                scale([1,2,1]){
                    cylinder(d=50,h=20, center=true);
                }
            }
        }


    }
}


//nema14cutout();

module gear(mod=5){
    ;
                spur_gear (modul=mod, tooth_number=(50/mod), width=20, bore=0, pressure_angle=20, helix_angle=20, optimized=false);

}
    


module oring(){
    rotate_extrude(angle=360)translate([(35)/2,0])circle(d=2.5);
    //difference(){
    //    cylinder(h=2.5,d=35+1, center=true);
    //    cylinder(h=2.5+0.1,d=33, center=true);
    //}
}


module shaft_features(){
    difference(){
        union(){
            translate([0,0,100])cylinder(h=200, d=8, center=true);
            translate([0,0,100])cylinder(h=200-10-(3*2), d=30, center=true);
            translate([0,0,bottomRollerOffset+20])cylinder(h=30, d1=35,d2=0, center=true);
            translate([0,0,bottomRollerOffset])cylinder(h=10, d=35, center=true);
            translate([0,0,bottomRollerOffset-20])cylinder(h=30, d2=35,d1=0, center=true);    
            translate([0,0,bottomRollerOffset+rollerGap+20])cylinder(h=30, d1=35,d2=0, center=true);
            translate([0,0,bottomRollerOffset+rollerGap])cylinder(h=10, d=35, center=true);
            translate([0,0,bottomRollerOffset+rollerGap-20])cylinder(h=30, d2=35,d1=0, center=true);
            translate([0,0,5+4])rotate([0,0,(360/(50/mod)/2)])gear(mod);
        }
        // O-rings
        translate([0,0,bottomRollerOffset])
            #o_ring(id=32,girth=2.5);
        translate([0,0,bottomRollerOffset+rollerGap])
            #o_ring(id=32,girth=2.5);
    }
}
    
module left_shaft(){
    // Left gear
    color("lightblue")translate([0,50,0])shaft_features();
}
module right_shaft(){
    // Right gear
    color("blue")translate([0,-50,0])shaft_features();
}
module center_carrier(){
    // Center gear
    color("orange")
    difference(){
        union(){
            translate([0,0,11]){
                cylinder(h=10, d=20, center=true);        
            }    // O-rings
    translate([0,0,bottomRollerOffset])#oring();

            //mirror(){
            mirror([1,0,0]){
                translate([0,0,5+4]){
                    gear();
                }
            }
        }
        translate([0,0,0])rotate([0,0,90])nema17_cutout(true);
    }
}
module shafts(){
    translate([-35,0,0]){
        left_shaft();
        right_shaft();
        center_carrier();
    }
}

/**/

if(arrangeForPrint == "no"){
    //color("black",0.1){
    //    translate([-100,0,35])rotate([90,0,90])nema17_cutout();
    //}
    translate([-100,0,0])rotate([0,90,0])shafts();
    frame();
}else{
    translate([130,0,0]){
        if (part == "all" || part == "back") {
            translate([70,0,-95])rotate([180,90,0])difference(){
                frame();
                translate([15,0,30])cube([220,220,80], center=true);
            }
        }
        if (part == "all" || part == "front") {
            translate([0,0,-95])rotate([0,-90,0])difference(){
                frame();
                translate([-15,0,30])cube([220,220,80], center=true);
            }
        }
    }
    if (part == "all" || part == "side") {
        translate([0,0,-85])rotate([90,0,90])difference(){
            frame();
            translate([0,-25,30])cube([220+1,220,80], center=true);
            mirrorCopy([1,0,0])translate([110,90,30])cube([30,30,80], center=true);
        }
    }
    
    if (part == "all" || part == "left_shaft") {
        translate([-60,30,0])left_shaft();
    }
    if (part == "all" || part == "right_shaft") {
        translate([-60,-30,0])right_shaft();
    }
    if (part == "all" || part == "center_carrier") {
        translate([-60,0,0])center_carrier();
    }
    if(part == "oring_fit_test"){
        
        translate([-60,30,0]){
            difference(){
                left_shaft();
                #translate([0,50,80])cylinder(h=50,d=20, center=true);
                translate([0,50,-25+2])cube([90,90,200], center=true);
                translate([0,50,-25+200+10-2])cube([90,90,200], center=true);
            }
        }
    }
}/**/