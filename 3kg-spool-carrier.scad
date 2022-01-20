use <Lib/mattlib.scad>
$fn=$preview?60:180;
rollerHeight=140;
footThickness=17;
footLength=75;
gussetSize = 20;
/*
module filleted_cylinder(
    cylinder_height=2,
    cylinder_radius=1,
    fillet_radius_bottom=1,
    fillet_radius_top=0,
    nfaces=50
)*/
module mainPlasticBody(){
    difference(){
        union(){
            // Pillar
            hull(){
                translate([-25+0.5,0,(52/2)+rollerHeight+20-5])
                    rotate([0,90,0])
                        cylinder(d=52, h=1, center=true);
                translate([0-0.5,0,(52/2)+rollerHeight+20-5])
                    rotate([0,90,0])
                        cylinder(d=52, h=1, center=true);
                translate([-(25/2),0,0.5])
                    cube([25,52,1], center=true);
            }
            
            
            
            // Roller
            translate([0,0,(52/2)+rollerHeight-5]){
                // Filleted base
                    rotate([0,90,0])
                        filleted_cylinder(cylinder_height=1, cylinder_radius=48/2,fillet_radius_bottom=2, nfaces=$preview?60:180);
                // Main roller body
                hull(){
                    translate([1,0,0])
                        rotate([0,90,0])
                            cylinder(d=48, h=1, center=true);
                    translate([105+1,0,(100/105)*5+15])
                        rotate([0,90,0])
                            cylinder(d=20, h=1, center=true);
                }
                
                // Retaining tip
                hull(){
                    translate([107,0,(100/105)*5+15])
                        rotate([0,90,0])
                            cylinder(d=20, h=3, center=true);
                    translate([107,0,(100/105)*5+15+2])
                        rotate([0,90,0])
                            cylinder(d=20, h=3, center=true);
                    translate([107-3,0,(100/105)*5+15])
                        rotate([0,90,0])
                            cylinder(d=20, h=3, center=true);
                }
            }
            
            // Foot
            hull(){
                translate([(footLength/2)-(52/2),0,footThickness/2])
                    cube([105-52,52,footThickness], center=true);
                translate([footLength-(52/2),0,footThickness/2])
                    cylinder(h=footThickness,d=52, center=true);
            }
        }
    
//        translate([(-10/2)-25,0,((rollerHeight+80)/2)-1])
//            cube([20,100,rollerHeight+80], center=true);
    }
    gusset();
}



module reel(){
    color("salmon", 0.3){
        translate([(102/2)+1.5,0,rollerHeight+22.5]){
            rotate([0,-2.5,0]){
                difference(){
                    rotate([0,90,0])    
                        cylinder(d=52+(108*2)+5, h=102, center=true);
                    rotate([0,90,0])    
                        cylinder(d=52, h=102+1, center=true);
                }
            }
        }
    }
}

module bolt(){
    translate([0,0,5+0.05])cylinder(h=10+0.1,d=4.4, center=true);
    translate([0,0,5+20])cylinder(h=30,d=9.8, center=true);
}
module bolts(){
    translate([40,10,0]){
        mirrorCopy([0,1,0]){
            translate([0,10,-3]){
                bolt();
            }
        }
    }
    
}

module gusset(){
    
    translate([gussetSize,0,footThickness+gussetSize])
    difference(){
        translate([-gussetSize/2,0,-gussetSize/2])cube([gussetSize,52,gussetSize], center=true);
        rotate([90,0,0])cylinder(d=gussetSize*2, h=52+1, center=true);
    }
}
module part(){
    difference(){
        mainPlasticBody();
        reel();
        bolts();
    }
}

if($preview){
    part();
    reel();
}else{
    translate([0,0,25])rotate([0,-90,0])part();
}
