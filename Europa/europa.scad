use <../Lib/mattlib.scad>;
use <itx.scad>;

spaceBetweenParts = 50;
boltMSize = 6;
boltLengthMM = 40;
$fn=64;

module europa_raw(){
    color("grey")
    difference(){
        translate([1.245,73.638,0])
            rotate(180)
                import("source_stls/europa-solid_fixed.stl");
        
        // Prune underside
        translate([0,0,-5])
            cube([300,300,10], center=true);
        
    }
}
module power_supply_cutout(){
    translate([-45,55,30.5]){
        translate([(-51/2)+(24/2)+5,(126/2)+(20/2),0]){
            cube([24,20,20], center=true);
        }
        cube([51,126,31], center=true);
    }
}
//power_supply_cutout();

module power_supply_brace(){
    translate([-45,45,(42/2)+13]){
        cube([70,20,41], center=true);
    }
}
//power_supply_brace();
module floppy_disk_support(){
    translate([(18.7/2)*-1,(30/2)+4.2,(52.5/2)+15])
        cube([18.7,30,52.5], center=true);
}

module floppy_disk_support_pruner(){
    // Floppy beam prune
    translate([(25/2)*-1,-34.7,(100/2)+15])
        cube([25,77.8,100], center=true);
        
    // Floppy nub prune
    translate([(25/2)*-1,-80,90])
        cube([25,20,40], center=true);
    
    // Screw hole prune
    translate([102-20-3.5-3.7,-75-20,80])
        cube([20,40,60]);
}

module europa(){
    render(){
        difference(){
            union(){
                europa_raw();
                bolt_filler();
                power_supply_brace();
            }
            bolt_holes();
            floppy_disk_support_pruner();
            power_supply_cutout();
        }
        
        floppy_disk_support();
    }
}

module europa_facia(){
    difference(){
        europa();
        rotate([-5,0,0])
            translate([0,150-116.873,190])
                cube([300,250,400], center=true);
    }
}

module europa_body(){
    difference(){
        europa();
        rotate([-5,0,0])
            translate([0,0-116.873,190])
                cube([300,50,400], center=true);
    }
}

module europa_body_bottom(){
    difference(){
        europa_body();
        translate([0,0,(210/2)+100])
            cube([300,300,210], center=true);
    }
}

module europa_body_middle(){
    difference(){
        europa_body();
        translate([0,0,(100/2)])
            cube([300,300,100], center=true);
        translate([0,0,(105/2)+105+100])
            cube([300,300,105], center=true);
    }
}

module europa_body_top(){
    difference(){
        europa_body();
        translate([0,0,(205/2)])
            cube([300,300,205], center=true);
    }
}

module itx_parts(){
    translate([0,-10,160]){
        rotate([-40,0,0]){
            if($preview){
                itx();
            }
            itxBackplate();
        }
    }
}

module components_output(){
    if(part==undef || part=="facia")
        europa_facia();
    if(part==undef || part=="top")
        europa_body_top();
    if(part==undef || part=="middle")
        europa_body_middle();
    if(part==undef || part=="bottom")
        europa_body_bottom();
    if(part==undef || part=="itx")
        itx_parts();
}

module bolt_holes(){
    // Body Bolts
    mirrorCopy([1,0,0]){
        
    // Top Face Bolt
    translate([-40,-62,280]){
        rotate([-5,0,0]){
            rotate([-90,90,0]){
                metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=2, recessCap=50, chamfer=false);
                translate([5+2.5,0,-22.65])cube([10,10,6.25], center=true);
            }
        }
    }
    
    // Bottom Face Bolt
    mirrorCopy([1,0,0]){
        translate([-75,-87,50]){
            rotate([-5,0,0]){
                rotate([-90,90,0]){
                    metricCapheadAndBolt(boltMSize, 20, recessNut=2, recessCap=20, chamfer=false);
                    translate([-5,0,-7.6-5])cube([10,12,6.25], center=true);
                }
            }
        }
    }
        // Rear Bolts
        translate([102,112,100]){
            // Lower Rear bolt holes
            translate([0,0,(boltLengthMM/2)-24]){
                rotate([0,180,-45]){
                    metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=12, recessCap=74+1, chamfer=true);
                }
            
                 // Finger Clearance
                 translate([0,0,54.5]){
                    cylinder(d=18,h=10*5.5, center=true);
                    rotate(180-45)translate([0,18/2,0])cube([18,18,10*5.5], center=true);
                }
            }
        
            // Upper rear bolt holes
            translate([0,0,105+(boltLengthMM/2)-24]){
                rotate([0,180,-45]){
                    metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=12, recessCap=0, chamfer=true);  
                }
                
                // Finger Clearance
                translate([0,0,37]){
                   cylinder(d=18,h=20, center=true);
                   rotate(180-45)translate([0,18/2,0])cube([18,18,20], center=true);
                }
            }
        }
        
        // Front Bolts
        translate([102,-61,100]){
            // Lower Front bolt holes
            translate([0,0,(boltLengthMM/2)-24]){
                rotate([0,180,90]){
                    metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=12, recessCap=74+1, chamfer=true);
                }
            
                // Finger Clearance
                translate([0,0,54.5]){
                    cylinder(d=18,h=10*5.5, center=true);
                    rotate(90-0)translate([0,18/2,0])cube([18,18,10*5.5], center=true);
                }
            }
        
            // Upper Front bolt holes
            translate([0,0,105+(boltLengthMM/2)-24]){
                rotate([0,180,90]){
                    metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=12, recessCap=0, chamfer=true);  
                }
                
                // Finger Clearance
                translate([0,0,37]){
                   cylinder(d=18,h=20, center=true);
                   rotate(90-0)translate([0,18/2,0])cube([18,18,20], center=true);
                }
            }
        }
    }
}


module bolt_filler(){
    // Rear Fillers
    mirrorCopy([1,0,0]){
        translate([102,112,123/2]){
            // Lower rear bolt hole filler
            translate([0,0,0.5])  cylinder(h=122, d=20, center=true);
            translate([0,5,0.5])  cube([20,10,122], center=true);
            translate([5,0,0.5])  cube([10,20,122], center=true);

            // Upper rear bolt hole filler
            translate([0,0,141.5])  cylinder(h=50, d=20, center=true);
            translate([0,5,141.5])  cube([20,10,50], center=true);
            translate([5,0,141.5])  cube([10,20,50], center=true);
        }
    }
    
    // Front Fillers
    mirrorCopy([1,0,0]){
        translate([102,-61,123/2]){
            // Lower rear bolt hole filler
            translate([0,0,0.5])  cylinder(h=122, d=20, center=true);
            translate([5,0,0.5])  cube([10,20,122], center=true);

            // Upper rear bolt hole filler
            translate([0,0,141.5])  cylinder(h=50, d=20, center=true);
            translate([5,0,141.5])  cube([10,20,50], center=true);
        }
    }
    
    // Facia Fillers
    mirrorCopy([1,0,0]){
        translate([-40,-62,280]){
            rotate([-5,0,0]){
                rotate([-90,90,0]){
                    cylinder(h=50,d=20, center=true);
                    translate([-6,0,0])cube([12,20,50], center=true);
                }
            }
        }
    }
}
//part="facia";


if(!$preview) {
    components_output();
}else{

#            europa();
    itx_parts();
    bolt_holes();
    color("green")bolt_filler();
    //floppy_disk_support();
    //floppy_disk_support_pruner();
}
