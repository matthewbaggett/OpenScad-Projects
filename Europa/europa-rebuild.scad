use <../Lib/mattlib.scad>;

spaceBetweenParts = 50;
boltMSize = 6;
boltLengthMM = 40;
$fn=64;

module europa_raw(){
    color("grey")
    difference(){
        translate([1.245,73.638,0])
            rotate(180)
                import("europa-solid_fixed.stl");
        translate([0,0,-5])
            cube([300,300,10], center=true);
    }
}

module europa(halved=false){
    difference(){
        union(){
            europa_raw();
            bolt_filler();
        }
        bolt_holes();
        if(halved){
                translate([150,0,200])cube([300,300,400], center=true);
        }
    }
}

module europa_facia(halved=false){
    color("salmon")
    translate([0,spaceBetweenParts*-1,0])
    difference(){
        europa(halved=halved);
        rotate([-5,0,0])
        translate([0,150-116.873,190])
        cube([300,250,400], center=true);
    }
}

module europa_body(halved=false){
    difference(){
        europa(halved=halved);
        rotate([-5,0,0])
        translate([0,0-116.873,190])
        cube([300,50,400], center=true);
    }
}

module europa_body_bottom(halved=false){
    color("red")
    difference(){
        europa_body(halved=halved);
        translate([0,0,(210/2)+100])
            cube([300,300,210], center=true);
    }
}

module europa_body_middle(halved=false){
    color("green")
    translate([0,spaceBetweenParts,spaceBetweenParts])
    difference(){
        europa_body(halved=halved);
        translate([0,0,(100/2)])
            cube([300,300,100], center=true);
        translate([0,0,(105/2)+105+100])
            cube([300,300,105], center=true);
    }
}

module europa_body_top(halved=false){
    color("blue")
    translate([0,spaceBetweenParts*2,spaceBetweenParts*2])
    difference(){
        europa_body(halved=halved);
        translate([0,0,(205/2)])
            cube([300,300,205], center=true);
    }
}

module components_output(halfed=false){
    

    europa_facia(halved=halved);
    europa_body_top(halved=halved);
    europa_body_middle(halved=halved);
    europa_body_bottom(halved=halved);
}

module bolt_holes(){
    mirrorCopy([1,0,0]){
        // Rear Bolts
        translate([100,110,100]){
            // Lower Rear bolt holes
            translate([0,0,(boltLengthMM/2)-24]){
                rotate([0,180,0]){
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
                rotate([0,180,0]){
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
        translate([100,-65,100]){
            // Lower Front bolt holes
            translate([0,0,(boltLengthMM/2)-24]){
                rotate([0,180,0]){
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
                rotate([0,180,0]){
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
        translate([100,110,123/2]){
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
}
    
if(!$preview){
    difference(){
        components_output(halfed=true);
    }
}else{
    #europa();
    bolt_holes();
    //color("green")bolt_filler();
}
