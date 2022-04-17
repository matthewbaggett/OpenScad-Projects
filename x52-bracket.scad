use <Lib/mattlib.scad>
$fn=180; 
baseThick=35;
dowelHeight = 8.5;
downwardsOffset = 100;

bracketTranslation =[55,215,110-3];

module drop_plastic(){
    translate([0,170/2+baseThick/2+baseThick*2,downwardsOffset-baseThick+20]){
        cube([170,baseThick,downwardsOffset-baseThick], center=true);
    }
}
module drop_holes(){
    holes();
        mirrorCopy()translate(bracketTranslation)bracket_holes();
}
module drop(){
    difference(){
        drop_plastic();
        drop_holes();
    }
}
module plastic(){
    // Pedestal
    cube([170,170,baseThick], center=true);

    // Extension away from desk edge
    translate([0,170/2+70/2,0]){
        cube([170,70,baseThick], center=true);
    }

    // Downwards extension piece
    translate([0,170/2+baseThick/2+baseThick*2,baseThick/2]){
        cube([170,baseThick,baseThick*2], center=true);
    }

    // Giant Gusset
    difference(){
        translate([0,170/2+baseThick/2+baseThick,baseThick])
            cube([170,baseThick,baseThick], center=true);
        translate([0,170/2+baseThick,baseThick*1.5])
            rotate([0,90,0])
                cylinder(h=170+1,d=baseThick*2, center=true);
    }
    // dowels
    translate([96/2,136/2,baseThick/2+dowelHeight/2])cylinder(d=10, h=dowelHeight, center=true);
    translate([96/-2,136/2,baseThick/2+dowelHeight/2])cylinder(d=10, h=dowelHeight, center=true);
    translate([96/2,136/-2,baseThick/2+dowelHeight/2])cylinder(d=10, h=dowelHeight, center=true);
}
module holes(){
    
    // Center USB hole
    translate([0,160,0+baseThick/2+22]){
        rotate([90,0,0]){
            cylinder(h=baseThick*2, d=20, center=true);
        }
    }
    // Side holes
    mirrorCopy(){
        translate([-40,160,0+baseThick/2+22])
            rotate([90,0,0])cylinder(h=baseThick*2, d=20, center=true);
    }   
 
    // Drop bolts
    mirrorCopy(){
        translate([0,170/2+baseThick/2+baseThick*2,downwardsOffset/2]){
            translate([70,0,0]){
                rotate([0,0,90]){
                    metricCapheadAndBolt(6, 40, recessCap = 50, recessNut=50, chamfer = true);
                }
            }
        }
    }
    
    
    // Plastic minimising cutouts
    hull(){
        mirrorCopy(){
            translate([50,115,(baseThick/-2)-1])
                cylinder(h=baseThick+2, d=10);
            translate([50,85,(baseThick/-2)-1])
                cylinder(h=baseThick+2, d=10);
        }
    }
    hull(){
        mirrorCopy(){
            translate([50,50,(baseThick/-2)-1])
                cylinder(h=baseThick+2, d=10);
            translate([50,-50,(baseThick/-2)-1])
                cylinder(h=baseThick+2, d=10);
        }
    }
    /**/
    
}
module cradle(){
    difference(){
        plastic();
        holes();
        mirrorCopy()translate(bracketTranslation)bracket_holes();
    }
}
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


module bracket(){
    difference(){
        bracket_plastic();
        bracket_holes();
    }
}

module bracket_plastic(){
    
    hull(){
        translate([0,0,-10])

        cube([50,50,1], center=true);
        translate([0,0,10])
            cube([60,50,1], center=true);
    }

}
module bracket_holes(){
    // Mounting screws
    mirrorCopy([1,0,0])mirrorCopy([0,1,0])
    translate([17,17,5])rotate([180,0,0])
    screw();

    // Mounting bolt
    translate([0,-20,0])rotate([90,90,0])metricCapheadAndBolt(6, 40, recessCap = 50, recessNut=50, chamfer = false);
}


module brackets(){
    mirrorCopy(){
        translate(bracketTranslation)
            bracket();
    }
}
translate([0,0,17.5]){
    if($preview){
        cradle();
        
        translate([0,0,20]){
            drop();
        }

        translate([0,20,0]){
            brackets();
        }
    }else{
        
        cradle();
        mirrorCopy()translate([130,0,-7])rotate([0,180,0])bracket();
        translate([0,60,-70]){
                drop();
            }
    }
}