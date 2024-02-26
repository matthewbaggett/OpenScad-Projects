show_spacer = true;
show_arm = false;
vesa_spacing_mm = 100;
vesa_hole_mm = 4.5;
vesa_hole_shoulders_mm = 30;
spacer_thickness_mm = 40;
microphone_hole_dia_mm = 16.25;
$fn = $preview?30:120;
use <Lib/mirrorcopy.scad>;
use <Lib/metric_bolts.scad>;

arm_offset=((vesa_spacing_mm-25)/2)-5;

module screwHoles(){
    mirrorCopy([1,0,0],[0,1,0])
        translate([vesa_spacing_mm/2, vesa_spacing_mm/2,0])
            cylinder(d=vesa_hole_mm, h=spacer_thickness_mm+1, center=true);
}

module vesaMountBody(){
    hull(){
        mirrorCopy([1,0,0],[0,1,0])
            translate([vesa_spacing_mm/2, vesa_spacing_mm/2,0])
                cylinder(d=vesa_hole_shoulders_mm*.6,h=0.001, center=true);
        mirrorCopy([1,0,0],[0,1,0])
            translate([vesa_spacing_mm/2, vesa_spacing_mm/2,spacer_thickness_mm/2])
                cylinder(d=vesa_hole_shoulders_mm,h=0.001, center=true);
    }
}
module vesaMountBodyCutouts(){
    mirrorCopy([1,0,0],[1,1,0]){
        union(){
           hull(){
                translate([((vesa_spacing_mm+vesa_hole_shoulders_mm)/2)-2,0,(spacer_thickness_mm/4)+0]){
                    rotate([0,17,0]){     
                        scale([0.3,((vesa_spacing_mm)/vesa_hole_shoulders_mm),1.2]){
                            cylinder(d=vesa_hole_shoulders_mm,h=spacer_thickness_mm/2+1, center=true);
                        }
                    }
                }
            }
        }
    }
}/**/


module vesaMountCavityCutouts(){
    difference(){
        mirrorCopy([1,1,0],[1,-1,0]){
            hull(){
                translate([0,vesa_hole_shoulders_mm/3,0]){
                    cylinder(h=spacer_thickness_mm+1, d=vesa_hole_shoulders_mm/4, center=true);
                }
                mirrorCopy([1,0,0])
                translate([(vesa_spacing_mm-vesa_hole_shoulders_mm)/2,(vesa_spacing_mm-(vesa_hole_shoulders_mm/4))/2,0]){
                    cylinder(h=spacer_thickness_mm+1, d=vesa_hole_shoulders_mm/4, center=true);
                }
            }
        }
        union(){
            hull(){
                mirrorCopy([1,0,0])
                    translate([20,vesa_spacing_mm/2+3,0])
                        cylinder(d=10,h=spacer_thickness_mm+2, center=true);
                translate([0,vesa_spacing_mm/2-18,0])
                    cylinder(d=10,h=spacer_thickness_mm+2, center=true);
            }
            hull(){
                translate([0,vesa_spacing_mm/2-18,0])
                    cylinder(d=10,h=spacer_thickness_mm+2, center=true);
                translate([0,0,0])
                    cylinder(d=10,h=spacer_thickness_mm+2, center=true);
            }
        }
    }
}

module bolt(){
    translate([0,25/2,+1.5])
    metricCapheadAndBolt(5, 30, recessNut=10, recessCap=10, chamfer=true);
}
    
module arm(bolt_positive){
    difference(){
        union(){
            hull(){
                translate([0,2,0])rotate([90,0,0])cylinder(h=0.001,d=15, center=true);
                translate([0,25,0])rotate([90,0,0])scale([1,1.15,1])cylinder(h=0.001,d=25, center=true);
            }
            hull(){
                translate([0,25,0])rotate([90,0,0])scale([1,1.15,1])cylinder(h=0.001,d=25, center=true);
                translate([0,25+30/2,0])sphere(d=28);
            }
            hull(){
                translate([0,25+30/2,0])sphere(d=28);
                //translate([-60,130,15])rotate([90,0,0])cylinder(d=30,h=0.001,center=true);
                translate([-60,130,15])sphere(d=35);
            }
            if(bolt_positive)bolt();
        }
        union(){
            if(!bolt_positive){
                bolt();
            
                translate([0,2.5,0]){
                    cube([50,1.01,50], center=true);
                }
            }
            translate([-60,130,15])
            rotate([-90+45,0,0])
            cylinder(h=20,d=microphone_hole_dia_mm, center=false);
        }
    }
}


if(show_arm){
    translate([0,arm_offset+40,0]){
        arm(bolt_positive=false);
    }
}

if(show_spacer){
    mirrorCopy([0,1,0],[1,1,0])difference(){
        mirrorCopy([0,0,1])difference(){
            vesaMountBody();
            vesaMountBodyCutouts();
        }    
        union(){
            screwHoles();
            
            vesaMountCavityCutouts();
            translate([0,arm_offset,0]){
                arm(bolt_positive=true);
            }
        }
        mirrorCopy([1,0,0]){
            rotate([0,0,-45])translate([0,200/-2,100/-2])cube([200,200,100]);
        }
    }
}
