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

module europa(){
    difference(){
        union(){
            europa_raw();
            bolt_filler();
        }
        bolt_holes();
    }
}

module europa_facia(){
    color("salmon")
    translate([0,spaceBetweenParts*-1,0])
    difference(){
        europa();
        rotate([-5,0,0])
        translate([0,150-116.873,190])
        cube([300,250,400], center=true);
    }
}

module europa_body(){
    translate([0,0,0])
    difference(){
        europa();
        rotate([-5,0,0])
        translate([0,0-116.873,190])
        cube([300,50,400], center=true);
    }
}

module europa_body_bottom(){
    color("red")
    translate([0,0,0])
    difference(){
        europa_body();
        translate([0,0,(210/2)+100])
            cube([300,300,210], center=true);
    }
}

module europa_body_middle(){
    color("green")
    translate([0,spaceBetweenParts,spaceBetweenParts])
    difference(){
        europa_body();
        translate([0,0,(100/2)])
            cube([300,300,100], center=true);
       translate([0,0,(105/2)+105+100])
            cube([300,300,105], center=true);
    }
}

module europa_body_top(){
    color("blue")
    translate([0,spaceBetweenParts*2,spaceBetweenParts*2])
    difference(){
        europa_body();
        translate([0,0,(205/2)])
            cube([300,300,205], center=true);
    }
}

module components_output(){
        europa_facia();
        europa_body_top();
        europa_body_middle();
        europa_body_bottom();
    }


module bolt_holes(){
    // Lower Rear bolt holes
    mirrorCopy([1,0,0])
    translate([100,110,100+(boltLengthMM/2)])
    union(){
        translate([0,0,-24])
        rotate([0,180,0])
            metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=12, recessCap=74+1, chamfer=true);
        
         // Finger Clearance
         translate([0,0,28+2.5])
         scale([1,1,5.5])
         union(){
            cylinder(d=18,h=10, center=true);
            rotate(180-45)
                translate([0,18/2,0])
                cube([18,18,10], center=true);
         }
    }
    
    // Upper rear bolt holes
    mirrorCopy([1,0,0])
    translate([100,110,205+(boltLengthMM/2)])
    union(){
        translate([0,0,-24])
        rotate([0,180,0])
            metricCapheadAndBolt(boltMSize, boltLengthMM, recessNut=12, recessCap=0, chamfer=true);   
        
        // Finger Clearance
        translate([0,0,13])
        scale([1,1,2])
        union(){
           cylinder(d=18,h=10, center=true);
           rotate(180-45)
               translate([0,18/2,0])
               cube([18,18,10], center=true);
        }
    }
}


module bolt_filler(){
    // Lower rear bolt hole filler
    mirrorCopy([1,0,0])
    translate([100,110,123/2])
    union(){
        translate([0,0,0])
            cylinder(h=123,d=20, center=true);
        translate([0,5,0])
            cube([20,10,123], center=true);
        translate([5,0,0])
            cube([10,20,123], center=true);
    }
    
    // Upper rear bolt hole filler
    mirrorCopy([1,0,0])
    translate([100,110,123/2])
    union(){
        translate([0,0,141.5])
            cylinder(h=50,d=20, center=true);
        translate([0,5,141.5])
            cube([20,10,50], center=true);
        translate([5,0,141.5])
            cube([10,20,50], center=true);
    }
    

}
    
if(!$preview){
    components_output();
}else{
    #europa();
    bolt_holes();
    color("green")bolt_filler();

}
